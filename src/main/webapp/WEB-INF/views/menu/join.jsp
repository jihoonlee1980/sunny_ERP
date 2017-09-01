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
                $("#detailed_address").focus();
            }
        }).open();
    }
	
	function idValidCheck(){
		var reg_id = /[a-zA-Z0-9]{8,16}$/g;
		
		if(!reg_id.test($("#id").val())){
			//alert("아이디는 영어 대소문자와 숫자조합으로 8~16자만 가능합니다.");
			swal({
				title : "",
   				text : "아이디는 영어 대소문자와 숫자조합으로만 가능합니다.\n(8~16자)",
   				type : "warning",
   				confirmButtonText: "확인",
   				allowOutsideClick: true
   			});
			
			return;
		}
		
		$.ajax({
			url : "/join/checkID",
			type : "get",
			data : {"id" : $("#id").val()},
			dataType : "json",
			success : function(data){
				if(data.isValid){
					//alert("사용가능한 아이디 입니다.");
					swal({
						title : "사용가능한 아이디 입니다.",
						text : "아이디를 사용하시겠습니까?",
						type : "success",
						showCancelButton : true,
						confirmButtonColor : "#DD6B55",
						confirmButtonText : "네",
						cancelButtonText : "아니요",
						closeOnConfirm : false,
						closeOnCancel : false,
						allowOutsideClick: true
					}, function(isConfirm) {
						if (isConfirm) {
							$("#id").prop("readonly", true);
							$("#IDcheckBtn").prop("disabled", true);
							swal("", $("#id").val() + "를 사용합니다.", "success");
						} else {
							$("#id").val("");
							swal("", "아이디를 새로 작성 후 중복확인 해주세요.", "warning");
						}
					});
				} else {
					//alert("이미 사용중인 아이디 입니다.");
					swal({
						title : "",
   						text : "이미 사용중인 아이디 입니다.",
	   					type : "warning",
	   					confirmButtonText: "확인",
	   					allowOutsideClick: true
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
	
	function checkCertification_key(){
		$.ajax({
			url : "/checkCK",
			type : "post",
			data : {"certification_key" : $("#certification_key").val()},
			dataType : "json",
			success : function(data){
				if(data.isValid){
					swal({
						title : "",
		   				text : "인증 되었습니다.",
		   				type : "success",
		   				confirmButtonText: "확인",
		   				allowOutsideClick: true
		   			});
					certification_activate(true);
				} else {
					swal({
						title : "",
   						text : "인증번호를 확인하세요",
	   					type : "warning",
	   					confirmButtonText: "확인",
	   					allowOutsideClick: true
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
	
	function submitCheck(){
		var reg_id = /[a-zA-Z0-9]{8,16}$/g;
		var reg_pass = /[a-zA-Z0-9]{8,20}$/g;
		var reg_hp = /^((010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-\d{4}$/g;
		var check = true;
		
		if(!reg_id.test($("#id").val())){
			//alert("아이디는 영어 대소문자와 숫자조합으로 8~16자만 가능합니다.");
			callSwal("", "아이디는 영어 대소문자와 숫자조합으로만 가능합니다.\n(8~16자)", "warning", "확인");
			check = false;
		}
		
		if(!reg_pass.test($("#pass").val())){
			//alert("비밀번호는 영어와 숫자조합으로 8~20자만 가능합니다.(대소문자 구분 없음.)")
			callSwal("", "비밀번호는 영어와 숫자조합으로만 가능합니다.\n(8~20자, 대소문자 구분 없음.)", "warning", "확인");
			check = false;
		}
		
		if($("#pass").val() != $("#checkPass").val()){
			//alert("비밀번호가 서로 다릅니다.");
			callSwal("", "비밀번호가 서로 다릅니다.", "warning", "확인");
			check = false;
		}
		
		if(!reg_hp.test($("#hp").val().replace(" ",""))){
			//alert("휴대폰 번호를 확인해 주세요(예.010-1234-1234)");
			callSwal("", "휴대폰 번호를 확인해 주세요(예.010-1234-1234)", "warning", "확인");
			check = false;
		}
		
		if(!$("#IDcheckBtn").is(":disabled")){
			//alert("아이디 중복체크를 해주세요.")
			callSwal("", "아이디 중복체크를 해주세요.", "warning", "확인");
			check = false;
		}
		
		if(!$("#certification_btn").is(":disabled")){
			callSwal("", "인증 확인을 해주세요.", "warning", "확인");
			check = false;
		}
		
		return check;
	}
	
	function callSwal(title, text, type, confirmText){
		swal({
			title : title,
			text : text,
			type : type,
			confirmButtonText: confirmText,
			allowOutsideClick: true
		});
	}
	
	function certification_activate(value){
		$("#certification_key").prop("readonly", value);
		$("#certification_btn").prop("disabled", value)
	}
</script>
<!-- Header -->
<div class="banner join_banner">
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
						<form action="/join/proc" class="form-horizontal track-event-form bv-form" method="post" enctype="multipart/form-data" onsubmit="return submitCheck();" autocomplete="off">
							<div class="form-group">
			              		<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-user"></i>
			                            </div>
			                    			<input type="text" class="form-control" id="name" placeholder="이름" name="name" required="required" autofocus="autofocus">
			                    	</div>
								</div>          
								<div class="col-sm-6">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-briefcase"></i>
			                            </div>
			                            <input type="text" class="form-control" id="company" placeholder="회사명" name="company">
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
					                    <button type="button" id="certification_btn" class="btn btn-success" onclick="checkCertification_key();">확인</button>
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
										<input type="text" class="form-control" id="postcode" name="postcode" placeholder="우편번호" style="width: 25%;" readonly="readonly">
										<input type="button" class="btn btn-default" value="우편번호 찾기" onclick="daumPostcode()" style="width: 20%">
										<input type="text" class="form-control" id="address" placeholder="주소" name="address" style="width: 58%; margin-right: 1%;" required="required" readonly="readonly">
										<input type="text" class="form-control" id="detailed_address" placeholder="상세주소" name="detailed_address" style="width: 40%;" required="required">
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