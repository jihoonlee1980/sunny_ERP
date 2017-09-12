<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page session="false" %>
<c:set var="root_" value="<%=request.getContextPath() %>"/>
<c:set var="root" value="${root_}/resources"/>
<script src="${root }/js/typed.js"></script>
<style>
#typed-cursor {
	font-size: 2em;
	font-family: arial;
	font-weight: 700;
}

.gradtext {
	background: #55ffaa;
	background: -webkit-linear-gradient(left, #55ff55, #55ffff);
	background: -moz-linear-gradient(right, #55ff55, #55ffff);
	background: -o-linear-gradient(right, #55ff55, #55ffff);
	background: linear-gradient(to right, #55ff55, #55ffff);
	-webkit-background-clip: text;
	background-clip: text;
	color: transparent;
	font-size: 30px;
	font-weight: bold;
}

@media ( max-width : 992px) {
	.type_div {
		display: none;
	}
}
</style>
<script type="text/javascript">
	$(function() {
		$(".type").typed(
				{
					strings : [ "SunnyFactory에 오신 것을 환영합니다.",
							"SunnyERP는 언제, 어디서 든지", "SunnyERP는 PC에서도 모바일에서도",
							"SunnyERP는 똑같은 화면과 기능을 사용할 수 있습니다." ],
					typeSpeed : 50,
					backDelay : 2000,
					loop : true
				});
	});
</script>
	<div class="type_div" style="position: absolute; z-index: 9999; width: 60%; text-align: center; top:20%; left:20%">
	  	<span class="type gradtext"></span>
	</div>
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
	  </ol>
	
	  <!-- Wrapper for slides -->
	  <div class="carousel-inner" role="listbox">
	    <div class="item active">
	      <img src="${root}/img/slide/sunnyfactory.png" alt="..." width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>SunnyFactory</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/songwriting.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>SongWriter</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/triservation.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>Triservation</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/javagram.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>Javagram</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/sunnygram.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>Sunnygram</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="${root}/img/slide/weathercoordinator.png" alt="..."  width="100%" height="70%">
	      <div class="carousel-caption">
	      	<h3>Weathercoordinator</h3>
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
                    	<span style="color: #23527c">SunnyERP(써니 이알피)</span>는
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
                    <h2 class="section-heading">똑똑하고 쉬운 ERP<br>그리고 컨텐츠</h2><br>
                    <p class="lead">기존의 ERP와는 다른  <span style="color: #23527c">특별함!</span><br>
                    	<br>SunnyERP만의 <br> 특별함으로 다가갑니다.
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
                    	 <span style="color: #23527c">회사 HOMEPAGE와 클라우드 ERP</span><br>
                    	 <span style="color: #23527c">안드로이드 APP과 카메라 IoT까지</span><br><br>모두 구축해 드리고<br>한 번에 사용하실 수 있습니다.
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