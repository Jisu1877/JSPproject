<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	int level = session.getAttribute("sLevel") == null ? 99 : (int) session.getAttribute("sLevel");
%>
<style>
	a:hover {
		color : black;
	}
</style>
<!-- Navigation Bar -->
<div class="w3-bar w3-white w3-large">
  <a href="<%=request.getContextPath()%>/" class="w3-bar-item w3-btn w3-theme w3-mobile"><i class="fa-solid fa-tents"></i>&nbsp;Fantastic Lodging</a>
  <a href="#houses" class="w3-bar-item w3-btn w3-mobile">Lodging Houses</a>
  <a href="#about" class="w3-bar-item w3-btn w3-mobile">About</a>
  <a href="#contact" class="w3-bar-item w3-btn w3-mobile">Contact</a>
  <!-- <a href="#contact" class="w3-bar-item w3-button w3-right w3-light-grey w3-mobile">Login</a> -->
  <%  if(level != 99) { %>
  		<a href="<%=request.getContextPath()%>/memLogOut.mem" class="w3-bar-item w3-btn w3-right w3-light-grey w3-mobile">Logout</a>
  <% } else {%>
  		<a href="<%=request.getContextPath()%>/memLogin.mem" class="w3-bar-item w3-btn w3-right w3-light-grey w3-mobile">Login</a>
  <% } %>
  <% if(level == 0) { %>
		<a href="<%=request.getContextPath()%>/adminHome.ad" class="w3-bar-item w3-btn w3-right w3-black w3-mobile">Admin</a>
  <% } else if(level == 99) { %>
  		<a href="<%=request.getContextPath()%>/termsOfService.mem" class="w3-bar-item w3-btn w3-right w3-light-grey w3-mobile">Join</a>
  <% } %>
</div>
