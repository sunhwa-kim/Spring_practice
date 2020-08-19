<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<page:applyDecorator name="index">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<title><spring:message code="title.stat.login.confirm"/> | <spring:message code="title.main"/></title>
</head>
<body>
<div id="mainContents">
  <!-- 이메일 인증 미완료 -->
  <div class="registerComplete" style="border:none;">
    <p class="big">이메일 인증이 정상적으로 처리 되지 않았습니다.</p>
    <p class="small">
      관리자에게 문의 바랍니다.<br>
      국가과학기술연구회 통합통계정보서비스를 이용해 주셔서 감사합니다.
    </p>
    <!-- 로그인 버튼 -->
    <%-- <a href="${ctxt}/login/login.do" class="goHome">로그인하기</a> --%>
  </div>
</div>
</body>
</html>
</page:applyDecorator>
