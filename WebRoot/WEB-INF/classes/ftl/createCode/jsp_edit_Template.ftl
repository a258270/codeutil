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
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		
		<script type="text/javascript" src="static/js/myjs/valid.js"></script><!-- 验证 -->
		
<script type="text/javascript">
	
	
	//保存
	function save(){
	<#list fieldList as var>
		<#if var[3] == "是" && var[8] == "是">
		<#if var[5] == "是">
		if($("#${var[0] }").val()=="-1" || $("#${var[0] }").val()==""){
			$("#${var[0] }").tips({
				side:3,
	            msg:'请选择${var[2] }',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#${var[0] }").focus();
			return false;
		}
		<#else>
		if($("#${var[0] }").val()==""){
			$("#${var[0] }").tips({
				side:3,
	            msg:'请输入${var[2] }',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#${var[0] }").focus();
			return false;
		}
		</#if>
			<#if var[1] == "Double">
			if(!validDouble($("#${var[0] }").val())){
				$("#${var[0] }").tips({
					side:3,
		            msg:'${var[2] }的格式不正确',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#${var[0] }").focus();
				return false;
			}
			</#if>
		</#if>
	</#list>
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
	//取消
	function cancle(){
		top.mainFrame.closeTab('${r"${msg }"}${objectNameLower}');
	}
	
</script>
	</head>
<body>
	<form action="${objectNameLower}/${r"${msg }"}.do?frameid=${r"${"}frameid${r"}"}" name="Form" id="Form" method="post">
		<input type="hidden" name="${objectNameUpper}_ID" id="${objectNameUpper}_ID" value="${r"${pd."}${objectNameUpper}_ID${r"}"}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
<#list fieldList as var>
	<#if var[3] == "是">
		<#if var[1] == 'Date'>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">${var[2] }:<#if var[8] == '是'><span style="color:red">*</span></#if></td>
				<td><input class="span10 date-picker" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" type="text" style="width:220px;" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="${var[2] }" title="${var[2] }"/></td>
			</tr>
		<#elseif var[1] == 'Datetime'>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">${var[2] }:<#if var[8] == '是'><span style="color:red">*</span></#if></td>
				<td><input class="span10 datetime-picker" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" type="text" style="width:220px;" data-date-format="yyyy-mm-dd hh:ii:ss" readonly="readonly" placeholder="${var[2] }" title="${var[2] }"/></td>
			</tr>
		<#elseif var[1] == 'Double'>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">${var[2] }:<#if var[8] == '是'><span style="color:red">*</span></#if></td>
				<td><input type="number" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }"/></td>
			</tr>
		<#elseif var[1] == 'Integer'>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">${var[2] }:<#if var[8] == '是'><span style="color:red">*</span></#if></td>
				<td><input type="number" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }"/></td>
			</tr>
		<#else>
			<#if var[5] == '是'>
				<tr>
					<td style="width:70px;text-align: right;padding-top: 13px;">${var[2] }:<#if var[8] == '是'><span style="color:red">*</span></#if></td>
					<td>
						<select class="chzn-select" name="${var[0] }" id="${var[0] }" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
							<option value="-1"></option>
							<c:forEach items='${r"${"}${var[6]}s${r"}"}' var="var">
								<c:if test='${r"${"}var.ZD_ID eq pd.${var[0]}${r"}"}'>
									<option value='${r"${"}var.ZD_ID${r"}"}' selected>${r"${"}var.NAME${r"}"}</option>
								</c:if>
								<c:if test='${r"${"}var.ZD_ID ne pd.${var[0]}${r"}"}'>
									<option value='${r"${"}var.ZD_ID${r"}"}'>${r"${"}var.NAME${r"}"}</option>
								</c:if>
							</c:forEach>
					  	</select>
				  	</td>
			  	</tr>
			<#else>
				<tr>
					<td style="width:70px;text-align: right;padding-top: 13px;">${var[2] }:<#if var[8] == '是'><span style="color:red">*</span></#if></td>
					<td><input type="text" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }"/></td>
				</tr>
			</#if>
			
		</#if>
	</#if>
</#list>
			<c:if test="${r"${msg != 'details'}"}">
				<tr>
					<td style="text-align: center;" colspan="10">
						<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
						<a class="btn btn-mini btn-danger" onclick="cancle();">取消</a>
					</td>
				</tr>
			</c:if>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script>
		<script type="text/javascript">
		$(top.clearProcess());
		$(function() {
			if("${r"${msg}"}" == "details"){
				var form = document.forms[0];
				for(var i = 0; i < form.length; i++){
					var element = form.elements[i];
					element.disabled = "true";
				}
			}
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datetimepicker({
				language:  'zh-CN',
		        weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0
			});
			$('.datetime-picker').datetimepicker({
				language:  'zh-CN',
		        weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				forceParse: 0,
				minuteStep: 1,
		        showMeridian: 1
			});
			
		});
		
		</script>
</body>
</html>