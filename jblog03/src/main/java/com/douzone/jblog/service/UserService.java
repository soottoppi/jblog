package com.douzone.jblog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.jblog.repository.BlogRepository;
import com.douzone.jblog.repository.UserRepository;
import com.douzone.jblog.vo.UserVo;

@Service
public class UserService {

	@Autowired
	UserRepository userRepository;

	@Autowired
	BlogRepository blogRepository;
	
	
	public boolean join(UserVo userVo) {
		// 회원가입
		userRepository.join(userVo);
		
		// 회원가입 시 해당 유저의 개인 블로그 생성
		blogRepository.makeBlog(userVo.getId());
		
		// 개인 블로그 생성 시 미분류 카테고리 지정
		return blogRepository.defaultCategory(userVo.getId());
	}

	public UserVo getUser(String id, String password) {
		return userRepository.getUser(id, password);
	}

	public UserVo getUser(String id) {
		return userRepository.findById(id);
	}

}
