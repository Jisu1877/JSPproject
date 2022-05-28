<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s4">
      <!-- <img src="images/avatar2.png" class="w3-circle w3-margin-right" style="width:46px"> -->
    </div>
    <div class="w3-col s8 w3-bar">
      <span>Welcome, <strong>Admin</strong></span><br>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i></a>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-user"></i></a>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-cog"></i></a>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5>Dashboard</h5>
  </div>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="<%=request.getContextPath()%>/adminHome.ad" class="w3-bar-item w3-button w3-padding"><i class="fa-solid fa-house-user"></i>  Admin Home</a>
    <a href="<%=request.getContextPath()%>/mem_management.ad" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i>  회원 관리</a>
    <a href="<%=request.getContextPath()%>/lod_management.ad" class="w3-bar-item w3-button w3-padding"><i class="fa-solid fa-tents"></i>  숙소 관리</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa-solid fa-calendar-check"></i>  예약 관리</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa-solid fa-file-pen"></i>  리뷰 관리</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bell fa-fw"></i>  공지사항 관리</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-cog fa-fw"></i>  Settings</a><br><br>
  </div>
</nav>