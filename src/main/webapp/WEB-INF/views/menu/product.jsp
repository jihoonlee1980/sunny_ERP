<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page session="false"%>
<c:set var="root_" value="<%=request.getContextPath() %>" />
<c:set var="root" value="${root_}/resources" />
<link href="${root}/css/pricing_table.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,400italic' type='text/css'  rel='stylesheet'>
<link rel="stylesheet" type="text/css" href="css/ekko-lightbox.min.css">
<link rel="stylesheet" type="text/css" href="${root}/css/bootstrap_sigma.css?ver=40">
<script src="${root}/js/bootstrap.min.js?ver=2"></script>
<!-- Header -->
<div class="banner product_banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>제품소개</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
        <div class="container">
        	<h1>가격정책</h1>
			<ul class="pricing_table">
				<li class="price_block">
					<h3>Demo</h3>
					<div class="price">
						<div class="price_figure">
							<span class="price_number">FREE</span>
						</div>
					</div>
					<ul class="features">
						<li><b>구성</b><br>홈페이지+ERP+어플+IoT</li>
						<li><b>사용자수</b><br>무제한</li>
						<li><b>용량</b><br>1.4G(2년 사용가능)</li>
						<li><b>트래픽</b><br>3.5G(웹/어플, 동시접속 170명)</li>
						<li><b>백업</b><br>3중 관리(DATA+DB)</li>
					</ul>
					<div class="footer">
						<a href="#" class="action_button">Buy Now</a>
					</div>
				</li>
				<li class="price_block">
					<h3>Basic</h3>
					<div class="price">
						<div class="price_figure">
							<span class="price_number">&#8361;30,000 / 월</span>							
						</div>
					</div>
					<ul class="features">
						<li><b>구성</b><br>홈페이지+ERP+어플+IoT</li>
						<li><b>사용자수</b><br>무제한</li>
						<li><b>용량</b><br>1.4G(2년 사용가능)</li>
						<li><b>트래픽</b><br>3.5G(웹/어플, 동시접속 170명)</li>
						<li><b>백업</b><br>3중 관리(DATA+DB)</li>
					</ul>
					<div class="footer">
						<a href="#" class="action_button">Buy Now</a>
					</div>
				</li>
				<li class="price_block">
					<h3>Premium</h3>
					<div class="price">
						<div class="price_figure">
							<span class="price_number">&#8361;50,000 / 월</span>
						</div>
					</div>
					<ul class="features">
						<li><b>구성</b><br>홈페이지+ERP+어플+IoT</li>
						<li><b>사용자수</b><br>무제한</li>
						<li><b>용량</b><br>2.4G(2년 사용가능)</li>
						<li><b>트래픽</b><br>10G(웹/어플, 동시접속 500명)</li>
						<li><b>백업</b><br>3중 관리(DATA+DB)</li>
					</ul>
					<div class="footer">
						<a href="#" class="action_button">Buy Now</a>
					</div>
				</li>
				
			</ul>
			<div style="clear:both;"></div>
        	<h1 style="margin:50px 0;" >무료 부가 서비스</h1>			
			<div class="sigma-row">
	        	<div class="sigma-content col-lg-3 col-md-6 sigma-bg-lightgray text-center">
	            	<span class="sigma-icon fa fa-bell"></span>
	                <h2>알림</h2>
	            	<p>알림기능</p>
	            </div>
	            <div class="sigma-content col-lg-3 col-md-6 sigma-bg-gray text-center">
	            	<span class="sigma-icon fa fa-send"></span>
	            	<h2>쪽지</h2>
	            	<p>쪽지기능</p>
	            </div>
	            <div class="sigma-content col-lg-3 col-md-6 sigma-bg-darkgray text-center">
	            	<span class="sigma-icon fa fa-window-maximize"></span>
	            	<h2>모바일 App</h2>
	            	<p>모바일 App</p>
	            </div>	           
	        </div>    		
	        <script>
        	$(document).ready(function() {
	        	$('.thumbnail').click(function(){
	        		//alert("test");
	        	    $('.modal-body').empty();
	        	  	var title = $(this).parent('a').attr("title");
	        	  	console.log("title : "+title);
	        	  	$('.modal-title').html(title);
	        	  	
	        	  	$($(this).parents('div').html()).appendTo('.modal-body');
	        	  	$('#myModal').modal({show:true});
	        	});
        	});
	        </script>
	        <div style="clear:both;"></div>
	        <div class="gallery-row" style="margin-bottom:50px;">
			    <h1 style="margin:50px 0;">미리보기</h1>			   
			      <div class="col-lg-3 col-sm-4 col-xs-6"><a title="Image 1" href="#;"><img class="thumbnail img-responsive" src="//placehold.it/600x350"></a><div><h4>TEST</h4><p>testetes</p></div></div>
			      <div class="col-lg-3 col-sm-4 col-xs-6"><a title="Image 2" href="#;"><img class="thumbnail img-responsive" src="//placehold.it/600x350/2255EE"></a><div><h4>TEST</h4><p>testetes</p></div></div>
			      <div class="col-lg-3 col-sm-4 col-xs-6"><a title="Image 3" href="#;"><img class="thumbnail img-responsive" src="//placehold.it/600x350/449955/FFF"></a><div><h4>TEST</h4><p>testetes</p></div></div>
			      <div class="col-lg-3 col-sm-4 col-xs-6"><a title="Image 4" href="#;"><img class="thumbnail img-responsive" src="//placehold.it/600x350/992233"></a><div><h4>TEST</h4><p>testetes</p></div></div>
			      <div class="col-lg-3 col-sm-4 col-xs-6"><a title="Image 5" href="#;"><img class="thumbnail img-responsive" src="//placehold.it/600x350/2255EE"></a><div><h4>TEST</h4><p>testetes</p></div></div>
			      <div class="col-lg-3 col-sm-4 col-xs-6"><a title="Image 6" href="#;"><img class="thumbnail img-responsive" src="//placehold.it/600x350/449955/FFF"></a><div><h4>TEST</h4><p>testetes</p></div></div>
			      <div class="col-lg-3 col-sm-4 col-xs-6"><a title="Image 8" href="#;"><img class="thumbnail img-responsive" src="//placehold.it/600x350/777"></a><div><h4>TEST</h4><p>testetes</p></div></div>
			      <div class="col-lg-3 col-sm-4 col-xs-6"><a title="Image 9" href="#;"><img class="thumbnail img-responsive" src="//placehold.it/600x350/992233"></a><div><h4>TEST</h4><p>testetes</p></div></div>
			      <div class="col-lg-3 col-sm-4 col-xs-6"><a title="Image 10" href="#;"><img class="thumbnail img-responsive" src="//placehold.it/600x350/EEE"></a><div><h4>TEST</h4><p>testetes</p></div></div>			      	   
			   
			</div>		
		<div tabindex="-1" class="modal fade" id="myModal" role="dialog">
		  <div class="modal-dialog">
		  <div class="modal-content">
		    <div class="modal-header">
				<button class="close" type="button" data-dismiss="modal">×</button>
				<h3 class="modal-title">Heading</h3>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		   </div>
		  </div>
		  <br><br>
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