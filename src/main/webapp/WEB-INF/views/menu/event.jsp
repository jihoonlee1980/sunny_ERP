<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page session="false"%>
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
.stars {
    margin:20px auto 1px;    
}
</style>
<!-- Header -->
<div class="banner event_banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>행사소식</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
        <div class="container">
        	 <div class="event-row">
				<div class="well">
		        <h1 class="text-center">행사 소식</h1>
		        <div class="list-group">
		        <c:forEach items="${eventList}" var="item">
		        	<a href="#" class="list-group-item">
		                <div class="media col-md-3">
		                    <figure class="pull-left">
		                        <img class="media-object img-rounded img-responsive"  src="${root}/img/event/${item.filename}" alt="${item.subject}" >
		                    </figure>
		                </div>
		                <div class="col-md-6">
		                    <h4 class="list-group-item-heading"> <c:out value="${item.subject}"/> </h4>
		                    <p class="list-group-item-text"> <c:out value="${item.content}"/> </p>
		                </div>
		                <div class="col-md-3 text-center">
		                    <h2> <c:out value="${item.readcount}"/> <small> Views </small></h2>
		                    <p> 작성자: <c:out value="${item.writer}"/> </p>
		                    <p> 날짜: <fmt:formatDate value="${item.writeday}" pattern="yyyy-MM-dd HH:mm"/> </p>
		                </div>
		          </a>
		        </c:forEach>		          		          
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
					
		        </div>
		        
			</div>
			<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">행사 업로드</button>
			<div class="modal fade">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">Modal title</h4>
			      </div>
			      <div class="modal-body">
			        <p>One fine body&hellip;</p>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary">Save changes</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			
        </div> <!--  container end -->
</div>

    
<a name="contact"></a>
<div class="banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>Cloud Global Service</h2>
			</div>
		</div>
	</div>
</div>