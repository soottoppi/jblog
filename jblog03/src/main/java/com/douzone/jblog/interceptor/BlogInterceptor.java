package com.douzone.jblog.interceptor;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.douzone.jblog.service.BlogService;
import com.douzone.jblog.vo.BlogVo;

public class BlogInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	private BlogService blogService;

	@Autowired
	ServletContext servletContext;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		BlogVo authUser = (BlogVo)request.getAttribute("authUser");
		BlogVo blog = (BlogVo) servletContext.getAttribute("blog");
		if(blog == null) {
			BlogVo vo = blogService.getBlog(authUser.getId());
			servletContext.setAttribute("blog", vo);
		}
		
		return true;
	}
	
	
}
