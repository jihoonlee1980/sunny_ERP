<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page session="false" %>
<c:set var="root" value="<%=request.getContextPath() %>"/>

    <!-- Navigation -->
        <div class="container topnav">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand topnav" href="http://factorysunny.com">SunnyFactory</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="${root}/">HOME</a>
                    </li>
                    <li>
                        <a href="${root}/ceo">CEO</a>
                    </li>
                    <li>
                        <a href="${root}/company">회사소개</a>
                    </li>
                    <li>
                        <a href="${root}/product">제품소개</a>
                    </li>
                    <li>
                        <a href="${root}/event">행사소식</a>
                    </li>
                    <li>
                        <a href="${root}/notice">공지사항</a>
                    </li>
                    <li>
                        <a href="${root}/erp">SunnyERP</a>
                    </li>
                    <li>
                        <a href="${root}/login">로그인</a>
                    </li>
                    <li>
                        <a href="${root}/join">회원가입</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->

