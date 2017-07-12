package spring.trip.model.dao.impl;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.trip.domain.Story;
import spring.trip.model.dao.StoryDAO;

@Repository
public class StoryDAOImpl implements StoryDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String getStoryLocation(String StoryLocation) throws Exception{
		return StoryLocation;
	}
   
	@Override
	public void insertStoryInfo(Story story) throws Exception{
		sqlSession.insert("storyMapper.insertStoryInfo", story);
	}
   
	@Override
	public void updateStory(Story story) throws Exception{
		sqlSession.update("storyMapper.updateStory", story);
	}
   
	@Override
	public void deleteStory(String storyNo) throws Exception{
		sqlSession.delete("storyMapper.deleteStory", storyNo);
	}
   
	@Override
	public Story showStory(String storyNo) throws Exception{
		return sqlSession.selectOne("storyMapper.showStory", storyNo);
	}
   
	@Override
	public void upStoryHit(String storyNo) throws Exception{
		sqlSession.update("storyMapper.upStoryHit", storyNo);
	}

	@Override
	public List<Story> showStoryList(String bookNo) throws Exception {
		return sqlSession.selectList("storyMapper.showStoryList", bookNo);
	}

	@Override
	public void deleteUrl(String storyNo) throws Exception {
		sqlSession.update("storyMapper.deleteUrl", storyNo);
	}

	@Override
	public void updateBookmark(String storyNo) throws Exception {
		sqlSession.update("storyMapper.updateBookmark",storyNo);
	}

	@Override
	public Story getStoryByStoryNo(String storyNo) throws Exception {
		return sqlSession.selectOne("storyMapper.getStoryByStoryNo", storyNo);
	}

	@Override
	public void deleteStoryBookmark(String storyNo) throws Exception {
		sqlSession.update("storyMapper.deleteStoryBookmark", storyNo);
	}

	@Override
	public List<Story> allStoryList() throws Exception {
		return sqlSession.selectList("storyMapper.allStoryList");
	}

	@Override
	public List<Story> otherStoryList(String email) throws Exception {
		return sqlSession.selectList("storyMapper.otherStoryList",email);
	}

	@Override
	public List<Story> searchStory(String keyword) throws Exception {
		return sqlSession.selectList("storyMapper.searchStory", keyword);
	}

	@Override
	public List<Story> searchStoryByTitle(String keyword) throws Exception {
		return sqlSession.selectList("storyMapper.searchStoryByTitle", keyword);
	}

	@Override
	public List<Story> searchStoryByContent(String keyword) throws Exception {
		return sqlSession.selectList("storyMapper.searchStoryByContent", keyword);
	}

	@Override
	public List<Story> searchStoryByLocation(String keyword) throws Exception {
		return sqlSession.selectList("storyMapper.searchStoryByLocation", keyword);
	}
}