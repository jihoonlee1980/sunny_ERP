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
<div class="banner event_banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h2>회원가입</h2>
			</div>
		</div>
	</div>
</div>
<div class="content-section-a">
        <div class="container">
			<div class="row">
			      <div class="col-md-2"> </div>
			      <div class="col-md-8">
			        <h1>회원가입</h1>
			        <p class="lead">서비스 이용에는 로그인이 필요합니다.</p>
			        
			        <p>회원가입을 위해 다음과 같은 항목들을 입력해주세요.</p> <br> 
			         
			        <!-- BEGIN DOWNLOAD PANEL -->
			        <div class="panel panel-default well">
			          <div class="panel-body">
			            <form action="/join/proc" class="form-horizontal track-event-form bv-form" data-goaltype="”General”" data-formname="”ContactUs”" method="post" id="contact-us-all" novalidate="novalidate" enctype="multipart/form-data">
			              <input name="elqSiteId" type="hidden" value="928">
			              <input name="sFDCLastCampaignID" type="hidden" value="701400000012Lql">
			              <input name="elqFormName" type="hidden" value="EMEAAllContactUsSubmissions">
			              <input name="nexturl" type="hidden" value="">
			              <input name="Partner" type="hidden" value="">
			              <input name="language" type="hidden" value="en">
			
			              <div class="form-group">
			              	<div class="col-sm-6">
			                  <div class="input-group">
			                    <div class="input-group-addon">
			                      <i class="fa fa-user"></i>
			                            </div>
			                    <input type="text" class="form-control" id="exampleInputLastName" placeholder="이름" name="name" data-bv-field="name" required="required"></div>
			                        <small data-bv-validator="notEmpty" data-bv-validator-for="C_LastName" class="help-block" style="display: none;">Required</small>
			               </div>          
			               <div class="col-sm-6">
			                            <div class="input-group">
			                              <div class="input-group-addon">
			                                <i class="fa fa-briefcase"></i>
			                            </div>
			                            <input type="text" class="form-control" id="exampleInputCompany" placeholder="회사명" name="join_company">
			                  </div>
			               </div>
			              </div>
						 <div class="form-group">
						 	    <div class="col-sm-6">
			                  <div class="input-group">
			                    <div class="input-group-addon">
			                      <i class="fa fa-id-card"></i>
			                            </div>
			                    <input type="text" class="form-control" id="exampleInputFirstName" placeholder="아이디" name="id" data-bv-field="id">
			                        </div>
			                    <small data-bv-validator="notEmpty" data-bv-validator-for="C_FirstName" class="help-block" style="display: none;">Required</small></div>
			                <div class="col-sm-6">
			                  <div class="input-group">
			                    <div class="input-group-addon">
			                      <i class="fa fa-lock"></i>
			                            </div>
			                    <input type="password" class="form-control" id="exampleInputFirstName" placeholder="비밀번호" name="pass" data-bv-field="pass">
			                        </div>
			                    <small data-bv-validator="notEmpty" data-bv-validator-for="Password" class="help-block" style="display: none;">Required</small></div>               
			                
			              </div>
			              <div class="form-group">               
			                          <div class="col-sm-6">
			                            <div class="input-group">
					                      <div class="input-group-addon">
					                      	<i class="fa fa-sitemap"></i>          
					                      </div>                        
					                    <select data-placeholder="Choose country" class="C_Country_Modal form-control" id="C_Country" name="level" data-bv-field="C_Country">
					                      <option value="">--직급--</option>
					                      <option value="일반">일반</option>
					                      <option value="사원">사원</option>
					                      <option value="임원">임원</option>
					                   	</select>
					                  </div>
			                    <small data-bv-validator="notEmpty" data-bv-validator-for="C_EmailAddress" class="help-block" style="display: none;">Required</small></div>
			                    <div class="col-sm-6">
					                  <div class="input-group">
					                              <div class="input-group-addon">
					                      <i class="fa fa-key"></i>
					                    </div>
					                    <input type="text" class="form-control" id="C_BusPhone" placeholder="인증코드" name="certification_key" style="width:80.5%">
					                    <button type="button" class="btn btn-success">확인</button>
					                  </div>
					                  <small data-bv-validator="notEmpty" data-bv-validator-for="C_EmailAddress" class="help-block" style="display: none;">Required</small>                        
					            </div>            
			                          
			              </div>			              
			              <div class="form-group">
			              			<div class="col-sm-6">
					                  <div class="input-group">
					                              <div class="input-group-addon">
					                      <i class="fa fa-mobile"></i>
					                    </div>
					                    <input type="text" class="form-control" id="C_BusPhone" placeholder="핸드폰 번호" name="hp">
					                  </div>                                    
					                </div>  
			                          <div class="col-sm-6">
			                            <div class="input-group">
			                              <div class="input-group-addon">
			                                <i class="fa fa-envelope"></i>
			                            </div>
			                            <input type="text" class="form-control" id="exampleInputEmail1" placeholder="이메일" name="email" data-bv-field="EmailAddress">
			                        </div>
			                    <small data-bv-validator="notEmpty" data-bv-validator-for="C_EmailAddress" class="help-block" style="display: none;">Required</small></div>                
			                          
			              </div>
			              		<div class="form-group">
				              		<div class="col-sm-12">
				                            <div class="input-group">
				                              <div class="input-group-addon">
				                                <i class="fa fa-address-card-o"></i>
				                            </div>
				                            <input type="text" class="form-control" id="exampleInputEmail1" placeholder="주소" name="address" data-bv-field="EmailAddress" style="width:86%;">
				                            <button type="button" class="btn btn-info">주소검색</button>
				                        </div>
				                    <small data-bv-validator="notEmpty" data-bv-validator-for="C_EmailAddress" class="help-block" style="display: none;">Required</small></div>      
				                 </div>
				                 <div class="form-group">
				              		<div class="col-sm-6">
				                            <div class="input-group">
				                              <div class="input-group-addon">
				                                <i class="fa fa-file-image-o"></i>
				                            </div>
				                            <input type="file" class="form-control" id="exampleInputEmail1" placeholder="프로필 사진" name="profile_image" data-bv-field="EmailAddress">
				                        </div>
				                    <small data-bv-validator="notEmpty" data-bv-validator-for="C_EmailAddress" class="help-block" style="display: none;">Required</small></div>      
				                 </div>
			                      
			                      <div class="form-group">
			                        <div class="col-sm-12">
			                  <button id="contacts-submit" type="submit" class="btn btn-default btn-info" style="float:right;">회원가입</button>
			                        </div>
			                      </div>
			            <input type="hidden" value=""></form>
			          </div><!-- end panel-body -->
			        </div><!-- end panel -->
			        <!-- END DOWNLOAD PANEL -->
			      </div><!-- end col-md-8 -->
			      <div class="col-md-2"> </div>
			     </div>
			
        </div> <!--  container end -->
</div>

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