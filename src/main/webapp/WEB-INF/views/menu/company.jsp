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
                    <p class="lead"><a target="_blank" href="http://factorysunny.com/">Sunny Factory</a>(써니 팩토리)는
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
                    4) 업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;종 : <br>온라인 모바일 게임소프트웨어 개발 및 공급업,<br>기타 게임소프트웨어 개발 및 공급업 
                    <br>응용소프트웨어 개발 및 공급업,<br>시스템                  
                    <br><br><br>
                    5) 개&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;발 : ios, android, web, IoT<br><br><br>
                    6)<a target="_blank" href="http://factorysunny.com/"> http://factorysunny.com/</a><br><br><br>
                   7)<a href="mailto:seun80@hanmail.net"> seun80@hanmail.net</a><br>
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
                    <p class="lead"><a target="_blank" href="http://factorysunny.com/">광주CGI센터</a>
                    </p>
                </div>
    
                <br><br>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <!-- <img class="img-responsive" src="resources/photo/photo3.png" alt=""> -->
                    
                    
                    <center>		
						<div id="post_content">
							<!-- <iframe id="map" width="100%" height="100%" 
							frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe> -->
							<div id="map" style="width: 260px; height: 300px;"></div>
						</div>
						<br>
                    	<center>
	                		<caption><b style="font-size: 14pt;color:gray;">Originated by Daum Maps</b></caption><br>
	                	</center>
					</center>
				<script type="text/javascript"
					src="//apis.daum.net/maps/maps3.js?apikey=5cd4ad3ec7ff604b1698e2754ffb0b64&libraries=services"></script>
				<script>
				// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
				var infowindow = new daum.maps.InfoWindow({zIndex:1});
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new daum.maps.LatLng(37.0183313, 127.3830068),  // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  
				// 지도를 생성합니다    
				var map = new daum.maps.Map(mapContainer, mapOption); 
				// 장소 검색 객체를 생성합니다
				var ps = new daum.maps.services.Places(); 
				// 키워드로 장소를 검색합니다
				ps.keywordSearch('광주CGI센터', placesSearchCB); 
				// 키워드 검색 완료 시 호출되는 콜백함수 입니다
				function placesSearchCB (status, data, pagination) {
				    if (status === daum.maps.services.Status.OK) {
				        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				        // LatLngBounds 객체에 좌표를 추가합니다
				        var bounds = new daum.maps.LatLngBounds();
				        for (var i=0; i<data.places.length; i++) {
				            displayMarker(data.places[i]);    
				            bounds.extend(new daum.maps.LatLng(data.places[i].latitude, data.places[i].longitude));
				        }       
				        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				        map.setBounds(bounds);
				    } 
				}
				// 지도에 마커를 표시하는 함수입니다
				function displayMarker(place) {
				    // 마커를 생성하고 지도에 표시합니다
				    var marker = new daum.maps.Marker({
				        map: map,
				        position: new daum.maps.LatLng(place.latitude, place.longitude) 
				    });
				    // 마커에 클릭이벤트를 등록합니다
				    daum.maps.event.addListener(marker, 'click', function() {
				        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
				        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.title + '</div>');
				        infowindow.open(map, marker);
				    });
				}
				</script>
                </div>
            </div>

        </div>
        <!-- /.container -->

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