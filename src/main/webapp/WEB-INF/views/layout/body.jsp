<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page session="false" %>
<c:set var="root_" value="<%=request.getContextPath() %>"/>
<c:set var="root" value="${root_}/resources"/>
<!-- Header -->
    <a name="about"></a>
	<div id="mycarousel" class="carousel slide" data-ride="carousel">
	  <!-- Indicators -->
	  <ol class="carousel-indicators">
	    <li data-target="#mycarousel" data-slide-to="0" class="active"></li>
	    <li data-target="#mycarousel" data-slide-to="1"></li>
	    <li data-target="#mycarousel" data-slide-to="2"></li>
	    <li data-target="#mycarousel" data-slide-to="3"></li>
	    <li data-target="#mycarousel" data-slide-to="4"></li>
	    <li data-target="#mycarousel" data-slide-to="5"></li>
	    <li data-target="#mycarousel" data-slide-to="6"></li>
	  </ol>
	
	  <!-- Wrapper for slides -->
	  <div class="carousel-inner" role="listbox">
	    <div class="item active">
	      <img src="${root}/img/slide/sunny1.png" alt="..." width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>WeatherCoordinator</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/sunny2.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>SongWriter</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/sunny3.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>SunnyFactory</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/sunny4.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>Triservation</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/sunny5.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>STARBUCKS</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/sunny6.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>TELEGRAM</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/sunny8.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>SunnyERP</h3>
	      </div>
	    </div>
	  </div>
	
	<a class="left carousel-control" href="#mycarousel" data-slide="prev">
		<span class="icon-prev"></span>
	</a>
	<a class="right carousel-control" href="#mycarousel" data-slide="next">
		<span class="icon-next"></span>
	</a>
	</div>

	<a  name="services"></a>
    <div class="content-section-a">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">Vision(비젼)</h2><br>
                    <p class="lead">
                    	<span style="color: #23527c">Sunny Erp(써니 이알피)</span>는
                    	<br><br>
                    	누구나 손쉽게 사용하고, <br>실용성이 있는<br>현업 사용자가 직접 개발한<br><br>
                    	중소기업에 맞는, <br> 최적화  클라우드(Cloud) 서비스!!!<br><br>
                    </p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <img class="img-responsive" src="${root}/img/main/photo1.JPG" alt="">
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
                    <h2 class="section-heading">똑똑하고 쉬운 ERP <br>그리고 컨텐츠</h2><br>
                    <p class="lead">기존의 ERP와는 다른  <span style="color: #23527c">특별함!</span><br>
                    	<br>Sunny Erp 만의 <br> 특별함으로 다가갑니다.
                    </p>
                </div>
                <div class="col-lg-5 col-sm-pull-6  col-sm-6">
                    <img class="img-responsive" src="${root}/img/main/sunny100.png" alt="">
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
                    <h2 class="section-heading">All in One</h2><br>
                    <p class="lead">
                    	 <span style="color: #23527c">회사 Homepage 와 클라우드 Erp</span><br>
                    	 <span style="color: #23527c">안드로이드 App 과 카메라 IoT</span><br><br>모두 구축해 드리고<br>한 번에 사용하실 수 있습니다.
                    </p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <img class="img-responsive" src="${root}/img/main/photo3.png" alt="">
                </div>
            </div>
        </div>
    </div>
    
	<a  name="contact"></a>
    <div class="banner">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <h2>Cloud Global Service</h2>
                </div>
            </div>
        </div>
    </div>