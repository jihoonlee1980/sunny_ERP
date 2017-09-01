package com.menu.model;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class MemberDTO {
	int num, login_fail_count, authority;
	String id, name, pass, company, hp, email, address, level, saved_filename, origin_filename, is_account_lock,
			postcode, detailed_address, lock_reason;
	MultipartFile profile_image_file;
	Timestamp joindate;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getLogin_fail_count() {
		return login_fail_count;
	}

	public void setLogin_fail_count(int login_fail_count) {
		this.login_fail_count = login_fail_count;
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

	public String getSaved_filename() {
		return saved_filename;
	}

	public void setSaved_filename(String saved_filename) {
		this.saved_filename = saved_filename;
	}

	public String getOrigin_filename() {
		return origin_filename;
	}

	public void setOrigin_filename(String origin_filename) {
		this.origin_filename = origin_filename;
	}

	public String getIs_account_lock() {
		return is_account_lock;
	}

	public void setIs_account_lock(String is_account_lock) {
		this.is_account_lock = is_account_lock;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getDetailed_address() {
		return detailed_address;
	}

	public void setDetailed_address(String detailed_address) {
		this.detailed_address = detailed_address;
	}

	public String getLock_reason() {
		return lock_reason;
	}

	public void setLock_reason(String lock_reason) {
		this.lock_reason = lock_reason;
	}

	public int getAuthority() {
		return authority;
	}

	public void setAuthority(int authority) {
		this.authority = authority;
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