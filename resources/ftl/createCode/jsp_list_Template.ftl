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
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
	</head>
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="${objectNameLower}/list.do?frameid=${r"${"}frameid${r"}"}" method="post" name="Form" id="Form">
			<table>
				<tr>
					<#list fieldList as var>
					<#if var[9] == '是'>
					
					<#if var[5] == '否'>
					<#if var[1] == 'String'>
					<td>
						${var[2]}:
						<span>
							<input autocomplete="off" id="nav-search-input" type="text" name="${var[0]}" value="${r"${"}pd.${var[0]}${r"}"}" placeholder="这里输入${var[2]}" />
						</span>
					</td>
					</#if>
					<#if var[1] == 'Date'>
					<td>
						${var[2]}:
						<span>
							<input class="span10 date-picker" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" type="text" style="width:220px;" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="${var[2] }" title="${var[2] }"/>
						</span>
					</td>
					</#if>
					<#if var[1] == 'Datetime'>
					<td>
						${var[2]}:
						<span>
							<input class="span10 datetime-picker" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" type="text" style="width:220px;" data-date-format="yyyy-mm-dd hh:ii:ss" readonly="readonly" placeholder="${var[2] }" title="${var[2] }"/>
						</span>
					</td>
					</#if>
					<#if var[1] == 'Integer'>
					<td>
						${var[2]}:
						<span>
							<input type="number" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }"/>
						</span>
					</td>
					</#if>
					<#if var[1] == 'Double'>
					<td>
						${var[2]}:
						<span>
							<input type="number" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }"/>
						</span>
					</td>
					</#if>
					</#if>
					
					<#if var[5] == '是' && var[6] != '无'>
					<td>
						${var[2]}:
						<span>
							<select class="chzn-select" name="${var[0]}" id="${var[0] }" data-placeholder="请选择${var[2] }" style="vertical-align:top;width: 120px;">
								<option value="-1"></option>
								<c:forEach items='${r"${"}${var[6]}s${r"}"}' var="var">
									<c:if test='${r"${"}var.ZD_ID ${r"eq"} pd.${var[0]}${r"}"}'>
										<option value='${r"${"}var.ZD_ID${r"}"}' selected>${r"${"}var.NAME${r"}"}</option>
									</c:if>
									<c:if test='${r"${var.ZD_ID"} ${r"ne"} pd.${var[0]}${r"}"}'>
										<option value='${r"${"}var.ZD_ID${r"}"}'>${r"${"}var.NAME${r"}"}</option>
									</c:if>
								</c:forEach>
						  	</select>
						</span>
					</td>
					</#if>
					</#if>
					</#list>
					
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i>检索</button></td>
					<c:if test="${r"${QX.cha == 1 }"}">
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
					</c:if>
				</tr>
			</table>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
				<#list fieldList as var>
					<#if var[7] == '是'>
						<th class="center">${var[2]}</th>
					</#if>
				</#list>
						<th class="center">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${r"${not empty varList}"}">
						<c:if test="${r"${QX.cha == 1 }"}">
						<c:forEach items="${r"${varList}"}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${r"${var."}${objectNameUpper}_ID${r"}"}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${r"${vs.index+1}"}</td>
								<#list fieldList as var>
									<#if var[7] == '是'>
										<td class='center'>${r"${var."}${var[0]}${r"}"}</td>
									</#if>
								</#list>
								<td style="width: 30px;" class="center">
									<div class='hidden-phone visible-desktop btn-group'>
									
										<c:if test="${r"${QX.edit != 1 && QX.del != 1 }"}">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i> 操作</button>
										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
											<c:if test="${r"${QX.cha == 1 }"}">
											<li><a style="cursor:pointer;" title="详情" onclick="details('${r"${var."}${objectNameUpper}_ID${r"}"}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-search"></i></span>详情</a></li>
											</c:if>
											<c:if test="${r"${QX.edit == 1 }"}">
											<li><a style="cursor:pointer;" title="编辑" onclick="edit('${r"${var."}${objectNameUpper}_ID${r"}"}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span>编辑</a></li>
											</c:if>
											<c:if test="${r"${QX.del == 1 }"}">
											<li><a style="cursor:pointer;" title="删除" onclick="del('${r"${var."}${objectNameUpper}_ID${r"}"}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span>删除</a></li>
											</c:if>
										</ul>
										</div>
									</div>
								</td>
							</tr>
						
						</c:forEach>
						</c:if>
						<c:if test="${r"${QX.cha == 0 }"}">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
					
				
				</tbody>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
					<c:if test="${r"${QX.add == 1 }"}">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					</c:if>
					<c:if test="${r"${QX.del == 1 }"}">
					<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
					</c:if>
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${r"${page.pageStr}"}</div></td>
			</tr>
		</table>
		</div>
		</form>
	</div>
 
 
 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script>
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.clearProcess());
		
		//检索
		function search(){
			top.jzts();
			$("#Form").submit();
		}
		
		//新增
		function add(){
			 top.jzts();
			 top.mainFrame.tabAddHandler('save${objectNameLower}', "新增${cnName}", "<%=basePath%>${objectNameLower}/goAdd.do?frameid=${r"${"}frameid${r"}"}");
		}
		
		//详情
		function details(Id){
			top.jzts();
			 top.mainFrame.tabAddHandler('details${objectNameLower}', "查看${cnName}", "<%=basePath%>${objectNameLower}/goDetails.do?${objectNameUpper}_ID="+Id);
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>${objectNameLower}/delete.do?${objectNameUpper}_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${r"${page.currentPage}"});
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 top.mainFrame.tabAddHandler('edit${objectNameLower}', "编辑${cnName}", "<%=basePath%>${objectNameLower}/goEdit.do?${objectNameUpper}_ID="+Id + "&frameid=${r"${"}frameid${r"}"}");
		}
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//下拉框
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
			
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
		});
		
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								"label" : "关闭",
								"class" : "btn-small btn-success",
								"callback": function() {
									//Example.show("great success");
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>${objectNameLower}/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${r"${page.currentPage}"});
									 });
								}
							});
						}
					}
				}
			});
		}
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>${objectNameLower}/excel.do';
		}
		</script>
		
	</body>
</html>

