package com.menu.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class MemberDAO extends SqlSessionDaoSupport {
	public MemberDTO get(int num) {
		return getSqlSession().selectOne("getMemberInt", num);
	}

	public MemberDTO get(String id) {
		return getSqlSession().selectOne("getMemberStr", id);
	}

	public void insert(MemberDTO memberDTO) {
		getSqlSession().insert("insertMember", memberDTO);
	}

	public int checkCertification_key(String certification_key) {
		return getSqlSession().selectOne("checkCertification_key", certification_key);
	}

	public int getCount() {
		return getSqlSession().selectOne("memberCount");
	}

	public int getCount(String search_type, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("search_type", search_type);
		map.put("keyword", keyword);

		return getSqlSession().selectOne("searchMemberCount", map);
	}

	public MemberDTO login(MemberDTO memberDTO) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("id", memberDTO.getId());
		map.put("pass", memberDTO.getPass());

		return getSqlSession().selectOne("loginMember", map);
	}

	public int checkMemberID(String id) {
		return getSqlSession().selectOne("checkMemberID", id);
	}

	public int checkMemberFilename(String id) {
		return getSqlSession().selectOne("checkMemberFilename", id);
	}

	public void initLoginFailCount(String id) {
		getSqlSession().update("initLoginFailCount", id);
	}

	public void increaseLoginFailCount(String id) {
		getSqlSession().update("increaseLoginFailCount", id);
	}

	public void alterAccountLock(String id, String isLock) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("id", id);
		map.put("isLock", isLock);

		getSqlSession().update("alterAccountLock", map);
	}

	public MemberDTO update(MemberDTO memberDTO, String type) {
		if ("profile".equals(type))
			getSqlSession().update("updateProfile", memberDTO);
		else if ("call".equals(type))
			getSqlSession().update("updateCall", memberDTO);
		else if ("pass".equals(type))
			getSqlSession().update("updatePass", memberDTO);
		else if ("lock".equals(type))
			getSqlSession().update("updateLock", memberDTO);
		else if ("auth".equals(type))
			getSqlSession().update("updateAuth", memberDTO);

		return getSqlSession().selectOne("getMemberInt", memberDTO.num);
	}

	public boolean passUpdateCheck(int num, String pass) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("num", num);
		map.put("pass", pass);

		return getSqlSession().selectOne("passUpdateCheck", map) != null ? true : false;
	}

	public void deleteMember(int num, String id) {
		getSqlSession().delete("deleteWriterCascade", id);
		getSqlSession().delete("deleteMember", num);
	}

	public List<MemberDTO> getList(int start, int perPage, String sort) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("start", start);
		map.put("perPage", perPage);
		map.put("sort", sort);

		return getSqlSession().selectList("memberList", map);
	}

	public List<MemberDTO> searchList(int start, int perPage, String sort, String search_type, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("start", start);
		map.put("perPage", perPage);
		map.put("sort", sort);
		map.put("search_type", search_type);
		map.put("keyword", keyword);

		return getSqlSession().selectList("memberSearchList", map);
	}
	
	public void updateCertification_key(String certification_key){
		getSqlSession().update("updateCertification_key", certification_key);
	}
}
