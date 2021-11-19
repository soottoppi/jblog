package com.douzone.jblog.controller;

import java.util.Optional;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.douzone.jblog.security.Auth;
import com.douzone.jblog.security.AuthUser;
import com.douzone.jblog.service.BlogService;
import com.douzone.jblog.vo.BlogVo;
import com.douzone.jblog.vo.PostVo;
import com.douzone.jblog.vo.UserVo;
import com.douzone.mysite.exception.GalleryServiceException;

@Controller
@RequestMapping("/{id:(?!assets).*}")
public class BlogController {
	@Autowired
	ServletContext servletContext;

	
	@Autowired
	private BlogService blogService;

	@RequestMapping({ "", "/{categoryNo}", "/{categoryNo}/{postNo}" })
	public String main(@PathVariable("id") String id,
						@PathVariable("categoryNo") Optional<Long> categoryNo,
						@PathVariable("postNo") Optional<Long> postNo, 
						Model model) {
		// 개인 블로그 제목, 로고 이미지 가져오기 
		BlogVo blog = blogService.getBlog(id);
		if(blog == null) {
			return "redirect:/";
		}
		servletContext.setAttribute("blog", blog);
		
		// 카테고리 번호, 이름 가져오기
		model.addAttribute("categoryList", blogService.findCategoryNoAndName(id));
		
		// 게시글 리스트 가져오기(디폴트 카테고리는 첫 카테고리로)
		Long defaultCategoryNo = blogService.findDefaultCategoryNo(id);
		model.addAttribute("postList", blogService.findPostList(categoryNo.orElse(defaultCategoryNo)));
		
		// 선택한 게시글의 내용을 보여주기
		Long defaultPostNo = blogService.findDefaultPostNo(categoryNo.orElse(defaultCategoryNo)); 
		model.addAttribute("postVo", blogService.findPost(postNo.orElse(defaultPostNo)));
		model.addAttribute("id", id);
		
		return "/blog/blog-main";
	}

	@Auth
	@RequestMapping(value="/admin/basic", method=RequestMethod.GET)
	public String adminBasic(@PathVariable("id") String id,
			Model model) {
		model.addAttribute("id", id);
		return "/blog/blog-admin-basic";
	}
	
	@Auth
	@RequestMapping(value="/admin/basic", method=RequestMethod.POST)
	public String adminBasic(@AuthUser UserVo authUser,
				@PathVariable("id") String id, 
				@RequestParam("file") MultipartFile file,
				BlogVo blogVo) {
		try {
			String url = blogService.saveImg(file);
			blogVo.setLogo(url);
		} catch (GalleryServiceException e) {
			System.out.println("이미지 파일을 선택하지 않았습니다.");
		}
		blogVo.setId(id);
		blogService.update(blogVo);
		servletContext.setAttribute("blog", blogVo);
		return "/blog/blog-admin-basic";
	}

	@Auth
	@RequestMapping("/admin/category")
	public String adminCategory() {
		return "/blog/blog-admin-category";
	}

	
	@Auth
	@RequestMapping(value = "/admin/write", method = RequestMethod.GET)
	public String adminWrite(@AuthUser UserVo authUser,
							Model model) {
		model.addAttribute("list", blogService.findCategoryNoAndName(authUser.getId()));
		return "/blog/blog-admin-write";
	}
	
	@Auth
	@RequestMapping(value = "/admin/write", method = RequestMethod.POST)
	public String adminWrite(@AuthUser UserVo authUser,
								PostVo postVo) {
		blogService.write(postVo);
		return "redirect:/" + authUser.getId() + "/admin/write";
	}
	
}
