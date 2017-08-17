<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page session="false"%>
<c:set var="root_" value="<%=request.getContextPath() %>" />
<c:set var="root" value="${root_}/resources" />
<!-- Header -->
<div class="banner ceo_banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>CEO</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
	<div class="container">
		<div class="row">
			<div class="col-lg-5 col-sm-6">
				<hr class="section-heading-spacer">
				<div class="clearfix"></div>
				<h2 class="section-heading">CEO Sunny</h2><br>
				<p class="lead">
					<span style="color:#23527c;">CEO Sunny는</span> <br>
					<br> 어렸을 적 개발자가 꿈이었습니다.<br> 그리고 지금<br> 그 꿈에 다가서고 있습니다.<br>
					<br>
				</p>
			</div>
			<div class="col-lg-5 col-lg-offset-2 col-sm-6">
				<img class="img-responsive"	src="${root}/img/main/900developer1.png" alt="">
			</div>
		</div>
	</div>
</div>
<div class="content-section-b">
	<div class="container">

		<div class="row">
			<div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
				<hr class="section-heading-spacer">
				<div class="clearfix"></div>
				<h2 class="section-heading">
					다양한 경험&nbsp;&nbsp;<br>그리고 아이디어!
				</h2>
				<br>
				<p class="lead">
					다양한 경험! <br>기존 웹,어플과는 다른<br>
					<br> <span style="color:#23527c;">특별함!<br></span>
					<br>'SunnyFactory'만의<br> '아이덴티티'로 다가갑니다.
				</p>
			</div>
			<br>
			<div class="col-lg-5 col-sm-pull-6  col-sm-6">
				<img class="img-responsive"	src="${root}/img/main/900developer4.png" alt="">
			</div>
		</div>

	</div>
	<!-- /.container -->

</div>
<!-- /.content-section-b -->

<div class="content-section-a">

	<div class="container">

		<div class="row">
			<div class="col-lg-5 col-sm-6">
				<hr class="section-heading-spacer">
				<div class="clearfix"></div>
				<h2 class="section-heading">탐구와 열정!</h2>
				<br>
				<p class="lead">
					<span style="color:#23527c;"> CEO Sunny는 </span><br> <br>오늘도 열심히 탐구하며<br>연구하고 있습니다.</a>
			</div>
			<br>
			<br>
			<div class="col-lg-5 col-lg-offset-2 col-sm-6">
				<img class="img-responsive"	src="${root}/img/main/900developer2.png" alt="">
			</div>
		</div>

	</div>
	<!-- /.container -->

</div>
<!-- /.content-section-a -->

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