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
</style>
<script type="text/javascript">
	$(function(){
	});
	
	function updateModal(num){
		$.ajax({
			url : "/notice/ajax",
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

	function deleteCehck() {
		return confirm("삭제 하시겠습니까?")
	}
</script>
<!-- Header -->
<div class="banner notice_banner">
	<div class="container">
		<div class="event_content_row">
			<div class="col-lg-6">
				<h2>공지사항</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
	<div class="container">
		<div class="event-row">
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
					<c:if test="${login eq noticeContent.writer}">
					    <a class="btn btn-warning btn-responsive btn-sm" id="updateModal" data-toggle="modal" data-target="#update" onClick="javascript:updateModal('${param.num}');">수정</a>
	       				<a class="btn btn-danger btn-responsive btn-sm" href="/notice/delete?num=${param.num }&page=${param.page}" onclick="return deleteCehck();">삭제</a>
	       			</c:if>
	       			<a class="btn btn-default btn-responsive btn-sm" href="/notice?page=${param.page }">목록</a>
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