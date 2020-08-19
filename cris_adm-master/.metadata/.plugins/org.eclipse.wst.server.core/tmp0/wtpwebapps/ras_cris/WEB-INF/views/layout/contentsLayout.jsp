<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta property = "og:description"  name="faceDes" content = "페이스북 공유" />
<meta property = "og:image" name="faceImg"  content = "http://library.nih.go.kr${ctxt}/resources/images/sub/facelogo.png"/>  

<script type="text/javascript">
	<%-- googleAnalytics (Start) --%>
	var _gaq = _gaq || [];
	_gaq.push([ '_setAccount', 'UA-49580594-1' ]);
	_gaq.push([ '_setDomainName', 'nih.go.kr' ]);
	_gaq.push([ '_setAllowLinker', true ]);
	_gaq.push([ '_trackPageview' ]);

	(function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);
	})();
	<%--  googleAnalytics (End) --%>
</script>  

<title>질병관리본부 국립의과학지식센터</title>
    <tiles:insertAttribute name="subMeta" />   
</head>
<body>
 	<tiles:insertAttribute name="subHeader"/>
	 <!-- <div id="container">   -->	
	 	<div id="container_box">
		<div id="container-wrap">
			<tiles:insertAttribute name="subLeftmenu"/>
				 <div id="content">
				 	<tiles:insertAttribute name="subBody"/>
				 </div>
		</div>
	 </div>       
		<tiles:insertAttribute name="subFooter"/>
</body>

</html>