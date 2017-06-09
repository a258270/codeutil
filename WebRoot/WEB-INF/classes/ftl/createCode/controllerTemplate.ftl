package com.fh.controller.${packageName}.${objectNameLower};

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;
import com.fh.service.${packageName}.${objectNameLower}.${objectName}Service;
import com.fh.service.system.dictionaries.DictionariesService;

/** 
 * 类名称：${objectName}Controller
 * 创建人：ZMJ 
 * 创建时间：${nowDate?string("yyyy-MM-dd")}
 */
@Controller
@RequestMapping(value="/${objectNameLower}")
public class ${objectName}Controller extends BaseController {
	
	String menuUrl = "${objectNameLower}/list.do"; //菜单地址(权限用)
	@Resource(name="${objectNameLower}Service")
	private ${objectName}Service ${objectNameLower}Service;
	@Resource(name="dictionariesService")
	private DictionariesService dictionariesService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增${objectName}");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("frameid", pd.get("frameid"));
		pd.put("${objectNameUpper}_ID", this.get32UUID());	//主键
<#list fieldList as var>
	<#if var[3] == "否">
		<#if var[1] == 'Date' || var[1] == 'Datetime'>
		pd.put("${var[0]}", Tools.date2Str(new Date()));	//${var[2]}
		<#else>
		pd.put("${var[0]}", "${var[4]?replace("无","")}");	//${var[2]}
		</#if>
	</#if>
</#list>
<#list fieldList as var>
	<#if var[1] == 'Double'>
		if(pd.get("${var[0]}") == null || pd.get("${var[0]}").equals(""))
			pd.put("${var[0]}", 0);
	</#if>
</#list>
		${objectNameLower}Service.save(pd);
		mv.addObject("msg","success");
		mv.addObject("flag","save");
		mv.addObject("id","${objectNameLower}");
		mv.setViewName("save_result2");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除${objectName}");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			${objectNameLower}Service.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改${objectName}");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("frameid", pd.get("frameid"));
<#list fieldList as var>
	<#if var[1] == 'Double'>
		if(pd.get("${var[0]}") == null || pd.get("${var[0]}").equals(""))
			pd.put("${var[0]}", 0);
	</#if>
</#list>
		${objectNameLower}Service.edit(pd);
		mv.addObject("msg","success");
		mv.addObject("flag","edit");
		mv.addObject("id","${objectNameLower}");
		mv.setViewName("save_result2");
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表${objectName}");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			mv.addObject("frameid", pd.get("frameid"));
			page.setPd(pd);
			List<PageData>	varList = ${objectNameLower}Service.list(page);	//列出${objectName}列表
			mv.setViewName("${packageName}/${objectNameLower}/${objectNameLower}_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
			
			<#list fieldList as var>
			<#if var[5] == '是' && var[6] != '无'>
			PageData ${var[6]} = new PageData();
            ${var[6]}.put("BIANMA", "${var[6]}");
            ${var[6]} = dictionariesService.findBmCount(${var[6]});
            ${var[6]}.put("PARENT_ID", ${var[6]}.get("ZD_ID"));
            List<PageData> ${var[6]}s = dictionariesService.dictlistAll(${var[6]});
            mv.addObject("${var[6]}s", ${var[6]}s);
			</#if>
			</#list>
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增${objectName}页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.addObject("frameid", pd.getString("frameid"));
			mv.setViewName("${packageName}/${objectNameLower}/${objectNameLower}_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
			<#list fieldList as var>
			<#if var[5] == '是' && var[6] != '无'>
            PageData ${var[6]} = new PageData();
            ${var[6]}.put("BIANMA", "${var[6]}");
            ${var[6]} = dictionariesService.findBmCount(${var[6]});
            ${var[6]}.put("PARENT_ID", ${var[6]}.get("ZD_ID"));
            List<PageData> ${var[6]}s = dictionariesService.dictlistAll(${var[6]});
            mv.addObject("${var[6]}s", ${var[6]}s);
			</#if>
			</#list>
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改${objectName}页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.addObject("frameid", pd.getString("frameid"));
			pd = ${objectNameLower}Service.findById(pd);	//根据ID读取
			mv.setViewName("${packageName}/${objectNameLower}/${objectNameLower}_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
			<#list fieldList as var>
			<#if var[5] == '是' && var[6] != '无'>
			PageData ${var[6]} = new PageData();
			${var[6]}.put("BIANMA", "${var[6]}");
			${var[6]} = dictionariesService.findBmCount(${var[6]});
			${var[6]}.put("PARENT_ID", ${var[6]}.get("ZD_ID"));
			List<PageData> ${var[6]}s = dictionariesService.dictlistAll(${var[6]});
			mv.addObject("${var[6]}s", ${var[6]}s);
			</#if>
			</#list>
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去详情页面
	 */
	@RequestMapping(value="/goDetails")
	public ModelAndView goDetails(){
		logBefore(logger, "去${objectName}详情页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = ${objectNameLower}Service.findById(pd);	//根据ID读取
			mv.setViewName("${packageName}/${objectNameLower}/${objectNameLower}_edit");
			mv.addObject("msg", "details");
			mv.addObject("pd", pd);
			<#list fieldList as var>
			<#if var[5] == '是' && var[6] != '无'>
			PageData ${var[6]} = new PageData();
			${var[6]}.put("BIANMA", "${var[6]}");
			${var[6]} = dictionariesService.findBmCount(${var[6]});
			${var[6]}.put("PARENT_ID", ${var[6]}.get("ZD_ID"));
			List<PageData> ${var[6]}s = dictionariesService.dictlistAll(${var[6]});
			mv.addObject("${var[6]}s", ${var[6]}s);
			</#if>
			</#list>
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除${objectName}");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				${objectNameLower}Service.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出${objectName}到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
	<#list fieldList as var>
			titles.add("${var[2]}");	//${var_index+1}
	</#list>
			dataMap.put("titles", titles);
			List<PageData> varOList = ${objectNameLower}Service.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
	<#list fieldList as var>
			<#if var[1] == 'Integer'>
				vpd.put("var${var_index+1}", varOList.get(i).get("${var[0]}").toString());	//${var_index+1}
			<#else>
				vpd.put("var${var_index+1}", varOList.get(i).get("${var[0]}").toString());	//${var_index+1}
			</#if>
	</#list>
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
