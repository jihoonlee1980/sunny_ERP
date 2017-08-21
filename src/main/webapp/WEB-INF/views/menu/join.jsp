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
		})
	});
	
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
						<form action="/join/proc" class="form-horizontal track-event-form bv-form" method="post" enctype="multipart/form-data">
							<div class="form-group">
			              		<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-user"></i>
			                            </div>
			                    			<input type="text" class="form-control" id="name" placeholder="이름" 
			                    				name="name" required="required">
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
										<input type="text" class="form-control" id="id" placeholder="아이디" name="id"
											required="required">
									</div>
			                    </div>
								<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-lock"></i>
			                            </div>
			                    		<input type="password" class="form-control" id="pass" placeholder="비밀번호" 
			                    			name="pass" required="required">
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
			                            <input type="text" class="form-control" id="email" placeholder="이메일" name="email" required="required">
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
								<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-file-image-o"></i>
										</div>
										<input type="file" class="form-control" id="profile_image_file" name="profile_image_file">
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