<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page session="false"%>
<c:set var="root_" value="<%=request.getContextPath() %>" />
<c:set var="root" value="${root_}/resources" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5cf50b40347d9d9c1accf7af455fa139"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>
<!-- Header -->
<div class="banner company_banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>회사소개</h2>
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
                    <h2 class="section-heading">History(연혁)</h2><br>
                    <p class="lead"><a target="_blank" href="http://sunnyfactory.net">써니 팩토리</a>(Sunny Factory)는
                    <br><br>
                    2017. 04. 08<br>
                    	설립 되었습니다.<br><br></p>
              		<h5>-. [2017.05.25] &nbsp;2018 평창동계올림픽대회<br> 공모전 1차 합격<br><br></h5>     
                    <h5>-. [2017.06.15] &nbsp;정보통신산업진흥원<br>SW스타트업 창업지원 선정<br><br></h5>
                    <h5>-. [2017.07.01] &nbsp;첫 상용화 프로젝트<br>[SunnyErp] 개발진행(7~10월)<br></h5>
                    <br><br>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <img class="img-responsive" src="${root}/img/main/office1.png" alt="">
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
                    <h2 class="section-heading">About(일반)</h2><br>
                    <h5>1) 상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호 : 써니팩토리(Sunny Factory)<br><br><br>
                    2) 대표자 : 이지훈(JiHoon Lee)<br><br><br>
                    3) 업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태 : <br>출판, 영상, 방송통신 및 정보서비스업<br><br><br>
                    4) 업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;종 : <br>온라인 모바일 게임소프트웨어 개발 및 공급업<br>기타 게임소프트웨어 개발 및 공급업 
                    <br>응용소프트웨어 개발 및 공급업<br>시스템                  
                    <br><br><br>
                    5) 개&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;발 : ios, Android WEB, IOT<br><br><br>
                    6) 홈페이지 : <a target="_blank" href="http://sunnyfactory.net">http://sunnyfactory.net</a><br><br><br>
                    7) E-mail :<a href="mailto:seun80@hanmail.net"> seun80@hanmail.net</a><br>
                   </h5>
                </div><br>
                <div class="col-lg-5 col-sm-pull-6  col-sm-6">
                    <img class="img-responsive" src="${root}/img/main/office2.png" alt="">
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.content-section-b -->

    <div class="content-section-a">

        <div class="container">

            <div class="row" style="clear:both;">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">회사위치(Location)</h2><br>
                    <p class="lead"><a target="_blank" href="http://map.daum.net/?from=total&nil_suggest=btn&tab=place&q=%EA%B4%91%EC%A3%BCCGI%EC%84%BC%ED%84%B0">광주CGI센터</a>
                    </p>
                </div>
    
                <br><br>
                
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <center>		
						<div id="map" style="height: 300px;"></div>
						<br>
                    	<center>
	                		<caption><b style="font-size: 14pt;color:gray;">Originated by Daum Maps</b></caption><br>
	                	</center>
					</center>
                </div>
            </div>
        </div><!-- /.container -->
    </div>
    
		<script type="text/javascript">
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new daum.maps.LatLng(35.1105427,126.8777258), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };

			var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
			// 마커가 표시될 위치입니다 
			var markerPosition  = new daum.maps.LatLng(35.1105427,126.8777258); 
	
			// 마커를 생성합니다
			var marker = new daum.maps.Marker({
			    position: markerPosition
			});
	
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);

		</script>
    
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