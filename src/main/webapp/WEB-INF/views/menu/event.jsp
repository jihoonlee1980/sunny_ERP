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
a.list-group-item {
    height:auto;
    min-height:220px;
}
a.list-group-item.active small {
    color:#fff;
}
div.radio-inline input{
	color: #555;
	font-weight: 600;
}
</style>
<script type="text/javascript">
	$(function(){
		document.getElementById("list_div").oncontextmenu = function(e){
			swal("", "우클릭은 제한되어 있습니다.", "warning", "확인");
			return false;
		}
	});
</script>
<!-- Header -->
<div class="banner event_banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2 style="margin-bottom: 5%;">행사소식</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
	<div class="container">
		<div class="event-row" id="div_event">
			<div class="well">
		        <h1 class="text-center">행사 소식</h1>
		        <div class="list-group" id="list_div">
		        	<c:if test="${totalCount > 0 }">
			        	<c:forEach items="${eventList}" var="item" varStatus="status">
			        		<a href="/event/content?num=${item.num }&page=${currentPage}" class="list-group-item">
<%-- 							<a href="/event/${item.num }?page=${currentPage}" class="list-group-item"> --%>
			                	<div class="media col-md-3" style="margin-top: 2%">
				                    <figure class="pull-left">
			                        	<img class="media-object img-rounded img-responsive" src="${root}/img/event/${item.saved_filename}" alt="${item.subject}" style="max-height: 180px; max-width: 250px;">
			                    	</figure>
			                	</div>
			                	<div class="col-md-6" style="margin-top: 2%">
				                    <h4 class="list-group-item-heading"><span style="font-size: 10pt; font-weight: 600; color: #e69b0b">[${item.category }]&nbsp;&nbsp;&nbsp;</span><c:out value="${item.subject}"/><span style="font-size: 10pt; font-weight: 600; color: red">&nbsp;&nbsp;&nbsp;[ ${item.comment_count } ]</span></h4>
			                    	<hr style="width: 100%; height: 2px; background: #777; margin-top: 5px 5px;">
			                    	<p class="list-group-item-text"> <c:out value="${item.content}"/> </p>
			                	</div>
			                	<div class="col-md-3 text-center" style="margin-top: 3%">
				                    <h4> <c:out value="${item.readcount}"/> <small> Views </small></h4>
			                    	<br>
			                    	<p> 작성자: <c:out value="${item.writer}"/> </p>
			                    	<br>
			                    	<p> 날짜: <fmt:formatDate value="${item.writeday}" pattern="yyyy-MM-dd HH:mm"/> </p>
			                	</div>
			          		</a>
			        	</c:forEach>
			        </c:if>
			        <c:if test="${totalCount == 0 }">
			        	<div class="media col-md-12" style="margin-top: 2%; text-align: center;">
			        		<span style="font-size: 20pt; font-weight: 700; color: #999">등록된 행사소식이 없습니다.</span>
			        	</div>
			        </c:if>  
		        </div>
		        <div style="width:100%;" align="center">
					<ul class="pagination">
						<c:if test="${startPage > 1}">
							<li><a href="/event?page=${startPage - 1}">&lt;</a></li>
						</c:if>
						<c:forEach begin="${startPage}" end="${endPage}" var="page">
							<li ${page eq currentPage ? "class='active'" : "" }>						
								<a href="/event?page=${page}">
									<c:out value="${page}"/>
								</a>
							</li>
						</c:forEach>
						<c:if test="${totalPage ne endPage}">
							<li><a href="/event?page=${endPage + 1}">&gt;</a></li>
						</c:if>
					</ul>
				</div>
				<c:if test="${not empty isLogin }">
					<c:if test="${loggedInID eq 'admin'}">
						<div align="right">
							<a class="btn btn-primary btn-sm" data-toggle="modal" data-target="#write" data-original-title>글쓰기</a>
						</div>
					</c:if>
				</c:if>
			</div>
		</div>
			
		<div class="modal fade" id="write" tabindex="-1" role="dialog" aria-labelledby="contactLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="panel-title" id="contactLabel"><span class="glyphicon glyphicon-info-sign"></span> 행사소식 글쓰기</h4>
					</div>
					<form action="/event/insert" method="post" enctype="multipart/form-data">
						<div class="modal-body" style="padding: 5px;">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-sm-12" style="padding-bottom: 10px;">
									<input class="form-control" name="subject" placeholder="제     목" type="text" required="required" />
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12 col-md-12 col-sm-12" style="padding-left:20px; padding-bottom: 10px;">
                                	<span style="color: #999">카테고리&nbsp;&nbsp;&nbsp;</span>
                                	<div class="radio-inline">
                                    	<input type="radio" name="category" value="알림" required="required">알림
                                    </div>
                                    <div class="radio-inline">
                                    	<input type="radio" name="category" value="수상">수상
                                    </div>
                                    <div class="radio-inline">
                                    	<input type="radio" name="category" value="신제품">신제품
                                    </div>
                                    <div class="radio-inline">
                                    	<input type="radio" name="category" value="특허">특허
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <textarea style="resize:vertical;" class="form-control" placeholder="내   용..." rows="6" name="content" required></textarea>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <input class="form-control" name="attached_file" type="file">
                                </div>
							</div>
						</div>  
						<div class="panel-footer" style="margin-bottom:-14px;">
							<input type="hidden" name="writer" value="admin">
                            <input type="submit" class="btn btn-success" value="OK"/>
                            <input type="reset" class="btn btn-danger" value="Clear" />
                            <button style="float: right;" type="button" class="btn btn-default btn-close" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
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