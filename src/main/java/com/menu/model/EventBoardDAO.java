package com.menu.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class EventBoardDAO extends SqlSessionDaoSupport {
	public void insert(EventBoardDTO eventBoardDTO) {
		getSqlSession().insert("insertEventBoard", eventBoardDTO);
	}

	public void updateReadCount(int num) {
		getSqlSession().update("updateReadCount", num);
	}

	public void update(EventBoardDTO eventBoardDTO) {
		getSqlSession().update("updateEventBoard", eventBoardDTO);
	}

	public void delete(int num) {
		getSqlSession().delete("deleteEventBoard", num);
	}

	public List<EventBoardDTO> getList(int start, int perpage) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("perpage", perpage);
		return getSqlSession().selectList("eventBoardList", map);
	}

	public int getCount() {
		return getSqlSession().selectOne("eventBoardCount");
	}

	public EventBoardDTO get(int num) {
		return getSqlSession().selectOne("eventBoardContent", num);
	}
}
