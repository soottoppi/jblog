package com.douzone.jblog.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.douzone.jblog.repository.BlogRepository;
import com.douzone.jblog.vo.BlogVo;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.PostVo;
import com.douzone.mysite.exception.GalleryServiceException;

@Service
public class BlogService {
	private static String SAVE_PATH = "/upload-jblog";
	private static String URL_BASE = "/assets/blog/images";

	@Autowired
	BlogRepository blogRepository;

	public String saveImg(MultipartFile file) {
		try {
			File uploadDirectory = new File(SAVE_PATH);
			if(!uploadDirectory.exists()) {
				uploadDirectory.mkdir();
			}

			if(file.isEmpty()) {
				throw new GalleryServiceException("file upload error: image empty");
			}

			String originFilename = file.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf('.') + 1);
			String saveFilename = generateSaveFilename(extName);

			byte[] data = file.getBytes();
			OutputStream os = new FileOutputStream(SAVE_PATH + "/" + saveFilename);
			os.write(data);
			os.close();

			return URL_BASE + "/" + saveFilename;

			
		} catch(IOException ex) {
			throw new GalleryServiceException("file upload error:" + ex);
		}
	}

	private String generateSaveFilename(String extName) {
		String filename = "";
		
		Calendar calendar = Calendar.getInstance();
		
		filename += calendar.get(Calendar.YEAR);
		filename += calendar.get(Calendar.MONTH);
		filename += calendar.get(Calendar.DATE);
		filename += calendar.get(Calendar.HOUR);
		filename += calendar.get(Calendar.MINUTE);
		filename += calendar.get(Calendar.SECOND);
		filename += calendar.get(Calendar.MILLISECOND);
		filename += ("." + extName);
		
		return filename;
	}
	
	public BlogVo getBlog(String id) {
		return blogRepository.find(id);
	}

	public boolean update(BlogVo blogVo) {
		return blogRepository.update(blogVo);
	}

	public List<CategoryVo> list(String id) {
		return blogRepository.findList(id);
	}

	public boolean add(CategoryVo categoryVo) {
		return blogRepository.addCategory(categoryVo);
	}

	public List<CategoryVo> findCategoryNoAndName(String id) {
		return blogRepository.findCategoryNoAndName(id);
	}

	public void write(PostVo postVo) {
		blogRepository.write(postVo);
	}

	public void delete(Long no) {
		blogRepository.delete(no);
	}

	public List<PostVo> findPostList(Long categoryNo) {
		return blogRepository.findPostList(categoryNo);
	}

	public Long findDefaultCategoryNo(String id) {
		return blogRepository.findDefaultCategoryNo(id);
	}

	public Long findDefaultPostNo(Long defaultCategoryNo) {
		return blogRepository.findDefaultPostNo(defaultCategoryNo);
	}

	public PostVo findPost(Long postNo) {
		return blogRepository.findPost(postNo);
	}


}
