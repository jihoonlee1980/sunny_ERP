<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page session="false"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<c:set var="root_" value="<%=request.getContextPath() %>" />
<c:set var="root" value="${root_}/resources" />
<link href="${root }/css/fancy-tab.css" rel="stylesheet">
<style>
.content-div {
	padding-top: 10px;
	float: left;
	height: 100%;
}
.modal-header-primary {
    color:#fff;
    padding:9px 15px;
    border-bottom:1px solid #eee;
    background-color: #428bca;
    -webkit-border-top-left-radius: 5px;
    -webkit-border-top-right-radius: 5px;
    -moz-border-radius-topleft: 5px;
    -moz-border-radius-topright: 5px;
     border-top-left-radius: 5px;
     border-top-right-radius: 5px;
}
</style>
<script type="text/javascript">
	$(function(){
		certification_activate(true);
		
		$("#level").change(function(){
			if(this.selectedIndex > 1){
				certification_activate(false);
			}
			else{
				$("#certification_key").val("");
				certification_activate(true);
			}
		});
	});	
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $("#postcode").val(data.zonecode); //5자리 새우편번호 사용
                $("#address").val(fullAddr);

                // 커서를 상세주소 필드로 이동한다.
                $("#detailed_address").val("");
                $("#detailed_address").focus();
            }
        }).open();
    }
	
    function checkCertification_key(){
		$.ajax({
			url : "/join/checkCK",
			type : "post",
			data : {"certification_key" : $("#certification_key").val()},
			dataType : "json",
			success : function(data){
				if(data.isValid){
					swal({
						title : "",
		   				text : "인증 되었습니다.",
		   				type : "success",
		   				confirmButtonText: "확인"
		   			});
					certification_activate(true);
				} else {
					swal({
						title : "",
   						text : "인증번호를 확인하세요",
	   					type : "warning",
	   					confirmButtonText: "확인"
		   			});
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
	
	function profileSubmitCheck(){
		var check = true;
		
		if(!$("#certification_btn").is(":disabled")){
			callSwal("", "인증 확인을 해주세요.", "warning", "확인");
			check = false;
		}
		
		return check;
	}
	
	function callSubmitCheck(){
		var reg_hp = /^((010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-\d{4}$/g;
		var check = true;
		
		if(!reg_hp.test($("#hp").val().replace(" ",""))){
			//alert("휴대폰 번호를 확인해 주세요(예.010-1234-1234)");
			callSwal("", "휴대폰 번호를 확인해 주세요(예.010-1234-1234)", "warning", "확인");
			check = false;
		}
		
		return check;
	}
	
	function checkPass(num, pass){
		var result;
		
		$.ajax({
			url : "/checkpass",
			type : "post",
			data : {"num" : num, "pass" : pass},
			dataType : "json",
			async: false,
			success : function(data){
				result =  data.result;
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
		
		return result;
	}
	
	function passSubmitCheck(num){
		var reg_pass = /[a-zA-Z0-9]{8,20}$/g;
		var check = true;
		
		if(!checkPass(num, $("#current_pass").val())){
			callSwal("", "현재 비밀번호가 틀렸습니다.", "warning", "확인");
			check = false;
		}
		
		if(!reg_pass.test($("#current_pass").val())){
			callSwal("", "비밀번호는 영어와 숫자조합으로만 가능합니다.\n(8~20자, 대소문자 구분 없음.)", "warning", "확인");
			check = false;
		}
		
		reg_pass.test(""); //이게 왜 있어야 하는거지
		
		if(!reg_pass.test($("#pass").val())){
			callSwal("", "비밀번호는 영어와 숫자조합으로만 가능합니다.\n(8~20자, 대소문자 구분 없음.)", "warning", "확인");
			check = false;
		}
		
		if($("#current_pass").val() == $("#pass").val()){
			callSwal("", "비밀번호는 이전 비밀번호와 다르게 설정해야 합니다.", "warning", "확인");
			check = false;
		}
		
		if($("#pass").val() != $("#check_new_pass").val()){
			callSwal("", "비밀번호가 서로 다릅니다.", "warning", "확인");
			check = false;
		}
		
		return check;
	}
	
	function selectLevel(level){
		$("#level").find("option").each(function(){
			if($(this).val() == level)
				$(this).attr("selected", "selected");
			if(level == '일반')
				certification_activate(true);
		});
	}
	
	function withdrawal(){
		var div = $("div.delete-form");
		if(div.is(":visible")){
			div.hide();
		} else {
			div.show();
		}
	}
	
	function deleteOnSubmit(num){
		var result = checkPass(num, $("#delete_pass").val());
		
		if(!result){
			callSwal("비밀번호 오류", "비밀번호가 틀렸습니다.", "warning", "확인");
		}
		
		return result;
	}
	
	function certification_activate(value){
		$("#certification_key").prop("readonly", value);
		$("#certification_btn").prop("disabled", value)
	}
	
	function callSwal(title, text, type, confirmText){
		swal({
			title : title,
			text : text,
			type : type,
			confirmButtonText: confirmText
		});
	}
</script>
<!-- Header -->
<div class="banner mypage_banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>마이페이지</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
	<div class="container">
		<div class="[ row ]">
			<div class="[ col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 ]" role="tabpanel">
	            <div class="[ col-xs-4 col-sm-12 ]">
	                <!-- Nav tabs -->
	                <ul class="[ nav nav-justified ]" id="nav-tabs" role="tablist">
	                    <li role="presentation" class="active">
	                        <a href="#profile_div" aria-controls="profile_div" role="tab" data-toggle="tab">
	                            <img class="img-circle" src="${root }/img/main/mp_profile.png" />
	                            <span class="quote"><i class="fa fa-quote-left"></i></span>
	                        </a>
	                    </li>
	                    <li role="presentation" class="">
	                        <a href="#call_div" aria-controls="call_div" role="tab" data-toggle="tab">
	                            <img class="img-circle" src="${root }/img/main/mp_call.png" />
	                            <span class="quote"><i class="fa fa-quote-left"></i></span>
	                        </a>
	                    </li>
	                    <li role="presentation" class="">
	                        <a href="#pass_div" aria-controls="pass_div" role="tab" data-toggle="tab">
	                            <img class="img-circle" src="${root }/img/main/mp_pass.png" />
	                            <span class="quote"><i class="fa fa-quote-left"></i></span>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <div class="[ col-xs-8 col-sm-12 ]">
	                <!-- Tab panes -->
	                <div class="tab-content" id="tabs-collapse">            
	                    <div role="tabpanel" class="tab-pane fade in active" id="profile_div">
	                        <div class="tab-inner">                    
	                        	<div style="width: 100%; text-align: center;">
	                            	<img class="img-circle" src="${root }/profile/${memberDTO.saved_filename}" style="width: 40%;">
	                            </div>
	                            <hr>
	                            <p><strong>이름 : ${memberDTO.name }</strong></p>
	                            <p><strong>회사 : ${memberDTO.company }</strong></p>
	                            <p><strong>주소 : ${memberDTO.address } ${memberDTO.detailed_address }</strong></p>
	                            <c:if test="${memberDTO.level ne '일반' }">
	                            	<p><strong>직급 : ${memberDTO.level }</strong></p>
	                            </c:if>
	                            <span class="help-block"></span>
	                            <div align="right">
		                    		<a class="btn btn-sm btn-default" href="#profile_modal" data-toggle="modal" onclick="selectLevel('${memberDTO.level}')">프로필 수정</a>
		                    		<button type="button" class="btn btn-sm btn-danger" onclick="withdrawal()">회원 탈퇴</button>
		                    	</div>
		                    	<div class="delete-form" style="display: none;">
		                    		<form action="/member/delete" method="get" class="form-horizontal" onsubmit="return deleteOnSubmit('${memberDTO.num}');">
		                    			<div class="form-group">
		                    				<div class="col-sm-12">
		                    					<div style="width: 100%; margin-top: 1%;" align="right">
			                    					<input type="password" id="delete_pass" class="form-control" placeholder="비밀번호" maxlength="20" style="width: 50%; display: inline-block;">
			                    					<input type="hidden" name="num" value="${memberDTO.num }">
			                    					<input type="hidden" name="id" value="${memberDTO.id }">
			                    					<button type="submit" class="btn btn-sm btn-danger">탈퇴</button>
		                    					</div>
		                    				</div>
		                    			</div>
		                    		</form>
		                    	</div>
	                        </div>
	                    </div>
	                    
	                    <div role="tabpanel" class="tab-pane fade" id="call_div">
	                        <div class="tab-inner">
	                        	<p><strong>휴대폰 : ${memberDTO.hp }</strong></p>
	                            <p><strong>E-mail : ${memberDTO.email }</strong></p>
	                            <span class="help-block"></span>
	                            <div align="right">
		                    		<a class="btn btn-sm btn-default" href="#call_modal" data-toggle="modal">연락처 수정</a>
		                    	</div>
	                        </div>
	                    </div>
	                    
	                    <div role="tabpanel" class="tab-pane fade" id="pass_div">
	                    	<div align="center">비밀번호를 변경하시면 자동으로 로그아웃 됩니다.</div>
	                        <div class="tab-inner">
		                    	<form action="/pass/update" class="form-horizontal" method="post" onsubmit="return passSubmitCheck('${memberDTO.num}');">
									<div class="form-group">
										<div class="col-sm-12">
											<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-lock"></i>
					                            </div>
					                    		<input type="password" class="form-control" id="current_pass" placeholder="현재 비밀번호" required="required" maxlength="20">
					                    	</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-12">
											<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-lock"></i>
					                            </div>
					                    		<input type="password" class="form-control" id="pass" name="pass" placeholder="새 비밀번호" required="required" maxlength="20">
					                    	</div>
				                        	<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-lock"></i>
					                            </div>
					                    		<input type="password" class="form-control" id="check_new_pass" placeholder="비밀번호 확인" required="required" maxlength="20">
					                    	</div>
										</div>
									</div>
									<div align="right">
										<input type="hidden" name="num" value="${memberDTO.num }">
										<button type="submit" class="btn btn-sm btn-default">비밀번호 변경</button>
									</div>
								</form>
	                        </div> 
	                    </div>
	                </div>
	            </div>        
	        </div>
		</div>
	</div> <!--  container end -->
</div>

<div class="modal fade" id="profile_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
				<h1><i class="fa fa-user-circle-o"></i>프로필 수정</h1>
			</div>
			<form action="/profile/update" class="form-horizontal" method="post" enctype="multipart/form-data" onsubmit="return profileSubmitCheck();">
	            <div class="modal-body">
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-user"></i>
								</div>
								<input type="text" class="form-control" id="name" name="name" value="${memberDTO.name }">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-briefcase"></i>
								</div>
								<input type="text" class="form-control" id="company" name="company" value="${memberDTO.company }">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
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
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-key"></i>
								</div>
			                    <input type="text" class="form-control" id="certification_key" placeholder="인증코드" name="certification_key" style="width:89.5%">
			                    <button type="button" id="certification_btn" class="btn btn-success" onclick="checkCertification_key();">확인</button>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-address-card-o"></i>
								</div>
								<input type="text" class="form-control" id="postcode" name="postcode" placeholder="우편번호" style="width: 120px;" value="${memberDTO.postcode }">
								<input type="button" class="btn btn-default" value="우편번호 찾기" onclick="daumPostcode()" style="width: 110px">
								<input type="text" class="form-control" id="address" placeholder="주소" name="address" style="width: 58%; margin-right: 1%;" required="required" value="${memberDTO.address }">
								<input type="text" class="form-control" id="detailed_address" placeholder="상세주소" name="detailed_address" style="width: 40%;" required="required" value="${memberDTO.detailed_address }">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-file-image-o"></i>
								</div>
								<input type="file" class="form-control" id="profile_image_file" name="profile_image_file" accept="image/*">
							</div>
							<span class="help-block" style="padding-left: 5px; color: red;">※ 프로필 사진 변경을 원하는 경우에만 파일을 선택해 주세요.</span>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<input type="hidden" name="num" value="${memberDTO.num }">
					<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-success">수정</button>
				</div>
			</form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="call_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
				<h1><i class="fa fa-phone"></i>연락처 수정</h1>
			</div>
			<form action="/call/update" class="form-horizontal" method="post" enctype="multipart/form-data" onsubmit="return callSubmitCheck();">
	            <div class="modal-body">
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-mobile"></i>
								</div>
								<input type="text" class="form-control" id="hp" name="hp" value="${memberDTO.hp }">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-envelope"></i>
								</div>
								<input type="text" class="form-control" id="email" name="email" value="${memberDTO.email }">
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<input type="hidden" name="num" value="${memberDTO.num }">
					<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-success">수정</button>
				</div>
			</form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
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