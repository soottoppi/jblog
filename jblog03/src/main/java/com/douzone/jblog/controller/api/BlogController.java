package com.douzone.jblog.controller.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.douzone.jblog.security.Auth;
import com.douzone.jblog.security.AuthUser;
import com.douzone.jblog.service.BlogService;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.UserVo;
import com.douzone.mysite.dto.JsonResult;

@RestController("blogApiController")
@RequestMapping("/api/{id:(?!assets).*}")
public class BlogController {
    @Autowired
    private BlogService blogService;

    @Auth
    @ResponseBody
    @RequestMapping("/admin/category")
    public JsonResult adminCategory(@AuthUser UserVo authUser) {
	List<CategoryVo> categoryList = blogService.list(authUser.getId());
	return JsonResult.success(categoryList);
    }

    @Auth
    @ResponseBody
    @RequestMapping(value = "/admin/category", method = RequestMethod.POST)
    public JsonResult adminCategory(@AuthUser UserVo authUser, @RequestBody CategoryVo categoryVo) {
	categoryVo.setBlogId(authUser.getId());
	blogService.add(categoryVo);
	CategoryVo vo = blogService.findCategoryItem(categoryVo.getBlogId());
	System.out.println(vo);
	return JsonResult.success(vo);
    }

    @Auth
    @ResponseBody
    @RequestMapping(value = "/admin/category/delete", method = RequestMethod.POST)
    public JsonResult adminDelete(@AuthUser UserVo authUser, 
	    			        Long no) {
    System.out.println("controller 진입" + no);
	boolean result = blogService.delete(no);
	Long data = result ? no : -1L;
	return JsonResult.success(data);
    }

}
