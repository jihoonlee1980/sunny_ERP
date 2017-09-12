<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page session="true"%>
<c:set var="root_" value="<%=request.getContextPath() %>" />
<c:set var="root" value="${root_}/resources" />
<!-- Header -->
<style>
table.admin {
	width: 140% !important;
	max-width: 140% !important;
	margin-left: -20% !important;
	font-size: 10.5pt;
	border: 1px solid #e3e3e3;
    border-radius: 4px;
    box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
}

table.admin thead tr th{
	text-align: center;
	font-size: 1.0em;
}

table.admin tbody tr td{
	text-align: center;
	font-size: 1.0em;
	vertical-align: middle;
}

table.admin>tbody>tr:nth-of-type(odd){
	background-color: #FFF !important;
}

table.admin thead tr th a {
	color: black;
	text-decoration: underline;
}
</style>
<script type="text/javascript">
	$(function(){
		$('.search-panel .dropdown-menu').find('a').click(function(e) {
			e.preventDefault();
			var param = $(this).attr("href").replace("#","");
			var concept = $(this).text();
			$('.search-panel span#type').text(concept);
			$('.input-group #search_type').val(param);
		});
		
		$('.tooltip-div').tooltip({
			selector: "[data-toggle=tooltip]",
			container: "body"
		});

		$("#deleteMember").click(function(){
			var deleteNums = [];
			
			$("input[class='id_check']:checked").each(function(i) {
				deleteNums.push($(this).val());
			});
			
			if(deleteNums.length == 0) {
				swal("", "체크된 회원이 없습니다.", "warning", "확인");
				return;
			}
			
			swal({
				title : "정말 탈퇴 시키겠습니까?",
				text : "삭제된 회원은 복구가 불가능합니다.",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "네",
				cancelButtonText : "아니요",
				closeOnConfirm : false,
				closeOnCancel : false,
				allowOutsideClick: true
			}, function(isConfirm) {
				if (isConfirm) {
					swal("삭제 완료", "탈퇴 되었습니다.", "success");
					location.href="/members/delete?nums="+deleteNums;
				} else {
					swal("취소", "취소 하였습니다.", "error");
				}
			});
		});
		
		$(".id_check").click(function(){
			var checked = true;
			$(".id_check").each(function(){
				if(!$(this).prop("checked"))
					checked = false;
			});
			$("#checkAll").prop("checked", checked);
		});
		
		$("#checkAll").click(function(){
			if($("#checkAll").prop("checked")){
	            $("input[class='id_check']").prop("checked", true);
	        }else{
	            $("input[class='id_check'").prop("checked", false);
	        }
		});
	});
	
	function checkCertification_key(){
		var result;
		$.ajax({
			url : "/checkCK",
			type : "post",
			data : {"certification_key" : $("#current_certifi").val()},
			dataType : "json",
			async : false,
			success : function(data){
				result = data.isValid;
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
		
		if(!result){
			swal("", "인증번호를 확인하세요.", "warning", "확인");
		}
		
		return result;
	}
	
	function toggleLock(num, is_account_lock, page, sort){
		var lock = is_account_lock == "Y" ? true : false;
		var new_lock = lock ? "N" : "Y";

		var current_state = "<span class='label label-";
		var new_state = " <i class='fa fa-long-arrow-right'></i> <span class='label label-";
		
		current_state += lock ? "warning" : "success";
		current_state += "'>";
		current_state += lock ? "불" : "";
		current_state += "가능</span>";
		
		new_state += !lock ? "warning" : "success";
		new_state += "'>";
		new_state += !lock ? "불" : "";
		new_state += "가능</span><br>";

		if(!lock){
			swal({
				title : "로그인 불가 사유",
				text : "로그인 불가 사유를 작성해주세요.",
				type : "input",
				showCancelButton : true,
				closeOnConfirm : false,
				animation : "slide-from-top",
				inputPlaceholder : "로그인 불가 사유"
			}, function(inputValue) {
				if (inputValue === false)
					return false;

				if (inputValue === "") {
					swal.showInputError("로그인 불가 사유를 작성해 주세요.");
					return false
				}
				
				swal({
					title : "<span>로그인 가능 여부 변경</span>",
					text : current_state + new_state,
					type : "warning",
					showCancelButton : true,
					confirmButtonColor : "#DD6B55",
					confirmButtonText : "네",
					cancelButtonText : "아니요",
					closeOnConfirm : false,
					closeOnCancel : false,
					allowOutsideClick : true,
					html : true
				}, function(isConfirm) {
					if (isConfirm) {
						swal("변경 완료", "변경 되었습니다.", "success");
						location.href = "/lock/update?num=" + num + "&is_account_lock=" + new_lock + "&page=" + page +"&sort=" + sort +"&lock_reason=" + inputValue;
					} else {
						swal("취소", "취소 하였습니다.", "error");
					}
				});
			});
		} else {
			swal({
				title : "<span>로그인 가능 여부 변경</span>",
				text : current_state + new_state,
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "네",
				cancelButtonText : "아니요",
				closeOnConfirm : false,
				closeOnCancel : false,
				allowOutsideClick : true,
				html : true
			}, function(isConfirm) {
				if (isConfirm) {
					swal("변경 완료", "변경 되었습니다.", "success");
					location.href = "/lock/update?num=" + num + "&is_account_lock=" + new_lock + "&sort=" + sort;
				} else {
					swal("취소", "취소 하였습니다.", "error");
				}
			});
		}
	}
	
	function updateCKForm(){
		var div = $("#updateCK-form");
		if(div.is(":visible")){
			div.hide();
		} else {
			div.show();
		}
	}
	
	function upateAuth(obj, num, page, sort){
		var selectedOpt = $(obj).prev("select").children("option:selected").val();
		
		location.href = "/auth/update?num=" + num + "&authority=" + selectedOpt + "&page=" + page + "&sort=" + sort;
	}
</script>
<div class="tooltip-div">
  <button title="" data-placement="right" data-toggle="tooltip" class="btn btn-default" type="button" data-original-title="Tooltip on right" >On hover</button>
</div>
<div class="banner admin_banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>관리자 페이지</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
	<div class="container">
		<div class="row" style="margin:0;">
			<table class="table table-striped table-condensed admin">
				<caption style="padding-left: 10px;">
					<span>※ ID, 이름, 가입일 순으로 정렬 가능합니다.(가입일순은 최근 가입한 순서부터 출력됩니다.)</span><br>
					<span>※ E-mail을 클릭하시면 메일을 보낼 수 있습니다.</span><br>
					<span>※ 로그인 가능 여부 변경은 <span class="label label-success">가능</span>, <span class="label label-warning">불가능</span>을 누르면 변경 가능합니다.</span><br>
				</caption>
				<thead>
					<tr>
						<th colspan="7"></th>
						<th colspan="4">
							<form action="/member/search" class="form-horizontal" style="width:100%; float: left;">
								<div class="col-xs-12">
								    <div class="input-group">
						                <div class="input-group-btn search-panel">
						                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						                    	<c:if test="${param.search_type eq null }">
						                    		<span id="type">ID</span> <span class="caret"></span>
						                    	</c:if>
						                    	<c:if test="${param.search_type ne null }">
						                    		<span id="type">${param.search_type == 'id' ? 'ID' : '이름' }</span> <span class="caret"></span>
						                    	</c:if>
						                    </button>
						                    <ul class="dropdown-menu" role="menu">
												<li><a href="#id">ID</a></li>
												<li><a href="#name">이름</a></li>
						                    </ul>
						                </div>
						                <c:if test="${param.search_type eq null }">
						                	<input type="hidden" name="search_type" value="id" id="search_type">
						                </c:if>
										<c:if test="${param.search_type ne null }">
						                	<input type="hidden" name="search_type" value="${param.search_type == 'id' ? 'id' : 'name' }" id="search_type">
						                </c:if>
						                <input type="hidden" name="page" value="${param.page }">
						                <input type="hidden" name="sort" value="${param.sort }">         
						                <input type="text" class="form-control" name="keyword" value="${param.keyword }">
						                <span class="input-group-btn">
						                    <button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
						                </span>
						            </div>
						        </div>
							</form>
						</th>
					</tr>
					<tr>
						<th><input type="checkbox" id="checkAll"></th>
						<c:if test="${param.search_type ne null }">
							<th><a href="/member/search?sort=id&search_type=${param.search_type }&keyword=${param.keyword}">ID</a></th>
							<th><a href="/member/search?sort=name&search_type=${param.search_type }&keyword=${param.keyword}">이름</a></th>
						</c:if>
						<c:if test="${param.search_type eq null }">
							<th><a href="/admin?sort=id">ID</a></th>
							<th><a href="/admin?sort=name">이름</a></th>
						</c:if>
						<th>회사</th>
						<th>H.P</th>
						<th>E-mail</th>
						<th width="35%">주소</th>
						<th>로그인 실패</th>
						<th>로그인 가능</th>
						<th>등급</th>
						<c:if test="${param.search_type ne null }">
							<th><a href="/member/search?sort=date&search_type=${param.search_type }&keyword=${param.keyword}">가입일</a></th>
						</c:if>
						<c:if test="${param.search_type eq null }">
							<th><a href="/admin?sort=date">가입일</a></th>
						</c:if>
					</tr>
				</thead>   
				<tbody>
					<c:forEach var="memberDTO" items="${memberList }">
						<tr>
							<td><input type="checkbox" class="id_check" value="${memberDTO.num }"></td>
		                    <td>${memberDTO.id }</td>
		                    <td>${memberDTO.name }</td>
		                    <td>${memberDTO.company }</td>
		                    <td>${memberDTO.hp }</td>
		                    <td><a href="mailto:${memberDTO.email }">${memberDTO.email }</a></td>
		                    <td>(${memberDTO.postcode }) ${memberDTO.address } ${memberDTO.detailed_address }</td>
		                    <td>${memberDTO.login_fail_count }</td>
		                    <td>
		                    	<div class="tooltip-div">
		                    		<a title="" data-placement="right" data-toggle="${memberDTO.is_account_lock == 'Y' ? 'tooltip' : '' }" type="button" data-original-title="${memberDTO.lock_reason}" class="label label-${memberDTO.is_account_lock == 'Y' ? 'warning' : 'success' }" onclick="toggleLock(${memberDTO.num}, '${memberDTO.is_account_lock }', '${param.page }','${param.sort }')">
		                    			${memberDTO.is_account_lock == 'Y' ? '불' : ''}가능
		                    		</a>
		                    	</div>
	                    	</td>
<%-- 		                    <fmt:parseNumber var="m_auth" value="${memberDTO.authority }" integerOnly="true"/> --%>
<%-- 							<fmt:parseNumber var="l_auth" value="${loggedInAuthority }" integerOnly="true"/> --%>
								<c:set var="m_auth" value="${memberDTO.authority }"/>
								<c:set var="l_auth" value="${loggedInAuthority }"/>
		                    <td>
			                    <select ${m_auth >= l_auth ? 'disabled' : '' }>
			                    	<option value="5" ${5 >= l_auth ? 'disabled' : '' } ${memberDTO.authority == 5 ? 'selected' : '' }>관리자</option>
			                    	<option value="1" ${1 >= l_auth ? 'disabled' : '' } ${memberDTO.authority == 1 ? 'selected' : '' }>일  반</option>
			                    </select>
			                    <button type="button" class="btn btn-sm btn-primary" onclick="upateAuth(this, ${memberDTO.num}, '${param.page }', '${param.sort }')">변경</button>
		                    </td>
		                    <td><fmt:formatDate value="${memberDTO.joindate }" pattern="yy.MM.dd HH:mm"/></td>
	                	</tr>
					</c:forEach>
				</tbody>
			</table>
			<div align="right" style="margin-left: -20%; width: 140%;">
				<c:if test="${l_auth >= 10 }">
					<button class="btn btn-sm btn-default" type="button" id="updateCK" onclick="updateCKForm()">인증번호 변경</button>
				</c:if>
				<button class="btn btn-sm btn-danger" type="button" id="deleteMember">삭제</button>
			</div>
			<div id="updateCK-form" style="width: 140%; margin-left: -20%; display: none;" align="right">
				<form action="/certifi/update" class="form-horizontal" method="post" onsubmit="return checkCertification_key();" style="width: 20%;">
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-lock"></i>
	                            </div>
	                    		<input type="password" class="form-control" id="current_certifi" placeholder="현재 인증번호" required="required" maxlength="20">
	                    	</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-lock"></i>
	                            </div>
	                    		<input type="password" class="form-control" id="pass" name="certification_key" placeholder="새 인증번호" required="required" maxlength="20">
	                    	</div>
	                       	<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-lock"></i>
	                            </div>
	                    		<input type="password" class="form-control" id="check_certifi_pass" placeholder="인증번호 확인" required="required" maxlength="20">
	                    	</div>
						</div>
					</div>
					<div align="right">
						<button type="submit" class="btn btn-sm btn-default">변경</button>
					</div>
				</form>
			</div>
			<div style="width:100%;" align="center">
				<ul class="pagination">
					<c:if test="${startPage > 1}">
						<c:if test="${param.search_type ne null }">
							<li><a href="/member/search?page=${startPage-1}&sort=${param.sort}&search_type=${param.search_type}&keyword=${param.keyword}">&lt;</a></li>
						</c:if>
						<c:if test="${param.search_type eq null }">
							<li><a href="/admin?page=${startPage - 1}&sort=${param.sort}">&lt;</a></li>
						</c:if>
					</c:if>
					<c:forEach begin="${startPage}" end="${endPage}" var="page">
						<c:if test="${param.search_type ne null }">
							<li ${page eq currentPage ? "class='active'" : "" }>						
								<a href="/member/search?page=${page}&sort=${param.sort}&search_type=${param.search_type}&keyword=${param.keyword}">
									<c:out value="${page}"/>
								</a>
							</li>
						</c:if>
						<c:if test="${param.search_type eq null }">
							<li ${page eq currentPage ? "class='active'" : "" }>						
								<a href="/admin?page=${page}&sort=${param.sort}">
									<c:out value="${page}"/>
								</a>
							</li>
						</c:if>
					</c:forEach>
					<c:if test="${totalPage ne endPage}">
						<c:if test="${param.search_type ne null }">
							<li><a href="/member/search?page=${endPage + 1}&sort=${param.sort}&search_type=${param.search_type}&keyword=${param.keyword}">&gt;</a></li>
						</c:if>
						<c:if test="${param.search_type eq null }">
							<li><a href="/admin?page=${endPage + 1}&sort=${param.sort}">&gt;</a></li>
						</c:if>
					</c:if>
				</ul>
			</div>
		</div>
	</div><!--  container end -->
</div> 
    
<div class="banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>Cloud Global Service</h2>
			</div>
		</div>
	</div>
</div>