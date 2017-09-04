package com.menu.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class CommentDAO extends SqlSessionDaoSupport {
	// delete함수 맨위에
	public void deleteComment(int num) {
		getSqlSession().delete("deleteComment", num);
		getSqlSession().delete("deleteCommentCascade", num);
	}

	public void deleteReply(int num) {
		getSqlSession().delete("deleteComment", num);
	}

	// delete 끝
	public void insertComment(CommentDTO commentDTO) {
		getSqlSession().insert("insertComment", commentDTO);
	}

	public void insertReply(CommentDTO commentDTO) {
		getSqlSession().insert("insertReply", commentDTO);
	}

	public List<CommentDTO> commentList(int board_num) {
		return getSqlSession().selectList("commentList", board_num);
	}

	public List<CommentDTO> replyList(int comment_num) {
		return getSqlSession().selectList("replyList", comment_num);
	}

	public void updateReplyCount(int num, int countValue) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("num", num);
		map.put("countValue", countValue);

		getSqlSession().update("updateReplyCount", map);
	}
	
	public void update(CommentDTO commentDTO){
		getSqlSession().update("updateComment", commentDTO);
	}
	
	public List<HashMap<String, Object>> getReplyCountOnDeleteMember(String id){
		return getSqlSession().selectList("getReplyCountOnDeleteMember", id);
	}
	
	public List<HashMap<String, Object>> getCommentCountOnDeleteMember(String id){
		return getSqlSession().selectList("getCommentCountOnDeleteMember", id);
	}

	public void setSqlSessionTemplate(Object arg0) {
		// TODO Auto-generated method stub
		
	}
}
