package com.menu.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class MemberDAO extends SqlSessionDaoSupport {
	public void insert(MemberDTO memberDTO) {
		getSqlSession().insert("insertMember", memberDTO);
	}

	public int checkCertification_key(String certification_key) {
		return getSqlSession().selectOne("checkCertification_key", certification_key);
	}

	public List<MemberDTO> getList() {
		return getSqlSession().selectList("memberList");
	}

	public int getCount() {
		return getSqlSession().selectOne("memberCount");
	}

	public MemberDTO login(MemberDTO memberDTO) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("id", memberDTO.getId());
		map.put("pass", memberDTO.getPass());

		return getSqlSession().selectOne("loginMember", map);
	}
}
