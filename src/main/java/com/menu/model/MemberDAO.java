package com.menu.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;


public class MemberDAO extends SqlSessionDaoSupport{
	public List<EventBoardDTO> getList(int start, int perpage) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("perpage", perpage);
		System.out.println("start : "+start);
		return getSqlSession().selectList("eventBoardList", map);
	}
	public int getCount(){
		return getSqlSession().selectOne("eventBoardCount");
	}
}
