package com.menu.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class ErpBoardDAO extends SqlSessionDaoSupport {
	public void insert(ErpBoardDTO erpBoardDTO) {
		getSqlSession().insert("insertErpBoard", erpBoardDTO);
	}

	public void updateReadCount(int num) {
		getSqlSession().update("updateReadCount", num);
	}

	public void updateEvent(ErpBoardDTO erpBoardDTO) {
		getSqlSession().update("updateEvent", erpBoardDTO);
	}
	public void updateNotice(ErpBoardDTO erpBoardDTO) {
		getSqlSession().update("updateNotice", erpBoardDTO);
	}

	public void delete(int num) {
		getSqlSession().delete("deleteBoardCascade", num);
		getSqlSession().delete("deleteErpBoard", num);
	}

	public List<ErpBoardDTO> getList(int start, int perpage, int delim) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("perpage", perpage);
		map.put("delim", delim);
		return getSqlSession().selectList("erpBoardList", map);
	}

	public int getCount(int delim) {
		return getSqlSession().selectOne("erpBoardCount", delim);
	}

	public ErpBoardDTO get(int num) {
		return getSqlSession().selectOne("erpBoardContent", num);
	}

	public int checkEventFilename(String saved_filename) {
		return getSqlSession().selectOne("checkFilename", saved_filename);
	}

	public void updateCommentCount(int num, int countValue) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("num", num);
		map.put("countValue", countValue);

		getSqlSession().update("updateCommentCount", map);
	}
}
