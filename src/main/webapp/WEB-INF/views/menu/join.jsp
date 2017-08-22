<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page session="false"%>
<c:set var="root_" value="<%=request.getContextPath() %>" />
<c:set var="root" value="${root_}/resources" />
<script type="text/javascript">
	$(function(){
		certification_activate(true);
		
		$("#level").change(function(){
			if(this.selectedIndex > 1)
				certification_activate(false);
			else{
				$("#certification_key").val("");
				certification_activate(true);
			}
		});
	});
	
	function idValidCheck(){
		var reg_id = /[a-zA-Z0-9]{8,16}$/g;
		
		if(!reg_id.test($("#id").val())){
			alert("아이디는 영어 대소문자와 숫자조합으로 8~16자만 가능합니다.");
			return;
		}
		
		$.ajax({
			url : "/join/id",
			type : "get",
			data : {"id" : $("#id").val()},
			dataType : "json",
			success : function(data){
				if(data.isValid){
					alert("사용가능한 아이디 입니다.");
					$("#IDcheckBtn").prop("disabled", true);
				} else {
					alert("이미 사용중인 아이디 입니다.");
				}
			},
			statusCode : {
				404 : function() {
					alert("해당 데이터 존재X");
				},
				500 : function() {
					alert("서버 혹은 문법적 오류");
				}
			}
		});
	}
	
	function submitCheck(){
		var reg_id = /[a-zA-Z0-9]{8,16}$/g;
		var reg_pass = /[a-zA-Z0-9]{8,20}$/g;
		var reg_hp = /^((010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-\d{4}$/g;
		var check = true;
		
		if(!reg_id.test($("#id").val())){
			alert("아이디는 영어 대소문자와 숫자조합으로 8~16자만 가능합니다.");
			check = false;
		}
		
		if(!reg_pass.test($("#pass").val())){
			alert("비밀번호는 영어와 숫자조합으로 8~20자만 가능합니다.(대소문자 구분 없음.)")
			check = false;
		}
		
		if($("#pass").val() != $("#checkPass").val()){
			alert("비밀번호가 서로 다릅니다.");
			check = false;
		}
		
		if(!reg_hp.test($("#hp").val().replace(" ",""))){
			alert("휴대폰 번호를 확인해 주세요(예.010-1234-1234)");
			check = false;
		}
		
		if(!$("#IDcheckBtn").is(":disabled")){
			alert("아이디 중복체크를 해주세요.")
			check = false;
		}
		
		return check;
	}
	
	function certification_activate(value){
		$("#certification_key").prop("disabled", value);
		$("#certification_btn").prop("disabled", value)
	}
</script>
<!-- Header -->
<div class="banner event_banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>회원가입</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
	<div class="container">
		<div class="row">
			<div class="col-md-2"> </div>
			<div class="col-md-8">
				<h1>회원가입</h1>
				<p class="lead">서비스 이용에는 로그인이 필요합니다.</p>
				<p>회원가입을 위해 다음과 같은 항목들을 입력해주세요.</p> <br> 
			        <!-- BEGIN DOWNLOAD PANEL -->
				<div class="panel panel-default well">
					<div class="panel-body">
						<form action="/join/proc" class="form-horizontal track-event-form bv-form" method="post" enctype="multipart/form-data" onsubmit="return submitCheck();">
							<div class="form-group">
			              		<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-user"></i>
			                            </div>
			                    			<input type="text" class="form-control" id="name" placeholder="이름" name="name" required="required">
			                    	</div>
								</div>          
								<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-briefcase"></i>
			                            </div>
			                            <input type="text" class="form-control" id="company" placeholder="회사명" name="company" required="required">
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-id-card"></i>
										</div>
										<input type="text" class="form-control" id="id" placeholder="아이디" name="id" required="required" maxlength="16"  style="width:80.5%">
										<button type="button" id="IDcheckBtn" class="btn btn-success" onclick="idValidCheck();">확인</button>
									</div>
			                    </div>
			                    <div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-file-image-o"></i>
										</div>
										<input type="file" class="form-control" id="profile_image_file" name="profile_image_file" accept="image/*">
									</div>
								</div>     
							</div>
							<div class="form-group">
								 <div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-lock"></i>
			                            </div>
			                    		<input type="password" class="form-control" id="pass" placeholder="비밀번호" name="pass" required="required" maxlength="20">
			                        </div>
								</div>  
								 <div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-lock"></i>
			                            </div>
			                    		<input type="password" class="form-control" id="checkPass" placeholder="비밀번호 확인" required="required" maxlength="20">
			                        </div>
								</div>   
							</div>
							<div class="form-group">               
								<div class="col-sm-6">
									 <div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-sitemap"></i>          
										</div>                        
					                    <select data-placeholder="level" class="C_Country_Modal form-control" id="level" name="level" required="required">
											<option value="" >-- 직  급 --</option>
											<option value="일반">일  반</option>
											<option value="사원">사  원</option>
											<option value="임원">임  원</option>
					                   	</select>
					                  </div>
								</div>
								<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-key"></i>
										</div>
					                    <input type="text" class="form-control" id="certification_key" placeholder="인증코드" name="certification_key" style="width:80.5%">
					                    <button type="button" id="certification_btn" class="btn btn-success">확인</button>
									</div>
								</div>            
							</div>
										              
							<div class="form-group">
								<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-mobile"></i>
										</div>
					                    <input type="text" class="form-control" id="hp" placeholder="핸드폰 번호" name="hp" required="required">
									</div>                                    
								</div>  
								<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-envelope"></i>
										</div>
			                            <input type="email" class="form-control" id="email" placeholder="이메일" name="email" required="required">
			                        </div>
								</div>                
							</div>
							
							<div class="form-group">
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-address-card-o"></i>
										</div>
										<input type="text" class="form-control" id="address" placeholder="주소" name="address" style="width:86%;" required="required">
										<button type="button" class="btn btn-info">주소검색</button>
									</div>
								</div>
							</div>
			                      
							<div class="form-group">
								<div class="col-sm-12">
									<button id="contacts-submit" type="submit" class="btn btn-default btn-info" style="float:right;">회원가입</button>
								</div>
							</div>
						</form>
					</div><!-- end panel-body -->
				</div><!-- end panel -->
			</div><!-- end col-md-8 -->
			<div class="col-md-2"></div>
		</div>
	</div> <!--  container end -->
</div>
<!-- <a name="contact"></a> -->
<div class="banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>Cloud Global Service</h2>
			</div>
		</div>
	</div>
</div>