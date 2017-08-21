package com.menu.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class NoticeDAO extends SqlSessionDaoSupport {
	public void insert(NoticeDTO noticeDTO) {
		getSqlSession().insert("insertNotice", noticeDTO);
	}

	public void updateReadCount(int num) {
		getSqlSession().update("updateReadCount", num);
	}

	public void update(NoticeDTO noticeDTO) {
		getSqlSession().update("updateNotice", noticeDTO);
	}

	public void delete(int num) {
		getSqlSession().delete("deleteNotice", num);
	}

	public List<NoticeDTO> getList(int start, int perpage) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("perpage", perpage);
		return getSqlSession().selectList("noticeList", map);
	}

	public int getCount() {
		return getSqlSession().selectOne("noticeCount");
	}

	public NoticeDTO get(int num) {
		return getSqlSession().selectOne("noticeContent", num);
	}
}
