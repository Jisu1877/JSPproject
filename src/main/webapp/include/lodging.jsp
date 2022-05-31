<%@page import="lodging.LodgingDAO"%>
<%@page import="lodging.OptionVO"%>
<%@page import="lodging.LodgingVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="admin.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	LodgingDAO lodDao = new LodgingDAO();
	
	//숙소 전체리스트(최신등록순으로)
	ArrayList<LodgingVO> lodVos = lodDao.getLodList(0);
	
	//숙소 NEW3
	ArrayList<LodgingVO> NewLodVos = lodDao.getLodList(1);
	
	//숙소 BEST3
	ArrayList<LodgingVO> BestLodVos = lodDao.getBestLodList();
	
	pageContext.setAttribute("lodVos", lodVos);
	pageContext.setAttribute("NewLodVos", NewLodVos);
	pageContext.setAttribute("BestLodVos", BestLodVos);
%>
<style>
	a {
		color:black;
		text-decoration-line: none !important; 
	}
	
	.houses a:hover {
		color:black;
	}
	
	/* #noneCategory {
 		display: none;
 	} */
	@media screen and (max-width:1000px) { 
	 	#noneCategory {
	 		display: block;
	 	}
	 	#category {
	 		display: none;
	 	}
	 }
</style>
<script src="https://code.iconify.design/2/2.2.1/iconify.min.js"></script>
<!-- Page content -->
<div class="w3-content" style="max-width:1500px;">
  <div class="w3-container w3-margin-top" id="houses">
  	<div>
	   <h3><strong>BEST Houses 3</strong></h3>
  	</div>
  </div>
  <div class="w3-row-padding w3-padding-16 houses">
   <c:forEach var="lodVO" items="${BestLodVos}">
	   <div class="w3-third w3-margin-bottom">
	  	   <a href="lodInfor.lod?lodIdx=${lodVO.idx}" ><img src="${ctp}/data/lodging/${lodVO.save_file_name}" style="width:100%; height: 300px;"/></a>
	      <div class="w3-container w3-white">
	        <a href="lodInfor.lod?lodIdx=${lodVO.idx}" ><h3 class="mt-2" style="font-size: 17px;">${lodVO.address}</h3></a>
	        <c:set var="priceFmt" value="${lodVO.price}"></c:set>
	        <h6><b>￦<fmt:formatNumber value="${priceFmt}"/>/박</b></h6>
	        <p class="w3-opacity">
	        침실 ${lodVO.option.bedroom}개, 침대 ${lodVO.option.bed}개, 욕실 ${lodVO.option.bathroom}개
	        </p>
	        <p class="w3-large"> 
	        <c:if test="${lodVO.option.air_conditioner == 'y'}">
	       	 <span class="iconify" data-icon="iconoir:air-conditioner" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.tv == 'y'}">
	       	 <span class="iconify" data-icon="gala:tv" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.wifi == 'y'}">
	         <i class="fa fa-wifi"></i>
	        </c:if>
	        <c:if test="${lodVO.option.washer == 'y'}">
	         <span class="iconify" data-icon="bxs:washer" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.kitchen == 'y'}">
	        	<i class="fa-solid fa-fire-burner"></i>
	        </c:if>
	        <c:if test="${lodVO.option.heating == 'y'}">
	        	<i class="fa-solid fa-temperature-high"></i>
	        </c:if>
	        <c:if test="${lodVO.option.toiletries == 'y'}">
	        	<span class="iconify" data-icon="mdi:toothbrush-paste" data-width="25"></span>
	        </c:if>
	         </p>
	      </div>
	    	
	    </div>
    </c:forEach>
  </div>
  <div class="w3-container w3-margin-top" id="houses">
  	<div>
	   <h3><strong>NEW Houses 3</strong></h3>
  	</div>
  </div>
  <div class="w3-row-padding w3-padding-16 houses">
   <c:forEach var="lodVO" items="${NewLodVos}">
	   <div class="w3-third w3-margin-bottom">
	  	   <a href="lodInfor.lod?lodIdx=${lodVO.idx}" ><img src="${ctp}/data/lodging/${lodVO.save_file_name}" style="width:100%; height: 300px;"/></a>
	      <div class="w3-container w3-white">
	        <a href="lodInfor.lod?lodIdx=${lodVO.idx}" ><h3 class="mt-2" style="font-size: 17px;">${lodVO.address}</h3></a>
	        <c:set var="priceFmt" value="${lodVO.price}"></c:set>
	        <h6><b>￦<fmt:formatNumber value="${priceFmt}"/>/박</b></h6>
	        <p class="w3-opacity">
	        침실 ${lodVO.option.bedroom}개, 침대 ${lodVO.option.bed}개, 욕실 ${lodVO.option.bathroom}개
	        </p>
	        <p class="w3-large"> 
	        <c:if test="${lodVO.option.air_conditioner == 'y'}">
	       	 <span class="iconify" data-icon="iconoir:air-conditioner" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.tv == 'y'}">
	       	 <span class="iconify" data-icon="gala:tv" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.wifi == 'y'}">
	         <i class="fa fa-wifi"></i>
	        </c:if>
	        <c:if test="${lodVO.option.washer == 'y'}">
	         <span class="iconify" data-icon="bxs:washer" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.kitchen == 'y'}">
	        	<i class="fa-solid fa-fire-burner"></i>
	        </c:if>
	        <c:if test="${lodVO.option.heating == 'y'}">
	        	<i class="fa-solid fa-temperature-high"></i>
	        </c:if>
	        <c:if test="${lodVO.option.toiletries == 'y'}">
	        	<span class="iconify" data-icon="mdi:toothbrush-paste" data-width="25"></span>
	        </c:if>
	         </p>
	      </div>
	    	
	    </div>
    </c:forEach>
  </div>
  
  
  <div class="w3-container w3-margin-top" id="houses">
  	<div id="noneCategory">
	   <h3>Lodging Houses</h3>
	  <p>Happiness & Rest & Peace is our slogan. We offer the best fantastic experience. Sleep well and rest well and experience fantasy.</p>
  	</div>
  </div>
   <div class="w3-row-padding w3-padding-16 houses">
   <c:forEach var="lodVO" items="${lodVos}">
	   <div class="w3-third w3-margin-bottom">
	  	   <a href="lodInfor.lod?lodIdx=${lodVO.idx}" ><img src="${ctp}/data/lodging/${lodVO.save_file_name}" style="width:100%; height: 300px;"/></a>
	      <div class="w3-container w3-white">
	        <a href="lodInfor.lod?lodIdx=${lodVO.idx}" ><h3 class="mt-2" style="font-size: 17px;">${lodVO.address}</h3></a>
	        <c:set var="priceFmt" value="${lodVO.price}"></c:set>
	        <h6><b>￦<fmt:formatNumber value="${priceFmt}"/>/박</b></h6>
	        <p class="w3-opacity">
	        침실 ${lodVO.option.bedroom}개, 침대 ${lodVO.option.bed}개, 욕실 ${lodVO.option.bathroom}개
	        </p>
	        
	        <p class="w3-large"> 
	        <c:if test="${lodVO.option.air_conditioner == 'y'}">
	       	 <span class="iconify" data-icon="iconoir:air-conditioner" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.tv == 'y'}">
	       	 <span class="iconify" data-icon="gala:tv" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.wifi == 'y'}">
	         <i class="fa fa-wifi"></i>
	        </c:if>
	        <c:if test="${lodVO.option.washer == 'y'}">
	         <span class="iconify" data-icon="bxs:washer" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.kitchen == 'y'}">
	        	<i class="fa-solid fa-fire-burner"></i>
	        </c:if>
	        <c:if test="${lodVO.option.heating == 'y'}">
	        	<i class="fa-solid fa-temperature-high"></i>
	        </c:if>
	        <c:if test="${lodVO.option.toiletries == 'y'}">
	        	<span class="iconify" data-icon="mdi:toothbrush-paste" data-width="25"></span>
	        </c:if>
	         </p>
	      </div>
	    	
	    </div>
    </c:forEach>
  
  </div>
  
  <!-- End page content -->
</div>