package org.jeecgframework.web.activiti.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.commons.lang3.StringUtils;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.jeecgframework.web.activiti.dao.LeaveDao;
import org.jeecgframework.web.activiti.entity.Audit;
import org.jeecgframework.web.activiti.entity.Leave;
import org.jeecgframework.web.activiti.service.AuditServiceI;
import org.jeecgframework.web.activiti.service.LeaveServiceI;
import org.jeecgframework.web.activiti.util.Variable;
import org.jeecgframework.web.black.service.TsBlackListServiceI;
import org.jeecgframework.web.system.pojo.base.TSRoleUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.jeecg.zwzx.entity.WorkApplyEntity;
import com.jeecg.zwzx.service.WorkApplyService;

@Service("auditService")
@Transactional
public class AuditServiceImpl extends CommonServiceImpl implements AuditServiceI {
	
	@Autowired
	private WorkApplyService workApplyService;
	
	@Autowired
	private LeaveDao leaveDao;
	
	@Autowired
    private IdentityService identityService;
	
	@Autowired
	private RuntimeService runtimeService;
	
	@Autowired
    protected TaskService taskService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	/**
	 * 启动请假流程
	 * @param leave
	 */
	public String auditWorkFlowStart(WorkApplyEntity entity){
//		List<Audit> auditList = this.commonDao.findByProperty(Audit.class, "applyId", entity.getApplyId());
		WorkApplyEntity workApply = workApplyService.get(entity.getId());
		if(workApply.getApplyStatus()!=null&&workApply.getApplyStatus()>0){
			return "already";
		}else{
//			Serializable t = super.save(entity);
			workApply.setApplyStatus(1);
	        String management = workApply.getManagement();
	        String username = workApplyService.getUserName(management);
	        String businessKey = workApply.getId().toString();
	        ProcessInstance processInstance = null;
	        try {
	            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
	            identityService.setAuthenticatedUserId(workApply.getDealPersion());
	
	            Map<String, Object> variables = new HashMap<String, Object>();
	    		variables.put("username", username);
	            processInstance = runtimeService.startProcessInstanceByKey("zwzx", businessKey, variables);
	            String processInstanceId = processInstance.getId();
	            workApply.setProcessInstanceId(processInstanceId);
	            workApplyService.update(workApply);
	            logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", new Object[]{"leave", businessKey, processInstanceId, variables});
	        } finally {
	            identityService.setAuthenticatedUserId(null);
	        }
			return "success";
		}
		
	}
	
	@Transactional(readOnly = true)
	public Audit getAudit(Long id){
		return super.getEntity(Audit.class, id);
	}
	
	public void reApplyAudit(String taskId,Audit audit,Variable var){

		String reason = audit.getReason();
//		Leave tmpLeave = leaveDao.getLeave(new Long(leave.getId()));
		Audit tmpAudit=super.getEntity(Audit.class, audit.getId());
		tmpAudit.setReason(reason);
//		leaveDao.save(tmpLeave);
		Serializable t = super.save(tmpAudit);
		Map<String, Object> variables = var.getVariableMap();
        taskService.complete(taskId, variables);
	}

	@Override
	public String workList(String userId) {
//		TaskService taskService = processEngine.getTaskService();
		TaskQuery query = taskService.createTaskQuery();
        List<Task> tasks = query.taskAssignee(userId).list();
		
		StringBuffer rows = new StringBuffer();
		List tempList=new ArrayList();
		
		for(Task t : tasks){
			WorkApplyEntity tmpWorkApply = new WorkApplyEntity();
			tmpWorkApply.setProcessInstanceId(t.getProcessInstanceId());
			MiniDaoPage<WorkApplyEntity> workApplyList = workApplyService.getAll(tmpWorkApply, 1, 10);
			WorkApplyEntity workApply = workApplyList.getResults().get(0);
			Map tempMap=new HashMap();
			tempMap.put("name", t.getName());
			tempMap.put("taskId", t.getId());
			tempMap.put("applyId", workApply.getId());
			tempMap.put("guideId", workApply.getGuideId());
			tempMap.put("management", workApply.getManagement());
			tempMap.put("applyStatus", workApply.getApplyStatus());			
			tempMap.put("processInstanceId", t.getProcessInstanceId());
			tempList.add(tempMap);
//			rows.append("{'name':'"+t.getName() +"','description':'"+t.getDescription()+"','id':'"+t.getId()+"','processDefinitionId':'"+t.getProcessDefinitionId()+"','processInstanceId':'"+t.getProcessInstanceId()+"'},");
		}
//		String rowStr = StringUtils.substringBeforeLast(rows.toString(), ",");
		return JSONArray.toJSONString(tempList);
	}

	@Override
	public String reApply(String taskId, String applyId, String status) {
		WorkApplyEntity workApply = workApplyService.get(applyId);
		workApply.setApplyStatus(7);
		boolean reApply=false;
		if(status.equals("reApply")){
			reApply=true;
			workApply.setApplyStatus(1);
		}
		workApplyService.update(workApply);
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("reApply", reApply);
		taskService.complete(taskId, variables);
		return "success";
	}
	
}
