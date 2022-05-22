<%@page import="admin.lodging.LodgingVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="admin.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	AdminDAO adminDAO = new AdminDAO();
	ArrayList<LodgingVO> lodVos = adminDAO.getLodList();
	
	pageContext.setAttribute("lodVos", lodVos);
%>

<!-- Page content -->
<div class="w3-content" style="max-width:1532px;">

  <div class="w3-container w3-margin-top" id="houses">
    <h3>Lodging Houses</h3>
    <p>Happiness & Rest & Peace is our slogan. We offer the best fantastic experience. Sleep well and rest well and experience fantasy.</p>
  </div>
  
   <div class="w3-row-padding w3-padding-16">
   <c:forEach var="lodVO" items="${lodVos}">
	   <div class="w3-third w3-margin-bottom">
	      <img src="images/room_single.jpg" alt="Norway" style="width:100%">
	      <div class="w3-container w3-white">
	        <h3>${lodVO.lod_name}</h3>
	        <h6 class="w3-opacity">From $99</h6>
	        <p>Single bed</p>
	        <p>15m<sup>2</sup></p>
	        <p class="w3-large"><i class="fa fa-bath"></i> <i class="fa fa-phone"></i> <i class="fa fa-wifi"></i></p>
	        <button class="w3-button w3-block w3-black w3-margin-bottom">Choose Room</button>
	      </div>
	    </div>
    </c:forEach>
  
  </div>