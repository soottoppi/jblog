package com.douzone.jblog.repository;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.douzone.jblog.vo.UserVo;

@Repository
public class UserRepository {
	@Autowired
	private SqlSession sqlSession;

	public boolean join(UserVo userVo) {
		return sqlSession.insert("user.join", userVo) == 1;
	}

	public UserVo getUser(String id, String password) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("password", password);
		return sqlSession.selectOne("user.findByIdAndPassword", map);
	}

	public UserVo findById(String id) {
		return sqlSession.selectOne("user.findById", id);
	}
	
}

