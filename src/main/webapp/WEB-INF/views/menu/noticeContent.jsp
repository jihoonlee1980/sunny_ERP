<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page session="true"%>
<c:set var="root_" value="<%=request.getContextPath() %>" />
<c:set var="root" value="${root_}/resources" />
<style>
.content-div {
	margin-top: 1%;
	padding-top: 10px;
	float: left;
	height: 100%;
}
.span-date{
	margin-left: 10px;
	line-height: 36px;
	vertical-align: middle;
}

#comments-list>li{
	display : none;
}

#comments-list>li.active{
	display : block;
}

#comment-pagination li a{
	cursor: pointer;
}

#comment-pagination>li{
	display : none;
}
#comment-pagination>li.show{
	display : inline !important;
}
</style>
<script type="text/javascript">
	function showComment(obj, perPage, perBlock, totalPage){
		var liLength = $("#comments-list li").length;
		$(obj).siblings().removeClass("active");
		$(obj).addClass("active");
		
		$("#comments-list li").removeClass("active");
		var currentPage = parseInt($(obj).find("a").text()); 
		var startNum = (currentPage - 1) * perPage;
		var endNum = startNum + perPage;
		endNum = endNum > liLength ? liLength : endNum;
		$("#comments-list li").slice(startNum, endNum).addClass("active");
		
		var startIndex = currentPage - parseInt(perBlock/2) - 1;
		
		if(startIndex < 0)
			startIndex = 0;
		
		var endIndex = startIndex + perBlock;
		
		if(endIndex > totalPage)
			endIndex = totalPage;
		
		if((endIndex - startIndex) < perBlock)
			startIndex = endIndex - perBlock;
		
		if(startIndex < 0)
			startIndex = 0;
		
		$("#comment-pagination>li").removeClass("show");
		$("#comment-pagination>li").slice(startIndex, endIndex).addClass("show")
	}

	function updateModal(num){
		$.ajax({
			url : "/notice/update/preproc",
			type : "get",
			data : {"num" : num},
			dataType : "json",
			success : function(data){
				var subject = data.noticeContent.subject;
				var content = data.noticeContent.content;
				var category = data.noticeContent.category;

				$("#update_subject").val(subject);
				$("#update_content").val(content);
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

	function deleteCehck(num, page) {
		swal({
			title : "게시글을 지우시겠습니까?",
			text : "삭제된 글은 복구가 불가능합니다.",
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
				swal("삭제 완료!", "해당 게시글이 삭제되었습니다.", "success");
				location.href = "/notice/delete?num=" + num + "&page=" + page;
			} else {
				swal("취소!", "게시글 삭제를 취소하였습니다.", "error");
			}
		});
	}
	
	function getReply(obj, board_num, comment_num, isLogin, loggedInID, loggedInProfile, page){
		if($(obj).hasClass("active")){
			$(obj).removeClass("active");
			$(obj).css("color", "#a6a6a6");
			$(obj).parents("li").children("ul").remove();
		} else {
			$(obj).addClass("active");
			$(obj).css("color", "#03658c");
			
			var html = "";
			html += "<ul class='comments-list reply-list'>";
			
			if(loggedInID != ""){
				html += "<li>";
				html += "<form action='/reply/insert' class='reply-input' method='get'>";
				html += "<div class='reply-input-avatar'>";
				html += "<img src='${root }/profile/" + loggedInProfile + "' alt=''>";
				html += "</div>";
				html += "<div class='reply-textarea'>";
				html += "<textarea rows='3' style='width: 100%;' name='content' required='required' placeholder='깨끗한 댓글 문화를 만들어갑시다.'></textarea>";
				html += "</div>";
				html += "<div style='background: #fff;' align='right'>";
				html += "<input type='hidden' name='board_num' value='" + board_num + "'>";
				html += "<input type='hidden' name='comment_num' value='" + comment_num + "'>";
				html += "<input type='hidden' name='writer' value='" + loggedInID + "'>";
				html += "<input type='hidden' name='page' value='" + page + "'>";
				html += "<input type='hidden' name='type' value='notice'>";
				html += "<button type='submit' class='btn btn-default btn-sm'>입력</button>";
				html += "</div>";
				html += "</form>";
				html += "</li>";
			}
	
			$.ajax({
				url : "/reply/list",
				type : "get",
				data : {"comment_num" : comment_num},
				dataType : "json",
				async: false,
				success : function(data){
					//document.write(JSON.stringify(data.commentDTO));
					var profile_files = data.profile_files;
					
					for (var i = 0; i < data.commentDTO.length; i++){
						var commentDTO = data.commentDTO[i];
						var date = new Date(commentDTO.writetime);
						
						html += "<li>";
						html += "<div class='comment-avatar'><img src='${root}/profile/" + profile_files[i] + "' alt=''></div>";
						html += "<div class='comment-box'>";
						html += "<div class='comment-head'>";
						html += "<h6 class='comment-name'>" + commentDTO.writer + "</h6>";
						html += "<span class='span-date'>" + formatDate(commentDTO.writetime) +  "</span>";
						if(commentDTO.writer == loggedInID){
							html += "<i class='fa fa-trash' onclick='deleteReply(this)' num='" + commentDTO.num + "' board_num='" + board_num +"' comment_num='" + comment_num + "' page='" + page + "'></i>";
							html += "<i class='fa fa-pencil-square-o' id='updateReplyForm" + commentDTO.num + "'></i>";
							html += "<p class='comment-hidden' style='display: none;'>" + commentDTO.content + "</p>";
							
							$(document).on("click", "#updateReplyForm" + commentDTO.num, function(){
								var content_div = $(this).parents().siblings(".comment-content");
								var current_content = $(this).siblings("p.comment-hidden").text();
								if($(this).hasClass("active")){
									$(this).css("color", "#a6a6a6");
									$(this).removeClass("active");
									content_div.empty();
									content_div.text(current_content);
								} else {
									$(this).css("color", "#03658c");
									$(this).addClass("active");
									var html = "<textarea rows='4' cols='' style='width: 100%'>";
									html += current_content;
									html += "</textarea>";
									html += "<div style='width: 100%' align='right'><button type='button' class='btn btn-sm btn-success' id='updateBtn" + commentDTO.num + "'>수정</button><button type='button' class='btn btn-sm btn-default' id='updateCancel" + commentDTO.num + "'>취소</button></div>";
									$(document).on("click", "#updateBtn" + commentDTO.num, function(){
										var update_btn = $(this);
										swal({
											title : "댓글을 수정 하시겠습니까?",
											type : "warning",
											showCancelButton : true,
											confirmButtonColor : "#DD6B55",
											confirmButtonText : "네",
											cancelButtonText : "아니요",
											closeOnConfirm : false,
											closeOnCancel : false
										}, function(isConfirm) {
											if (isConfirm) {
												var new_content = update_btn.parents().siblings("textarea").val();
												location.href = "/comment/update?num=" + commentDTO.num + "&content=" + new_content + "&board_num=" + board_num + "&page=" + page + "&type=notice";
											} else {
												swal("취소", "댓글 수정을 취소하였습니다.", "error");
											}
										});
									});
									
									$(document).on("click", "#updateCancel" + commentDTO.num, function(){
										var content_div = $(this).parents(".comment-content");
										content_div.empty();
										content_div.text(content_div.siblings(".comment-head").children("p.comment-hidden").text());
										content_div.siblings(".comment-head").children("i.fa-pencil-square-o").css("color", "#a6a6a6");
										content_div.siblings(".comment-head").children("i.fa-pencil-square-o").removeClass("active");
									});
									content_div.html(html);
								}
							});
						}
						html += "</div>";
						html += "<div class='comment-content'>";
						html += commentDTO.content;
						html += "</div>";
						html += "</div>";
						html += "</li>";
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
			html += "</ul>";
		
			$(obj).parents("li").append(html);
		}
	}
	
	function formatDate(date) {
		var d = new Date(date);
		var year = d.getYear() - 100;
		var month = "" + (d.getMonth() + 1);
		var day = "" + d.getDate();
		var hour = "" + d.getHours();
		var minutes = "" + d.getMinutes();
		
		if (month.length < 2)
			month = "0" + month;
		if (day.length < 2)
			day = "0" + day;
		if (hour.length < 2)
			hour = "0" + hour;
		if (minutes.length < 2)
			minutes = "0" + minutes;
		
		hour = " " + hour;
		
		return [year, month, day].join('.') + hour + ":" + minutes;
	}
	
	function updateCommentForm(obj, num, board_num, page){
		var content_div = $(obj).parents().siblings(".comment-content");
		var current_content = $(obj).siblings("p.comment-hidden").text();
		
		if($(obj).hasClass("active")){
			$(obj).css("color", "#a6a6a6");
			$(obj).removeClass("active");
			content_div.empty();
			content_div.text(current_content);
		} else {
			$(obj).css("color", "#03658c");
			$(obj).addClass("active");
			var html = "<textarea rows='4' cols='' style='width: 100%'>";
			html += current_content;
			html += "</textarea>";
			html += "<div style='width: 100%' align='right'><button type='button' class='btn btn-sm btn-success' id='updateBtn" + num + "'>수정</button><button type='button' class='btn btn-sm btn-default' id='updateCancel" + num + "''>취소</button></div>";
			
			$(document).on("click", "#updateBtn" + num, function(){
				var update_btn = $(this);
				swal({
					title : "댓글을 수정 하시겠습니까?",
					type : "warning",
					showCancelButton : true,
					confirmButtonColor : "#DD6B55",
					confirmButtonText : "네",
					cancelButtonText : "아니요",
					closeOnConfirm : false,
					closeOnCancel : false
				}, function(isConfirm) {
					if (isConfirm) {
						var new_content = update_btn.parents().siblings("textarea").val();
						location.href = "/comment/update?num=" + num + "&content=" + new_content + "&board_num=" + board_num + "&page=" + page + "&type=notice";
					} else {
						swal("취소", "댓글 수정을 취소하였습니다.", "error");
					}
				});
			});
			
			$(document).on("click", "#updateCancel" + num, function(){
				var content_div = $(this).parents(".comment-content");
				content_div.empty();
				content_div.text(content_div.siblings(".comment-head").children("p.comment-hidden").text());
				content_div.siblings(".comment-head").children("i.fa-pencil-square-o").css("color", "#a6a6a6");
				content_div.siblings(".comment-head").children("i.fa-pencil-square-o").removeClass("active");
			});
			content_div.html(html);
		}
	}
	
	function deleteComment(num, board_num, page) {
		swal({
			title : "댓글을 지우시겠습니까?",
			text : "삭제된 글은 복구가 불가능합니다.",
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
				swal("삭제 완료", "해당 댓글이 삭제되었습니다.", "success");
				location.href = "/comment/delete?num=" + num + "&board_num=" + board_num + "&page=" + page + "&type=notice";
			} else {
				swal("취소", "댓글 삭제를 취소하였습니다.", "error");
			}
		});
	}
	
	function deleteReply(obj) {
		swal({
			title : "댓글을 지우시겠습니까?",
			text : "삭제된 글은 복구가 불가능합니다.",
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
				swal("삭제 완료", "해당 댓글이 삭제되었습니다.", "success");
				location.href = "/reply/delete?num=" + $(obj).attr("num") + "&board_num=" + $(obj).attr("board_num")  + "&comment_num=" + $(obj).attr("comment_num") + "&page=" + $(obj).attr("page") + "&type=notice";
			} else {
				swal("취소", "댓글 삭제를 취소하였습니다.", "error");
			}
		});
	}
</script>
<!-- Header -->
<div class="banner notice_banner">
	<div class="container">
		<div class="notice_content_row">
			<div class="col-lg-6">
				<h2>공지사항</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
	<div class="container">
		<div class="notice-row">
			<div class="col-md-4 well pricing-table" style="width: 100% ">
	            <div class="pricing-table-holder">
	                <center>
	                    <h3>${noticeContent.subject }</h3>
	                </center>
	                <span style="width: 50%; display: inline-block; float: left">
						조회수  :  ${noticeContent.readcount }
					</span>
	                <span style="width:50%; text-align: right; display: inline-block; float: left">
						작성자 : ${noticeContent.writer }
					</span>
					<p align="right">
						작성날짜 : <fmt:formatDate value="${noticeContent.writeday }" pattern="yyyy-MM-dd HH:mm"/>
					</p>
	            </div>
	            <hr style="height: 2px; background: #777; width: 100%;">
				<div class="content-div" style="width: 100%;">
					<p style="margin-left: 20px;">
						${noticeContent.content }
					</p>
				</div>
				<div class="row" style="margin: 0 auto; width: 100%; display: inline-block; text-align: right;">
					<c:if test="${loggedInID eq noticeContent.writer}">
					    <a class="btn btn-warning btn-responsive btn-sm" id="updateModal" data-toggle="modal" data-target="#update" onClick="javascript:updateModal('${param.num}');">수정</a>
	       				<a class="btn btn-danger btn-responsive btn-sm" onclick="deleteCehck('${param.num}','${param.page }');">삭제</a>
	       			</c:if>
	       			<a class="btn btn-default btn-responsive btn-sm" href="/notice?page=${param.page }">목록</a>
				</div>
      			<div class="row" style="padding-left: 5px;">
					<div id="comment" style="width: 100%; height: 0px;"></div>
					<c:if test="${isLogin ne null }">
						<form action="/comment/insert" class="comment-input" method="get">
							<div class="comment-input-avatar">
								<img src="${root }/profile/${loggedInProfile}" alt="">
							</div>
							<div class="comment-textarea">
								<textarea rows="4" style="width: 100%;" name="content" placeholder="깨끗한 댓글 문화를 만들어 갑시다."></textarea>
							</div>
							<div style="background: #fff;" align="right">
								<input type="hidden" name="board_num" value="${param.num }">
								<input type="hidden" name="writer" value="${loggedInID }">
								<input type="hidden" name="page" value="${param.page }">
								<input type="hidden" name="type" value="notice">
								<button type="submit" class="btn btn-default btn-sm">입력</button>
							</div>
						</form>
					</c:if>
						
					<!-- 댓글 페이징 변수 -->
					<c:set var="totalComment" value="${fn:length(commentList) }"/>
					<c:set var="perPage" value="10"/>
					<c:set var="perBlock" value="5"/>
					<fmt:parseNumber var="totalPage" integerOnly="true" value="${totalComment % perPage == 0 ? totalComment / perPage : totalComment / perPage + 1 }"/>
					
					<c:set var="startPage" value="1"/>
					<c:set var="endPage" value="${totalPage > perBlock ? perBlock : totalPage }"/>
					<!-- 댓글 페이징 변수 끝 -->
					
					<c:if test="${totalComment > 0}">
						<div class="comments-container">
							<h5 style="margin-left: 5px;">댓글 [ ${totalComment} ]</h5>
							<ul id="comments-list" class="comments-list">
								<c:forEach var="commentDTO" items="${commentList }" varStatus="status">
									<li class="${status.index < perPage ? 'active' : '' }">
										<div class="comment-main-level">
											<div class="comment-avatar"><img src="${root }/profile/${profile_file[status.index]}" alt=""></div>
											<div class="comment-box">
												<div class="comment-head">
													<h6 class="comment-name ${noticeContent.writer == commentDTO.writer ? 'by-author' : '' }">${commentDTO.writer }</h6>
													<span class="span-date"><fmt:formatDate value="${commentDTO.writetime }" pattern="yy.MM.dd HH:mm"/></span>
													<i class="fa fa-reply" onclick="getReply(this, '${param.num }', '${commentDTO.num}', '${isLogin }', '${loggedInID }', '${loggedInProfile }', '${param.page }')">[${commentDTO.reply_count }]</i>
													<c:if test="${loggedInID == commentDTO.writer || loggedInID == 'admin'}">
														<i class="fa fa-trash" onclick="deleteComment(${commentDTO.num}, ${param.num }, ${param.page })"></i>
													</c:if>
													<c:if test="${loggedInID == commentDTO.writer }">
														<i class="fa fa-pencil-square-o" onclick="updateCommentForm(this, ${commentDTO.num}, ${commentDTO.board_num }, ${param.page })"></i>
														<p style="display: none;" class="comment-hidden">${commentDTO.content }</p>
													</c:if>
												</div>
												<div class="comment-content">
													${commentDTO.content }
												</div>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
							
							<div style="width:100%;" align="center">
								<ul class="pagination" id="comment-pagination">
									<c:forEach begin="${startPage}" end="${totalPage}" var="page">
										<li class="${page eq startPage ? 'active ' : '' } ${page <= perBlock ? 'show' : ''}" onclick="showComment(this, ${perPage }, ${perBlock }, ${totalPage })">						
											<a href="#comment"><c:out value="${page}"/></a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</c:if>
      			</div>
	        </div>
		</div>
	</div> <!--  container end -->
</div>

<div class="modal fade" id="update" tabindex="-1" role="dialog" aria-labelledby="contactLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<div class="panel-heading">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                      <h4 class="panel-title" id="contactLabel"><span class="glyphicon glyphicon-info-sign"></span>공지사항 수정</h4>
                  </div>
                  <form action="/notice/update" method="post" enctype="multipart/form-data">
					<div class="modal-body" style="padding: 5px;">
						<div class="row">
                              <div class="col-lg-12 col-md-12 col-sm-12" style="padding-bottom: 10px;">
                                  <input class="form-control" id="update_subject" name="subject" placeholder="제     목" type="text" required="required" />
                              </div>
						</div>
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12">
								<textarea style="resize:vertical;" id="update_content" class="form-control" placeholder="내   용..." rows="6" name="content" required></textarea>
							</div>
						</div>
					</div>  
					<div class="panel-footer" style="margin-bottom:-14px;">
						<input type="hidden" name="num" value="${param.num }">
						<input type="hidden" name="page" value="${param.page }">
						<input type="hidden" name="writer" value="admin">
						<input type="submit" class="btn btn-success" value="OK"/>
						<input type="reset" class="btn btn-danger" value="Clear" />
						<button style="float: right;" type="button" class="btn btn-default btn-close" data-dismiss="modal">Close</button>
					</div>
				</form>
		</div>
	</div>
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