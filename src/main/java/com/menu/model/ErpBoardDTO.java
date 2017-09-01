package com.menu.model;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class ErpBoardDTO {
	int num, readcount, delim, comment_count;
	String writer, subject, category, content, origin_filename, saved_filename;
	Timestamp writeday;
	MultipartFile attached_file;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getComment_count() {
		return comment_count;
	}

	public int getDelim() {
		return delim;
	}

	public void setDelim(int delim) {
		this.delim = delim;
	}

	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOrigin_filename() {
		return origin_filename;
	}

	public void setOrigin_filename(String origin_filename) {
		this.origin_filename = origin_filename;
	}

	public String getSaved_filename() {
		return saved_filename;
	}

	public void setSaved_filename(String saved_filename) {
		this.saved_filename = saved_filename;
	}

	public Timestamp getWriteday() {
		return writeday;
	}

	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}

	public MultipartFile getAttached_file() {
		return attached_file;
	}

	public void setAttached_file(MultipartFile attached_file) {
		this.attached_file = attached_file;
	}

}
