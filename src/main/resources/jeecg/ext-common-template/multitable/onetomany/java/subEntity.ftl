<#list subtables as key>
#segment#${subsG['${key}'].entityName}Entity.java
package ${bussiPackage}.${subsG['${key}'].entityPackage}.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.lang.String;
import java.lang.Double;
import java.lang.Integer;
import java.math.BigDecimal;
import javax.xml.soap.Text;
import java.sql.Blob;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: ${subsG['${key}'].ftlDescription}
 * @author onlineGenerator
 * @date ${ftl_create_time}
 * @version V1.0   
 *
 */
@Entity
@Table(name = "${subsG['${key}'].tableName}", schema = "")
<#if subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "SEQUENCE">
@SequenceGenerator(name="SEQ_GEN", sequenceName="${subsG['${key}'].cgFormHead.jformPkSequence}")  
</#if>
@SuppressWarnings("serial")
public class ${subsG['${key}'].entityName}Entity implements java.io.Serializable {
	<#list subColumnsMap['${key}'] as po>
	/**${po.content}*/
	<#if po.isShow != 'N'>
	<#--update-start--Author:dangzhenghui  Date:20170503 for：TASK #1864 【excel】Excel 功能专项任务-->
    @Excel(name="${po.content}",width=15<#if po.type == "java.util.Date">,format = "yyyy-MM-dd"</#if><#if po.dictTable?if_exists?html!="">,dictTable ="${po.dictTable}",dicCode ="${po.dictField}",dicText ="${po.dictText}"</#if><#if po.dictTable?if_exists?html=="" && po.dictField?if_exists?html!="">,dicCode="${po.dictField}"</#if>)
	<#--update-end--Author:dangzhenghui  Date:20170503 for：TASK #1864 【excel】Excel 功能专项任务-->
	</#if>
	<#if po.type == "javax.xml.soap.Text">
	private java.lang.String ${po.fieldName};
	</#if>
	<#if po.type != "javax.xml.soap.Text">
	<#--update-start--Author:luobaoli  Date:20150609 for：将数据库中blob类型对应为byte[]-->
	private <#if po.type=='java.sql.Blob'>byte[]<#else>${po.type}</#if> ${po.fieldName};
	<#--update-end--Author:luobaoli  Date:20150609 for：将数据库中blob类型对应为byte[]-->
	</#if>
	</#list>
	
	<#list subColumnsMap['${key}'] as po>
	/**
	 *方法: 取得${po.type}
	 *@return: ${po.type}  ${po.content}
	 */
	<#if po.fieldName == jeecg_table_id>
	<#if subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "UUID">
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	<#elseif subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "NATIVE">
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	<#elseif subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "SEQUENCE">
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="SEQ_GEN")  
	<#else>
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	</#if>
	</#if>
	
	<#if po.type == "javax.xml.soap.Text">
	@Column(name ="${subFieldMeta[po.fieldName]}",nullable=<#if po.isNull == 'Y'>true<#else>false</#if><#if po.pointLength != 0>,scale=${po.pointLength}</#if>,length=1000)
	public java.lang.String get${po.fieldName?cap_first}(){
		return this.${po.fieldName};
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  ${po.content}
	 */
	public void set${po.fieldName?cap_first}(java.lang.String ${po.fieldName}){
		this.${po.fieldName} = ${po.fieldName};
	}
	</#if>
	<#if po.type != "javax.xml.soap.Text">
	<#--update-start--Author:luobaoli  Date:20150609 for：将数据库中blob类型对应为byte[]，且去掉length属性-->
	@Column(name ="${subFieldMeta[po.fieldName]}",nullable=<#if po.isNull == 'Y'>true<#else>false</#if><#if po.pointLength != 0>,scale=${po.pointLength}</#if><#if po.type!='java.sql.Blob'><#if po.length !=0>,length=${po.length?c}</#if></#if>)
	public <#if po.type=='java.sql.Blob'>byte[]<#else>${po.type}</#if> get${po.fieldName?cap_first}(){
		return this.${po.fieldName};
	}

	/**
	 *方法: 设置${po.type}
	 *@param: ${po.type}  ${po.content}
	 */
	public void set${po.fieldName?cap_first}(<#if po.type=='java.sql.Blob'>byte[]<#else>${po.type}</#if> ${po.fieldName}){
		this.${po.fieldName} = ${po.fieldName};
	}
	<#--update-end--Author:luobaoli  Date:20150609 for：将数据库中blob类型对应为byte[]，且去掉length属性-->
	</#if>
	
	</#list>
}
</#list>