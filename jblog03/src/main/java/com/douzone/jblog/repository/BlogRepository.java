package com.douzone.jblog.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.douzone.jblog.vo.BlogVo;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.PostVo;

@Repository
public class BlogRepository {
	@Autowired
	private SqlSession sqlSession;

	public BlogVo find(String id) {
		return sqlSession.selectOne("blog.find", id);
	}

	public boolean update(BlogVo blogVo) {
		return sqlSession.update("blog.basicUpdate", blogVo) == 1;

	}

	public List<CategoryVo> findList(String id) {
		return sqlSession.selectList("category.findCategoryList", id) ;
	}

	public boolean addCategory(CategoryVo categoryVo) {
		return sqlSession.insert("category.addCategory", categoryVo) == 1;
	}

	public boolean makeBlog(String id) {
		return sqlSession.insert("blog.makeBlog", id) == 1;
	}

	public boolean defaultCategory(String id) {
		return sqlSession.insert("category.defaultCategory", id) == 1;
	}

	public List<CategoryVo> findCategoryNoAndName(String id) {
		return sqlSession.selectList("category.findCategoryNoAndName", id);
	}

	public void write(PostVo postVo) {
		sqlSession.insert("post.write",postVo);
	}

	public boolean delete(Long no) {
		return sqlSession.delete("category.delete", no) == 1;
	}

	public List<PostVo> findPostList(Long categoryNo) {
		return 	sqlSession.selectList("post.findPostList", categoryNo);
	}

	public Long findDefaultCategoryNo(String id) {
		return sqlSession.selectOne("category.findDefaultCategoryNo", id);
	}

	public Long findDefaultPostNo(Long defaultCategoryNo) {
		return sqlSession.selectOne("post.findDefaultPostNo", defaultCategoryNo);
	}

	public PostVo findPost(Long postNo) {
		return sqlSession.selectOne("post.findPost", postNo);
	}

	public CategoryVo findCategoryItem(String blogId) {
		return sqlSession.selectOne("category.findCategoryItem", blogId);
	}
	
	
}
