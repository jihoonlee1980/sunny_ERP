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
<div class="banner company_banner">
	<div class="container">
		<div class="row">
		</div>
	</div>
</div>

<div class="content-section-a">
	<div class="container">
		<div class="row" style="margin:0;">
		    <div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3 col-xs-12">
		        <h3 style="text-align: center" >Login</h3>
		    </div>
		    
		    <hr class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3 col-xs-12" />
		
		    <div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3 col-xs-12">
		        <form class="" action="/login/proc" autocomplete="off" method="post">
		            <div class="input-group">
		                <span class="input-group-addon"><i class="fa fa-user fa-fw"></i></span>
		                <input type="text" class="form-control" name="id" placeholder="아이디">
		            </div>
		            <span class="help-block"></span>
		            <div class="input-group">
		                <span class="input-group-addon"><i class="fa fa-lock fa-fw"></i></span>
		                <input type="password" class="form-control" name="pass" placeholder="비밀번호">
		            </div>
		            <span class="help-block"></span>
		            <button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
		        </form>
		    </div>

		    <div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3 col-xs-12">
		        <div class="col-xs-6 col-sm-6">
		            <label class="checkbox" style="margin-left: 5px;">
		                <input type="checkbox" value="remember-me">로그인 정보 기억
		            </label>
		        </div>
		        <div class="col-xs-6 col-sm-6" style="margin-top: 10px;">
		            <p class="pull-right">
		                <a href="/join">회원가입</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#">비밀번호 찾기</a>
		            </p>
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