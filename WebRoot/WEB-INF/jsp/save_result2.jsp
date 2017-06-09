<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>保存结果</title>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>

</head>
<body>
	<div id="zhongxin"></div>
	
	<script type="text/javascript">
		var msg = "${msg}";
		var flag = "${flag}";
		var tabId = "${id}";
		if(msg=="success" || msg==""){
			//document.getElementById('zhongxin').style.display = 'none';
			$("#zhongxin").html("<div class='dialog'> <h1>操作成功</h1> <p>操作成功，点击返回关闭当前页面。</p><p><a href='javascript:cancle();'>返 回</a></p></div>");
			$(window.parent.document).contents().find("#${frameid}")[0].contentWindow.search();
			//top.Dialog.close();
		}else{
			//top.Dialog.close();
			$("#zhongxin").html("<div class='dialog'> <h1>操作失败</h1> <p>操作失败，原因：${reason}，点击返回。</p><p><a href='javascript:history.go(-1);'>返 回</a></p></div>");
		}
		
		function cancle(){
			top.mainFrame.closeTab(flag + tabId);
		}
	</script>
</body>
</html>