package com.menu.model;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class MemberDTO {
	int num;
	String id, name, pass, company, hp, email, address, level, profile_image;
	MultipartFile profile_image_file;
	Timestamp joindate;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getProfile_image() {
		return profile_image;
	}

	public void setPorfile_image(String profile_image) {
		this.profile_image = profile_image;
	}

	public MultipartFile getProfile_image_file() {
		return profile_image_file;
	}

	public void setProfile_image_file(MultipartFile profile_image_file) {
		this.profile_image_file = profile_image_file;
	}

	public Timestamp getJoindate() {
		return joindate;
	}

	public void setJoindate(Timestamp joindate) {
		this.joindate = joindate;
	}

}
