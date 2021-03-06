<#if packageStyle == "service">
package ${bussiPackage}.${entityPackage}.service.impl;
import ${bussiPackage}.${entityPackage}.service.${entityName}ServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import ${bussiPackage}.${entityPackage}.entity.${entityName}Entity;
<#list subTab as sub>
import ${bussiPackage}.${sub.entityPackage}.entity.${sub.entityName}Entity;
</#list>
<#else>
package ${bussiPackage}.service.impl.${entityPackage};
import ${bussiPackage}.service.${entityPackage}.${entityName}ServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import ${bussiPackage}.entity.${entityPackage}.${entityName}Entity;
<#list subTab as sub>
import ${bussiPackage}.entity.${sub.entityPackage}.${sub.entityName}Entity;
</#list>
</#if>

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.MyClassLoader;
import org.jeecgframework.web.cgform.enhance.CgformEnhanceJavaInter;
<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
import java.util.ArrayList;
import java.util.UUID;
import java.io.Serializable;

<#-- update--begin--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
import java.util.Map;
import java.util.HashMap;
import org.jeecgframework.minidao.util.FreemarkerParseFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.jeecgframework.core.util.ResourceUtil;
<#-- update--end--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->


@Service("${entityName?uncap_first}Service")
@Transactional
public class ${entityName}ServiceImpl extends CommonServiceImpl implements ${entityName}ServiceI {

	<#-- update--begin--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	<#-- update--end--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
 	public void delete(${entityName}Entity entity) throws Exception{
 		super.delete(entity);
 		<#if (buttonSqlMap?? && buttonSqlMap?size>0) || (buttonJavaMap?? && buttonJavaMap?size>0)>
 		//执行删除操作增强业务
		this.doDelBus((${entityName}Entity)entity);
		</#if>
 	}
	<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
	
	<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
	public void addMain(${entityName}Entity ${entityName?uncap_first},
	        <#list subTab as sub>List<${sub.entityName}Entity> ${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>) throws Exception{
	<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
			//保存主信息
			this.save(${entityName?uncap_first});
		
			<#list subTab as sub>
			/**保存-${sub.ftlDescription}*/
			for(${sub.entityName}Entity ${sub.entityName?uncap_first}:${sub.entityName?uncap_first}List){
				<#list sub.foreignKeys as key>
				//外键设置
				<#-- update--begin--author:zhoujf date:20180503 for:一对多主子表关联外键的问题-->
				<#if key?lower_case?index_of("${jeecg_table_id}")!=-1>
				${sub.entityName?uncap_first}.set${key?cap_first}(${entityName?uncap_first}.get${jeecg_table_id?cap_first}());
				<#else>
				${sub.entityName?uncap_first}.set${key?cap_first}(${entityName?uncap_first}.get${key}());
				</#if>
				</#list>
				<#-- update--end--author:zhoujf date:20180503 for:一对多主子表关联外键的问题-->
				this.save(${sub.entityName?uncap_first});
			}
			</#list>
			<#if (buttonSqlMap?? && buttonSqlMap?size>0) || (buttonJavaMap?? && buttonJavaMap?size>0)>
			<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
			//执行新增操作配置的sql增强
 			this.doAddBus(${entityName?uncap_first});
 			<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
 			</#if>
	}

	
	<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
	public void updateMain(${entityName}Entity ${entityName?uncap_first},
	        <#list subTab as sub>List<${sub.entityName}Entity> ${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>) throws Exception {
	<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
		//保存主表信息
		<#-- update--begin--author:gj_shaojc Date:20180323 for:TASK #2582 【bug修改】t:dictSelect标签 readonly 的问题 -->
		if(StringUtil.isNotEmpty(${entityName?uncap_first}.get${jeecg_table_id?cap_first}())){
			try {
				${entityName}Entity temp = findUniqueByProperty(${entityName}Entity.class, "${jeecg_table_id}", ${entityName?uncap_first}.get${jeecg_table_id?cap_first}());
				MyBeanUtils.copyBeanNotNull2Bean(${entityName?uncap_first}, temp);
				this.saveOrUpdate(temp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			this.saveOrUpdate(${entityName?uncap_first});
		}
		<#-- update--end--author:gj_shaojc Date:20180323 for:TASK #2582 【bug修改】t:dictSelect标签 readonly 的问题 -->
		//===================================================================================
		//获取参数
	    <#list subTab as sub>
		    <#list sub.foreignKeys as key>
		    <#if key?lower_case?index_of("${jeecg_table_id}")!=-1>
		Object ${jeecg_table_id}${sub_index} = ${entityName?uncap_first}.get${jeecg_table_id?cap_first}();
		    <#else>
		Object ${key?uncap_first}${sub_index} = ${entityName?uncap_first}.get${key}();
		    </#if>
		    </#list>
	    </#list>
		<#list subTab as sub>
		//===================================================================================
		//1.查询出数据库的明细数据-${sub.ftlDescription}
	    String hql${sub_index} = "from ${sub.entityName}Entity where 1 = 1<#list sub.foreignKeys as key> AND ${key?uncap_first} = ? </#list>";
	    List<${sub.entityName}Entity> ${sub.entityName?uncap_first}OldList = this.findHql(hql${sub_index},<#list sub.foreignKeys as key><#if key?lower_case?index_of("${jeecg_table_id}")!=-1>${jeecg_table_id}${sub_index}<#else>${key?uncap_first}${sub_index}</#if><#if key_has_next>,</#if></#list>);
		//2.筛选更新明细数据-${sub.ftlDescription}
		if(${sub.entityName?uncap_first}List!=null&&${sub.entityName?uncap_first}List.size()>0){
		for(${sub.entityName}Entity oldE:${sub.entityName?uncap_first}OldList){
			boolean isUpdate = false;
				for(${sub.entityName}Entity sendE:${sub.entityName?uncap_first}List){
					//需要更新的明细数据-${sub.ftlDescription}
					if(oldE.getId().equals(sendE.getId())){
		    			try {
							MyBeanUtils.copyBeanNotNull2Bean(sendE,oldE);
							this.saveOrUpdate(oldE);
						} catch (Exception e) {
							e.printStackTrace();
							throw new BusinessException(e.getMessage());
						}
						isUpdate= true;
		    			break;
		    		}
		    	}
	    		if(!isUpdate){
		    		//如果数据库存在的明细，前台没有传递过来则是删除-${sub.ftlDescription}
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-${sub.ftlDescription}
			for(${sub.entityName}Entity ${sub.entityName?uncap_first}:${sub.entityName?uncap_first}List){
				if(oConvertUtils.isEmpty(${sub.entityName?uncap_first}.getId())){
					//外键设置
					<#-- update--begin--author:zhoujf date:20180503 for:一对多主子表关联外键的问题-->
					 <#list sub.foreignKeys as key>
					    <#if key?lower_case?index_of("${jeecg_table_id}")!=-1>
					${sub.entityName?uncap_first}.set${key?cap_first}(${entityName?uncap_first}.get${jeecg_table_id?cap_first}());
					    <#else>
					${sub.entityName?uncap_first}.set${key?cap_first}(${entityName?uncap_first}.get${key}());
					    </#if>
					 </#list>
					 <#-- update--end--author:zhoujf date:20180503 for:一对多主子表关联外键的问题-->
					this.save(${sub.entityName?uncap_first});
				}
			}
		}
		</#list>
		<#if (buttonSqlMap?? && buttonSqlMap?size>0) || (buttonJavaMap?? && buttonJavaMap?size>0)>
		<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
		//执行更新操作增强业务
 		this.doUpdateBus(${entityName?uncap_first});
 		<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
 		</#if>
	}

	
	<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
	public void delMain(${entityName}Entity ${entityName?uncap_first}) throws Exception {
	<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
		//删除主表信息
		this.delete(${entityName?uncap_first});
		//===================================================================================
		//获取参数
	    <#list subTab as sub>
		    <#list sub.foreignKeys as key>
		    <#if key?lower_case?index_of("${jeecg_table_id}")!=-1>
		Object ${jeecg_table_id}${sub_index} = ${entityName?uncap_first}.get${jeecg_table_id?cap_first}();
		    <#else>
		Object ${key?uncap_first}${sub_index} = ${entityName?uncap_first}.get${key}();
		    </#if>
		    </#list>
	    </#list>
		<#list subTab as sub>
		//===================================================================================
		//删除-${sub.ftlDescription}
	    String hql${sub_index} = "from ${sub.entityName}Entity where 1 = 1<#list sub.foreignKeys as key> AND ${key?uncap_first} = ? </#list>";
	    List<${sub.entityName}Entity> ${sub.entityName?uncap_first}OldList = this.findHql(hql${sub_index},<#list sub.foreignKeys as key><#if key?lower_case?index_of("${jeecg_table_id}")!=-1>${jeecg_table_id}${sub_index}<#else>${key?uncap_first}${sub_index}</#if><#if key_has_next>,</#if></#list>);
		this.deleteAllEntitie(${sub.entityName?uncap_first}OldList);
		</#list>
		
		<#if (buttonSqlMap?? && buttonSqlMap?size>0) || (buttonJavaMap?? && buttonJavaMap?size>0)>
 		<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
 		////执行删除操作增强业务
		this.doDelBus((${entityName}Entity)${entityName?uncap_first});
		<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
		</#if>
	}
	
	<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
	<#list buttons as btn>
	<#if btn.buttonStyle =='button' && btn.optType=='action'>
	 /**
	 * 自定义按钮-[${btn.buttonName}]业务处理
	 * @param id
	 * @return
	 */
	 public void do${btn.buttonCode?cap_first}Bus(${entityName}Entity t) throws Exception{
	 	//-----------------sql增强 start----------------------------
	 	<#list buttonSqlMap[btn.buttonCode]! as sql>
	 	//sql增强第${sql_index+1}条
	 	String sqlEnhance_${sql_index+1} ="${sql}";
	 	<#-- update--begin--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	 	this.executeSqlEnhance(sqlEnhance_${sql_index+1},t);
	 	<#-- update--end--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	 	</#list>
	 	//-----------------sql增强 end------------------------------
	 	
	 	//-----------------java增强 start---------------------------
	 	<#if buttonJavaMap??&&buttonJavaMap[btn.buttonCode]?? >
	 		Map<String,Object> data = populationMap(t);
	 		executeJavaExtend("${buttonJavaMap[btn.buttonCode].cgJavaType}","${buttonJavaMap[btn.buttonCode].cgJavaValue}",data);
	 	</#if>
	 	//-----------------java增强 end-----------------------------
	 }
 	</#if>
 	</#list> 
 	
 	<#if (buttonSqlMap?? && buttonSqlMap?size>0) || (buttonJavaMap?? && buttonJavaMap?size>0)>
 	/**
	 * 新增操作增强业务
	 * @param t
	 * @return
	 */
	private void doAddBus(${entityName}Entity t) throws Exception{
		//-----------------sql增强 start----------------------------
 		<#list buttonSqlMap['add']! as sql>
	 	//sql增强第${sql_index+1}条
	 	String sqlEnhance_${sql_index+1} ="${sql}";
	 	<#-- update--begin--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	 	this.executeSqlEnhance(sqlEnhance_${sql_index+1},t);
	 	<#-- update--end--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	 	</#list>
	 	//-----------------sql增强 end------------------------------
	 	
	 	//-----------------java增强 start---------------------------
	 	<#if buttonJavaMap??&&buttonJavaMap['add']?? >
	 		Map<String,Object> data = populationMap(t);
	 		executeJavaExtend("${buttonJavaMap['add'].cgJavaType}","${buttonJavaMap['add'].cgJavaValue}",data);
	 	</#if>
	 	//-----------------java增强 end-----------------------------
 	}
 	/**
	 * 更新操作增强业务
	 * @param t
	 * @return
	 */
	private void doUpdateBus(${entityName}Entity t) throws Exception{
		//-----------------sql增强 start----------------------------
 		<#list buttonSqlMap['update']! as sql>
	 	//sql增强第${sql_index+1}条
	 	String sqlEnhance_${sql_index+1} ="${sql}";
	 	<#-- update--begin--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	 	this.executeSqlEnhance(sqlEnhance_${sql_index+1},t);
	 	<#-- update--end--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	 	</#list>
	 	//-----------------sql增强 end------------------------------
	 	
	 	//-----------------java增强 start---------------------------
	 	<#if buttonJavaMap??&&buttonJavaMap['update']?? >
	 		Map<String,Object> data = populationMap(t);
	 		executeJavaExtend("${buttonJavaMap['update'].cgJavaType}","${buttonJavaMap['update'].cgJavaValue}",data);
	 	</#if>
	 	//-----------------java增强 end-----------------------------
 	}
 	/**
	 * 删除操作增强业务
	 * @param id
	 * @return
	 */
	private void doDelBus(${entityName}Entity t) throws Exception{
	    //-----------------sql增强 start----------------------------
 		<#list buttonSqlMap['delete']! as sql>
	 	//sql增强第${sql_index+1}条
	 	String sqlEnhance_${sql_index+1} ="${sql}";
	 	<#-- update--begin--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	 	this.executeSqlEnhance(sqlEnhance_${sql_index+1},t);
	 	<#-- update--end--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
	 	</#list>
	 	//-----------------sql增强 end------------------------------
	 	
	 	//-----------------java增强 start---------------------------
	 	<#if buttonJavaMap??&&buttonJavaMap['delete']?? >
	 		Map<String,Object> data = populationMap(t);
	 		executeJavaExtend("${buttonJavaMap['delete'].cgJavaType}","${buttonJavaMap['delete'].cgJavaValue}",data);
	 	</#if>
	 	//-----------------java增强 end-----------------------------
 	}
 	<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,${entityName}Entity t){
 		<#list columns as po>
 		sql  = sql.replace("${'#'}{${fieldMeta[po.fieldName]?lower_case}}",String.valueOf(t.get${po.fieldName?cap_first}()));
 		</#list>
 		sql  = sql.replace("${'#'}{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
 	
 	<#-- update--begin--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
 	
 	private Map<String,Object> populationMap(${entityName}Entity t){
		Map<String,Object> map = new HashMap<String,Object>();
		<#list columns as po>
		map.put("${fieldMeta[po.fieldName]?lower_case}", t.get${po.fieldName?cap_first}());
 		</#list>
		return map;
	}
	
	<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
	/**
	 * 执行JAVA增强
	 */
 	private void executeJavaExtend(String cgJavaType,String cgJavaValue,Map<String,Object> data) throws Exception {
 		if(StringUtil.isNotEmpty(cgJavaValue)){
			Object obj = null;
			try {
				if("class".equals(cgJavaType)){
					//因新增时已经校验了实例化是否可以成功，所以这块就不需要再做一次判断
					obj = MyClassLoader.getClassByScn(cgJavaValue).newInstance();
				}else if("spring".equals(cgJavaType)){
					obj = ApplicationContextUtil.getContext().getBean(cgJavaValue);
				}
				if(obj instanceof CgformEnhanceJavaInter){
					CgformEnhanceJavaInter javaInter = (CgformEnhanceJavaInter) obj;
					javaInter.execute("${tableName}",data);
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("执行JAVA增强出现异常！");
			} 
		}
 	}
	<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
 	private void executeSqlEnhance(String sqlEnhance,${entityName}Entity t){
	 	Map<String,Object> data = populationMap(t);
	 	sqlEnhance = ResourceUtil.formateSQl(sqlEnhance, data);
	 	boolean isMiniDao = false;
	 	try {
	 		data = ResourceUtil.minidaoReplaceExtendSqlSysVar(data);
	 		sqlEnhance = FreemarkerParseFactory.parseTemplateContent(sqlEnhance, data);
			isMiniDao = true;
		} catch (Exception e) {
		}
	 	String [] sqls = sqlEnhance.split(";");
		for(String sql:sqls){
			if(sql == null || sql.toLowerCase().trim().equals("")){
				continue;
			}
			int num = 0;
			if(isMiniDao){
				<#-- update--begin--author:zhoujf date:20180416 for:TASK #2623 【bug】生成代码sql 不支持表达式(事物处理)-->
				num = namedParameterJdbcTemplate.update(sql, data);
				<#-- update--end--author:zhoujf date:20180416 for:TASK #2623 【bug】生成代码sql 不支持表达式(事物处理)-->
			}else{
				num = this.executeSql(sql);
			}
		}
 	}
 	<#-- update--end--author:zhoujf date:20180413 for:TASK #2623 【bug】生成代码sql 不支持表达式-->
 	</#if>
}