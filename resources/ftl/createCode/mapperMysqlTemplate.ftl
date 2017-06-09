<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://www.mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${objectName}Mapper">
	
	
	<!-- 新增-->
	<insert id="save" parameterType="pd">
		insert into ${tabletop}${objectNameUpper}(
	<#list fieldList as var>
			${var[0]},	
	</#list>
			${objectNameUpper}_ID
		) values (
	<#list fieldList as var>
			${r"#{"}${var[0]}${r"}"},	
	</#list>
			${r"#{"}${objectNameUpper}_ID${r"}"}
		)
	</insert>
	
	
	<!-- 删除-->
	<delete id="delete" parameterType="pd">
		delete from ${tabletop}${objectNameUpper}
		where 
			${objectNameUpper}_ID = ${r"#{"}${objectNameUpper}_ID${r"}"}
	</delete>
	
	
	<!-- 修改 -->
	<update id="edit" parameterType="pd">
		update  ${tabletop}${objectNameUpper}
			set 
	<#list fieldList as var>
		<#if var[3] == "是">
				${var[0]} = ${r"#{"}${var[0]}${r"}"},
		</#if>
	</#list>
			${objectNameUpper}_ID = ${objectNameUpper}_ID
			where 
				${objectNameUpper}_ID = ${r"#{"}${objectNameUpper}_ID${r"}"}
	</update>
	
	
	<!-- 通过ID获取数据 -->
	<select id="findById" parameterType="pd" resultType="pd">
		select 
	<#list fieldList as var>
			${var[0]},	
	</#list>
			${objectNameUpper}_ID
		from 
			${tabletop}${objectNameUpper}
		where 
			${objectNameUpper}_ID = ${r"#{"}${objectNameUpper}_ID${r"}"}
	</select>
	
	
	<!-- 列表 -->
	<select id="datalistPage" parameterType="page" resultType="pd">
		select
		<#list fieldList as var>
			<#if var[5] == '是'>
				b${var_index}.NAME AS ${var[0]},
			<#else>
				a.${var[0]},
			</#if>
		</#list>
				a.${objectNameUpper}_ID
				from ${tabletop}${objectNameUpper} a
				<#if isBox == '是'>
				<#list fieldList as var>
				<#if var[5] == '是'>
				LEFT JOIN SYS_DICTIONARIES b${var_index} ON a.${var[0]}=b${var_index}.ZD_ID
				</#if>
				</#list>
				</#if>
				<#if isSS == '是'>
				<where>
					<#list fieldList as var>
					<#if var[9] == '是'>
					
					<#if var[5] == '否'>
					<if test="pd.${var[0]} ${r" != null and"} pd.${var[0]} ${r" != ''"}">
					<#if var[10] == 'like'>
					${r"AND"} a.${var[0]} LIKE ${r"CONCAT(CONCAT('%', #{pd."}${var[0]}${r"}),'%')"}
					</#if>
					<#if var[10] == '>='>
					${r"AND"} a.${var[0]} ${r"&gt;="} ${r"#{pd."}${var[0]}${r"}"}
					</#if>
					<#if var[10] == '<='>
					${r"AND"} a.${var[0]} ${r"&lt;="} ${r"#{pd."}${var[0]}${r"}"}
					</#if>
					<#if var[10] == '<'>
					${r"AND"} a.${var[0]} ${r"&lt;"} ${r"#{pd."}${var[0]}${r"}"}
					</#if>
					<#if var[10] == '>'>
					${r"AND"} a.${var[0]} ${r"&gt;"} ${r"#{pd."}${var[0]}${r"}"}
					</#if>
					<#if var[10] == '='>
					${r"AND"} a.${var[0]} ${r"="} ${r"#{pd."}${var[0]}${r"}"}
					</#if>
					</if>
					</#if>
					
					<#if var[5] == '是'>
					<if test="pd.${var[0]} ${r" != null and"} pd.${var[0]} ${r" != '' and "}pd.${var[0]} ${r" != '-1'"}">
					${r"AND"} a.${var[0]} ${r"="} ${r"#{pd."}${var[0]}${r"}"}
					</if>
					</#if>
					
					</#if>
					</#list>
				</where>
				</#if>
				GROUP BY a.${objectNameUpper}_ID
	</select>
	
	<!-- 列表(全部) -->
	<select id="listAll" parameterType="pd" resultType="pd">
		select
		<#list fieldList as var>
			<#if var[5] == '是'>
				b${var_index}.NAME AS ${var[0]},
			<#else>
				a.${var[0]},
			</#if>
		</#list>
				a.${objectNameUpper}_ID
				from ${tabletop}${objectNameUpper} a
				<#if isBox == '是'>
				<#list fieldList as var>
				<#if var[5] == '是'>
				LEFT JOIN SYS_DICTIONARIES b${var_index} ON a.${var[0]}=b${var_index}.ZD_ID
				</#if>
				</#list>
				</#if>	
	</select>
	
	<!-- 列表(全部) -->
	<select id="listAllEx" parameterType="pd" resultType="pd">
		select
		<#list fieldList as var>
				${var[0]},
		</#list>
				${objectNameUpper}_ID
				from ${tabletop}${objectNameUpper}
	</select>
	
	<!-- 批量删除 -->
	<delete id="deleteAll" parameterType="String">
		delete from ${tabletop}${objectNameUpper}
		where 
			${objectNameUpper}_ID in
		<foreach item="item" index="index" collection="array" open="(" separator="," close=")">
                 ${r"#{item}"}
		</foreach>
	</delete>
	
</mapper>