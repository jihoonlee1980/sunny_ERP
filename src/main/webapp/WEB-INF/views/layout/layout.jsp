<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page session="false" %>
<c:set var="root_" value="<%=request.getContextPath() %>"/>
<c:set var="root" value="${root_}/resources"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SunnyERP</title>
    <link href="${root}/css/bootstrap.min.css?ver=12" rel="stylesheet">
    <link href="${root}/css/landing-page.css?ver=13" rel="stylesheet">
    <link href="${root}/css/font-awesome.min.css?ver=2" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
    <script src="${root}/js/jquery-3.2.1.js"></script>
    <script src="${root}/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <!-- sweet alert -->
    <script src="${root }/js/sweetalert.min.js"></script>
    <link href="${root }/css/sweetalert.css" rel="stylesheet">
<%--     <link href="${root }/css/timeline.css?ver=2" rel="stylesheet"> --%>
    <!-- comment(comment style) -->
    <link href="${root }/css/comment.css?ver=7" rel="stylesheet">
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
		<tiles:insertAttribute name="header"/>
	</nav>
	<div>
		<tiles:insertAttribute name="body"/>
	</div>
    <footer>
    	<tiles:insertAttribute name="footer"/>
    </footer>
</body>
</html>

