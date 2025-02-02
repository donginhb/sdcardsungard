package org.king.check.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.lang.StringUtils;
import org.king.check.Constants;
import org.king.check.config.ClerkConfig;
import org.king.check.dao.DutyTimeDAO;
import org.king.check.dao.WorkInfoDao;
import org.king.check.domain.TCheckattReport;
import org.king.check.domain.TCheckattReportId;
import org.king.check.domain.Tattserialrecord;
import org.king.check.domain.Tcheckattinfo;
import org.king.check.domain.TcheckattinfoId;
import org.king.check.service.SysService;
import org.king.check.service.WorkInfoService;
import org.king.check.util.DateUtilExtend;
import org.king.check.util.GetPropertiesUtil;
import org.king.framework.exception.BusinessException;
import org.king.framework.service.impl.BaseService;
import org.springframework.jdbc.core.JdbcTemplate;

public class WorkInfoServiceImpl extends BaseService implements WorkInfoService {
	//private static final Log log = LogFactory.getLog(WorkInfoServiceImpl.class);

	private WorkInfoDao workInfodao;

	private DutyTimeDAO dutytimedao;

	private JdbcTemplate jdbcTemplate;
	
	private SysService sysService;

	public void setWorkInfodao(WorkInfoDao workInfodao) {
		this.workInfodao = workInfodao;
	}
	
	public void setDutytimedao(DutyTimeDAO dutytimedao) {
		this.dutytimedao = dutytimedao;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public void saveWorkInfo(Tattserialrecord workInfo)
			throws BusinessException {
		this.workInfodao.save(workInfo);
	}

	public void updateWorkInfo(Tattserialrecord workInfo)
			throws BusinessException {
		this.workInfodao.update(workInfo);
	}
	public void setSysService(SysService sysService) {
		this.sysService = sysService;
	}

	
	/**
	 * 取得已经手工考勤过的列表
	 */
	public List getManualCheckList(int custId, String attDate) throws Exception {
		StringBuffer querySql = new StringBuffer(1024);
		querySql.append(" select rec.CUST_ID, rec.ATT_DATE,info.IFOFFICE")
				.append(" from YKT_CK.T_ATTSERIAL_RECORD rec")
				.append(" left join YKT_CK.T_CLERKINFO info on rec.CUST_ID=info.CUST_ID")
				.append(" where rec.ATT_DATE=?")
				.append(" and rec.CUST_ID=?");
		List manualCehck = jdbcTemplate.queryForList(querySql.toString(),new Object[]{attDate,new Integer(custId)});
		return manualCehck;
	}

	/**
	 * 根据人员编号和考勤日期取得该人员的所有考勤流水记录
	 * @param custId
	 * @param signDate
	 * @return
	 */
	private List getCustWorkSerial(String custId,String signDate){
		StringBuffer querySql = new StringBuffer(1024);
		querySql.append("select ATT_DATE , ATT_TIME from (")
				.append(" select ATT_DATE , ATT_TIME  from YKT_CK.T_ATTSERIAL_RECORD")
				.append(" where cust_id=? and ATT_DATE=?")
				.append(" union all")
				.append(" select ATT_DATE, ATT_TIME from YKT_CK.T_ATTSERIAL")
				.append(" where cust_id=? and ATT_DATE=?)t")
				.append(" order by ATT_DATE,ATT_TIME");
		List CustWorkSerialMap = jdbcTemplate.queryForList(querySql.toString(),new Object[]{Integer.valueOf(custId),signDate,Integer.valueOf(custId),signDate});
		return CustWorkSerialMap;
	}
	
	/**
	 * 非坐班人员考勤信息 
	 * hanjiwei modify it 20061019
	 */
	private void dealWithNoSeatClerk(Map filter) throws Exception {
		String signDate = (String) filter.get("signDate");
		String custId = String.valueOf(filter.get("custId"));

		List cardList = getCustWorkSerial(custId,signDate);
		//String deptId = getDeptIdByCustId(custId);
		String minTime = "235959";
		String maxTime = "000000";
		if (!cardList.isEmpty()) {
			Iterator checkTime = cardList.iterator();
			String currentTime = "000000";
			while (checkTime.hasNext()) {
				Map queryMap = (Map) checkTime.next();
				currentTime = (String) queryMap.get("ATT_TIME");
				if (DateUtilExtend.timeDiff1(currentTime, minTime) > 0) {
					minTime = currentTime;
				}
				if (DateUtilExtend.timeDiff1(currentTime, maxTime) < 0) {
					maxTime = currentTime;
				}
			}
		}else{
			minTime = "000000";
			maxTime = "000000";
		}
		TcheckattinfoId attInfoId = new TcheckattinfoId();
		Tcheckattinfo attInfo = new Tcheckattinfo();
		attInfoId.setCustId(new Integer(Integer.parseInt(custId)));
		attInfoId.setCheckDate(signDate);
		attInfo.setId(attInfoId);
		//attInfo.setchecktypeId(deptId);
		attInfo.setFactOntime(minTime);
		attInfo.setFactOfftime(maxTime);
		attInfo.setIfoffice("2");
		if (exitRecordByCustId(custId,signDate)){
			dutytimedao.update(attInfo);
		}else{
			dutytimedao.save(attInfo);
		}
	}
	
	/**
	 * 为手工打卡搜索考勤人员 
	 * hanjiwei modify it 20060918
	 */
	public List searchClerkForReg(Map filter) throws Exception {
		StringBuffer sql = new StringBuffer(1024);
		sql.append("select cust.CUSTID AS CUT_ID, cust.CUSTNAME AS CUT_NAME,  cust.STUEMPNO AS STUEMP_NO, cust.DEPTCODE AS CLASSDEPT_NO,")
			.append(" dept.DEPT_NAME,clerk.IFOFFICE,dict.DICTCAPTION AS DICT_CAPTION from YKT_CK.T_CLERKINFO clerk ")
			.append(" left join YKT_CUR.T_CUSTOMER cust on clerk.CUST_ID=cust.CUSTID")
			.append(" left join YKT_CK.DEPARTMENT dept on dept.DEPT_ID=clerk.DEPT_ID")
			.append(" left join YKT_CUR.T_DICTIONARY dict on dict.DICTVAL=clerk.IFOFFICE")
			.append(" where dict.DICTTYPE=1200");
		if (StringUtils.isNotEmpty((String) filter.get("trueName"))) {
			sql.append(" and cust.CUSTNAME like '%"
					+ (String) filter.get("trueName") + "%'");
		}
		if (StringUtils.isNotEmpty((String) filter.get("stuNumber"))) {
			sql.append(" and cust.STUEMPNO='"
					+ (String) filter.get("stuNumber") + "'");
		}
		if ((!"".equals((String) filter.get("deptId")))&&(filter.get("deptId")!=null)) {
			sql.append(" and clerk.dept_id='"
					+ (String) filter.get("deptId") + "'");
		}else if (filter.get("deptId")!=null){
			sql.append(" and clerk.dept_id in("
					+ getDeptStrByAccountId((String) filter.get("accountId")) + ")");
		}
		
		if (StringUtils.isNotEmpty((String) filter.get("clerkType"))) {
			sql.append(" and clerk.IFOFFICE='"
					+ (String) filter.get("clerkType") + "'");
		}
		List clerkList = jdbcTemplate.queryForList(sql.toString());

		return clerkList;
	}
	
	/**
	 * 手工打卡修改记录查找
	 * hanjiwei modify it 20060918
	 */
	public List searchClerkForModify(Map filter) throws Exception {
		StringBuffer sql = new StringBuffer(1024);
		sql
				.append("select cust.CUSTNAME AS CUT_NAME,cust.STUEMPNO AS STUEMP_NO, cust.DEPTCODE AS CLASSDEPT_NO, manual.CUST_ID,")
				.append(" manual.ATT_DATE,manual.ATT_TIME,dept.DEPT_NAME,manual.serial_id")
				.append(" from YKT_CK.T_ATTSERIAL_RECORD manual")
				.append(" left join YKT_CK.T_CLERKINFO clerk on clerk.CUST_ID=manual.CUST_ID")
				.append(" left join YKT_CUR.T_CUSTOMER cust on manual.CUST_ID=cust.CUSTID")
				.append(" left join YKT_CK.DEPARTMENT dept on dept.DEPT_ID=clerk.DEPT_ID")
				.append(" where manual.ATT_DATE>='").append(filter.get("beginDate").toString())
				.append("' and manual.ATT_DATE<='").append(filter.get("endDate").toString())
				.append("'");
		if (StringUtils.isNotEmpty((String) filter.get("trueName"))) {
			sql.append(" and cust.CUSTNAME like '%"
					+ (String) filter.get("trueName") + "%'");
		}
		if (StringUtils.isNotEmpty((String) filter.get("stuNumber"))) {
			sql.append(" and cust.STUEMPNO='"
					+ (String) filter.get("stuNumber") + "'");
		}
		if (!"".equals((String) filter.get("deptId"))) {
			sql.append(" and clerk.dept_id='"
					+ (String) filter.get("deptId") + "'");
		}else{
			sql.append(" and clerk.dept_id in("
					+ getDeptStrByAccountId((String) filter.get("accountId")) + ")");
		}
		//log.debug("sql:" + sql);
		sql.append(" order by manual.ATT_DATE desc");
		List clerkList = jdbcTemplate.queryForList(sql.toString());
		List clerkManual = new ArrayList();
		if (clerkList.size()>0){
			Iterator iter = clerkList.iterator();
			while (iter.hasNext()){
				Map clerkMap = (Map)iter.next();
				Map resultMap = new HashMap();
				resultMap.put("CUT_NAME",clerkMap.get("CUT_NAME"));
				resultMap.put("STUEMP_NO",clerkMap.get("STUEMP_NO"));
				resultMap.put("CLASSDEPT_NO",clerkMap.get("CLASSDEPT_NO"));
				resultMap.put("CUST_ID",clerkMap.get("CUST_ID"));
				resultMap.put("ATT_DATE",DateUtilExtend.formatDateSelf(clerkMap.get("ATT_DATE").toString()));
				resultMap.put("ATT_TIME",DateUtilExtend.formatTimeSelf(clerkMap.get("ATT_TIME").toString()));
				resultMap.put("DEPT_NAME",clerkMap.get("DEPT_NAME"));
				resultMap.put("serial_id",clerkMap.get("serial_id"));
				clerkManual.add(resultMap);
			}
		}
		return clerkManual;
	}
	
	public Map searchClerkForModify(int seriId) throws Exception {
		StringBuffer sql = new StringBuffer(1024);
		sql
				.append("select cust.CUSTNAME AS CUT_NAME,cust.STUEMPNO AS STUEMP_NO, cust.DEPTCODE AS CLASSDEPT_NO, manual.CUST_ID,")
				.append(" manual.ATT_DATE,manual.ATT_TIME,dept.DEPT_NAME,manual.serial_id,")
				.append(" manual.OPER_DATE,manual.OPER_TIME,per.person_name")
				.append(" from YKT_CK.T_ATTSERIAL_RECORD manual")
				.append(" left join YKT_CK.T_CLERKINFO clerk on clerk.CUST_ID=manual.CUST_ID")
				.append(" left join YKT_CUR.T_CUSTOMER cust on manual.CUST_ID=cust.CUSTID")
				.append(" left join YKT_CK.DEPARTMENT dept on dept.DEPT_ID=clerk.DEPT_ID")
				.append(" left join ykt_ck.usr_person per on manual.oper_id=per.id ")
				.append(" where manual.serial_id=?");
		//log.debug("sql:" + sql);
		Map clerkMap = jdbcTemplate.queryForMap(sql.toString(),new Object[]{new Integer(seriId)});
		Map resultMap = new HashMap();
		String operDate = DateUtilExtend.formatDateSelf(clerkMap.get("OPER_DATE").toString())+"--"+DateUtilExtend.formatTimeSelf(clerkMap.get("OPER_TIME").toString());
		resultMap.put("CUT_NAME",clerkMap.get("CUT_NAME"));
		resultMap.put("STUEMP_NO",clerkMap.get("STUEMP_NO"));
		resultMap.put("CLASSDEPT_NO",clerkMap.get("CLASSDEPT_NO"));
		resultMap.put("CUST_ID",clerkMap.get("CUST_ID"));
		resultMap.put("ATT_DATE",DateUtilExtend.formatDate3(clerkMap.get("ATT_DATE").toString()));
		resultMap.put("ATT_HOUR",DateUtilExtend.getHour(clerkMap.get("ATT_TIME").toString()));
		resultMap.put("ATT_MIN",DateUtilExtend.getMin(clerkMap.get("ATT_TIME").toString()));
		resultMap.put("DEPT_NAME",clerkMap.get("DEPT_NAME"));
		resultMap.put("serial_id",clerkMap.get("serial_id"));
		resultMap.put("oper_name",clerkMap.get("person_name"));
		resultMap.put("oper_date",operDate);
		return resultMap;
	}

	/**
	 * 根据登陆操作员编号取得其所拥有权限的部门
	 * @param accountId
	 * @return
	 */
	private String getDeptStrByAccountId(String accountId){
		List departList = null;
		StringBuffer deptStr = new StringBuffer(1024);
		try{
			departList = sysService.getDeptList(accountId);
			if (departList.size()>0){
				for (int i=0;i<departList.size();i++){
					Map deptMap = (Map)departList.get(i);
					if (i==departList.size()-1){
						deptStr.append("'"+deptMap.get("deptId")+"'");
					}else{
						deptStr.append("'"+deptMap.get("deptId")+"',");
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return deptStr.toString();
	}

	/**
	 * 手工打卡 
	 * hanjiwei modify it 20060918
	 */
	public void manualRegister(List filter) throws Exception {
		if (filter != null && !filter.isEmpty()) {
			for (int i = 0; i < filter.size(); i++) {
				Tattserialrecord clerk = (Tattserialrecord) filter.get(i);
				workInfodao.save(clerk);
			}
		}
	}

	public Tattserialrecord get(Serializable id) {
		return workInfodao.get(id);
	}

	/**
	 * 手工打卡删除
	 * hanjiwei add it 20061227
	 */
	public void deleteRegister(Tattserialrecord att) throws Exception {
		workInfodao.delete(att);
	}

	/**
	 * 修改手工打卡信息
	 * hanjiwei add it 20061227
	 */
	public void updateRegister(Tattserialrecord att) throws Exception {
		workInfodao.update(att);
	}

	// 根据客户号查出卡号
	public Integer getCardIdByCustId(String custId) throws Exception {
		String sql = "select CARDNO from YKT_CUR.T_CARD where  STATUS=1 and CUSTID=?";
		List tempList = jdbcTemplate.queryForList(sql,new Object[]{custId});
		Integer cardId = new Integer(0);
		if (tempList.size()>0) {
			Map tmpMap = (Map) tempList.get(0);
			cardId = new Integer(tmpMap.get("CARDNO").toString());
		}
		return cardId;
	}

	// 根据客户号查出物理卡号
	public String getPhyCardIdByCustId(String custId) throws Exception {
		String sql = "select CARDPHYID from YKT_CUR.T_CARD where  STATUS=1 and CUSTID=?";
		List tempList = jdbcTemplate.queryForList(sql,new Object[]{custId});
		String phyCardId = null;
		if (tempList.size()>0) {
			Map tmpMap = (Map) tempList.get(0);
			phyCardId = (String) tmpMap.get("CARDPHYID");
		}
		return phyCardId;
	}

	// 判断考勤人员的卡号是否有效
	public String[] judgeIsOwnValidCardByClerkId(String[] clerkIds)
			throws Exception {
		String sql = "";
		sql = "select CARDNO AS CARD_ID from YKT_CUR.T_CARD where  STATUS=1";
		String card_number[] = new String[clerkIds.length];

		for (int i = 0; i < clerkIds.length; i++) {
			String tempStr = "  and CUSTID=" + clerkIds[i];
			//log.debug("sql:" + sql + tempStr);
			List tempList = jdbcTemplate.queryForList(sql + tempStr);
			if (tempList.isEmpty()) {
				return null;
			} else {
				Map map = (Map) tempList.get(0);
				Integer temp = (Integer) map.get("card_id");
				card_number[i] = temp.toString();
			}
		}
		return card_number;
	}	
	
	/**
	 * 判断是否存在考勤记录，存在返回true
	 * hanjiwei add it 20061020
	 * @param custId
	 * @param workDate
	 * @return
	 */
	private boolean exitRecordByCustId(String custId,String workDate){
		StringBuffer querySql = new StringBuffer(1024);
		querySql.append("select * from YKT_CK.T_CHECKATT_INFO")
		.append(" where CHECK_DATE=? and CUST_ID=?");
		List workConfInfoList = jdbcTemplate.queryForList(querySql.toString(),new Object[]{workDate,custId}); 
		if (workConfInfoList.isEmpty()){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 判断是否存在考勤报表，存在返回true
	 * hanjiwei modify it 20061020
	 * @param custId
	 * @param workDate
	 * @return
	 */
	private boolean exitReportByCustId(String custId,String workDate){
		StringBuffer querySql = new StringBuffer(1024);
		querySql.append("select * from YKT_CK.T_CHECKATT_REPORT")
		.append(" where CHECK_DATE=? and CUST_ID=?");
		List workConfInfoList = jdbcTemplate.queryForList(querySql.toString(),new Object[]{workDate,custId}); 
		if (workConfInfoList.isEmpty()){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 根据客户号和日期取得该人员的考勤制度信息
	 * hanjiwei modify it 20061019
	 * @param custId
	 * @return
	 */
	private List getWorkConfInfoByCustId(String custId,String workDate){
		StringBuffer querySql = new StringBuffer(1024);
		querySql.append("select clerk.CUST_ID,clerk.CHECKTYPE_ID,clerk.IFOFFICE,clerk.AHEAD_OVERTIME,")
		.append("clerk.DELAY_OVERTIME,clerk.OVERTIME_VALUE,clerk.TWOREST_OVERTIME,clerk.HOLIDAY_OVERTIME,")
		.append("workConf.WORKCONF_ID,workConf.WORKCONF_NAME,workConf.OVERDUE_TIME,workConf.LEAVEEARLY_TIME,")
		.append("workConf.OVER_TIME, workConf.DELAY_TIME, workConf.CHECK_TIME, workTime.WORKTIME_ID,")
		.append("workTime.WORKTIME_NAME, workTime.ONTIME1, workTime.OFFTIME1, workTime.ONTIME2,")
		.append("workTime.OFFTIME2, workTime.ONTIME3, workTime.OFFTIME3,workTime.ONTIME4, workTime.OFFTIME4")
		.append(" from YKT_CK.T_CLERKINFO clerk ")
		.append(" left join YKT_CK.T_CHECK_WORKCONFINFO checkWork on checkWork.CHECK_TYPEID=clerk.CHECKTYPE_ID")
		.append(" left join YKT_CK.T_WORKCONFINFO workConf on workConf.WORKCONF_ID = checkWork.WORKINFO_ID")
		.append(" left join YKT_CK.T_WORKTIMEINTO workTime on workTime.WORKTIME_ID = checkWork.WORKTIME_ID")
		.append(" where checkWork.BEGINDATE=? and clerk.CUST_ID=?");
		List workConfInfoList = jdbcTemplate.queryForList(querySql.toString(),new Object[]{workDate,custId}); 
		return workConfInfoList;
	}
	
	/**
	 * 判断时间大小，结束时间大于开始时间返回true
	 * hanjiwei add it 20061020
	 * @param currTime
	 * @param onTime
	 * @return
	 */
	private boolean diffTime(String beginTime,String endTime){
		if (DateUtilExtend.timeDiff1(beginTime, endTime) >= 0){
			return true;
		}else{
			return false;
		}

	}
	/**
	 * 时间比较，结束时间和开始时间的差值小于给定的值返回true
	 * hanjiwei add it 20061020
	 * @param currTime
	 * @param onTime
	 * @return
	 */
	private boolean diffTime(String beginTime,String endTime,int overTime){
		if ((DateUtilExtend.timeDiff1(beginTime, endTime) <= overTime)&&
				(DateUtilExtend.timeDiff1(beginTime, endTime)>=0)){
			return true;
		}else{
			return false;
		}
	}

	private String formatWorkTime2(Object inTime){
		if (null==inTime){
			return "";
		}else if (inTime.toString().length()==4){
			return inTime.toString()+"00";
		}else{
			return "";
		}
	}
	
	/**
	 * 生成个人考勤信息 
	 * hanjiwei modify it 20061019
	 */
	private void createPersonWorkInfo(Map filter) throws Exception {
		String signDate = (String) filter.get("signDate");
		String custId = String.valueOf(filter.get("custId"));

		List cardList = getCustWorkSerial(custId,signDate);
		//String deptId = getDeptIdByCustId(custId);
		//根据人员编号取得考勤制度信息
		if (!getWorkConfInfoByCustId(custId,signDate).isEmpty()){
			Map workTime = (Map)getWorkConfInfoByCustId(custId,signDate).get(0);
			//取得考勤工作时间
			String onTime1 = formatWorkTime2(workTime.get("ONTIME1"));
			String offTime1 = formatWorkTime2(workTime.get("OFFTIME1"));
			String onTime2 = formatWorkTime2(workTime.get("ONTIME2"));
			String offTime2 = formatWorkTime2(workTime.get("OFFTIME2"));
			String onTime3 = formatWorkTime2(workTime.get("ONTIME3"));
			String offTime3 = formatWorkTime2(workTime.get("OFFTIME3"));
			String onTime4 = formatWorkTime2(workTime.get("ONTIME4"));
			String offTime4 = formatWorkTime2(workTime.get("OFFTIME4"));
			
			//允许上班提前打卡时间和下班延后打卡时间,校正时间(上班打卡后，下班不打卡，认为多长时间就下班)
			int overTime = Integer.parseInt(oToString(workTime.get("OVER_TIME")));
			int delayTime = Integer.parseInt(oToString(workTime.get("DELAY_TIME")));
			int adjustTime = Integer.parseInt(oToString(workTime.get("CHECK_TIME")));

			Map factWorkTime = getFactWorkTime(cardList,onTime1,offTime1,onTime2,
					offTime2,onTime3,offTime3,onTime4,offTime4,overTime,delayTime,adjustTime);
			TcheckattinfoId attInfoId = new TcheckattinfoId();
			Tcheckattinfo attInfo = new Tcheckattinfo();
			attInfoId.setCustId(new Integer(Integer.parseInt(custId)));
			attInfoId.setCheckDate(signDate);
			attInfo.setId(attInfoId);
			//attInfo.setDeptId(deptId);
			//attInfo.setchecktypeId(deptId);
			attInfo.setFactOntime1(oToString(factWorkTime.get("onTime1")));
			attInfo.setFactOfftime1(oToString(factWorkTime.get("offTime1")));
			attInfo.setFactOntime2(oToString(factWorkTime.get("onTime2")));
			attInfo.setFactOfftime2(oToString(factWorkTime.get("offTime2")));
			attInfo.setFactOntime3(oToString(factWorkTime.get("onTime3")));
			attInfo.setFactOfftime3(oToString(factWorkTime.get("offTime3")));
			attInfo.setFactOntime4(oToString(factWorkTime.get("onTime4")));
			attInfo.setFactOfftime4(oToString(factWorkTime.get("offTime4")));
			attInfo.setIfoffice("1");
			//先查询是否存在记录，存在则更新，否则保存
			if (exitRecordByCustId(custId,signDate)){
				dutytimedao.update(attInfo);
			}else{
				dutytimedao.save(attInfo);
			}
		}
	}
	
	/**
	 * hanjiwei modify it 200610
	 * 统计出实际工作时间
	 * @param cardList
	 * @param onTime1
	 * @param offTime1
	 * @param onTime2
	 * @param offTime2
	 * @param onTime3
	 * @param offTime3
	 * @param onTime4
	 * @param offTime4
	 * @param overTime
	 * @param delayTime
	 * @return
	 */
	private Map getFactWorkTime(List cardList,
			String onTime1,
			String offTime1,
			String onTime2,
			String offTime2,
			String onTime3,
			String offTime3,
			String onTime4,
			String offTime4,
			int overTime,
			int delayTime,
			int adjustTime){
		//定义实际上班时间并初始化
		String workOnTime1 = "235959";
		String workOffTime1 = "000000";
		String workOnTime2 = "235959";
		String workOffTime2 = "000000";
		String workOnTime3 = "235959";
		String workOffTime3 = "000000";
		String workOnTime4 = "235959";
		String workOffTime4 = "000000";
		String currentTime = "";
		if (cardList.size()!=0){
			Iterator checkTime = cardList.iterator();
			while (checkTime.hasNext()){
				Map queryMap = (Map) checkTime.next();
				currentTime = (String) queryMap.get("ATT_TIME").toString();
		
				if (!"".equals(onTime1)){
					//ontime1<currenttime	
					if (diffTime(currentTime,onTime1)){
						if (diffTime(currentTime,onTime1,overTime)){
							if (diffTime(currentTime,workOnTime1)){
								workOnTime1 = currentTime;
							}
						}
					}
					//onTime1<currentTime<offTime1
					if (diffTime(onTime1,currentTime)&&diffTime(currentTime,offTime1)){
						if (!"235959".equals(workOnTime1)){
							if (diffTime(workOffTime1,currentTime)){
								workOffTime1 = currentTime;
							}
						}
						if (diffTime(currentTime,workOnTime1)){
							workOnTime1 = currentTime;
						}
					}
					//currentTime-workoffTime<30有效考勤，正常下班
					if (diffTime(offTime1,currentTime,delayTime)){
						if (diffTime(workOffTime1,currentTime)){
							workOffTime1 = currentTime;
						}
					}
				}else{
					workOnTime1 = "";
					workOffTime1 = "";
				}
				if (!"".equals(onTime2)){
					//offtime1<currenttime<offtime2
					if (diffTime(offTime1,currentTime)&&diffTime(currentTime,onTime2)){
						//workontime2-currentTime<30有效考勤，上班考勤2早到
						if (diffTime(currentTime,onTime2,overTime)){
							if (diffTime(currentTime,workOnTime2)){
								workOnTime2 = currentTime;
							}
						}
					}
					//ontime2<currenttime<offtime2
					if (diffTime(onTime2,currentTime)&&diffTime(currentTime,offTime2)){
						
						if (!"235959".equals(workOnTime2)){
							//早退
							if (diffTime(workOffTime2,currentTime)){
								workOffTime2 = currentTime;
							}
						}
						//迟到
						if (diffTime(currentTime,workOnTime2)){
							workOnTime2 = currentTime;
						}
					}
					if (diffTime(offTime2,currentTime,delayTime)){//---------
						if (diffTime(workOffTime2,currentTime)){
							workOffTime2 = currentTime;
						}
					}
				}else{
					workOnTime2 = "";
					workOffTime2 = "";
				}
				if (!"".equals(onTime3)){
					if (diffTime(offTime2,currentTime)&&diffTime(currentTime,onTime3)){
						if (diffTime(onTime3,currentTime,overTime)){
							if (diffTime(currentTime,workOnTime3)){
								workOnTime3 = currentTime;
							}
						}
					}
					if (diffTime(onTime3,currentTime)&&diffTime(currentTime,offTime3)){
						if (!"235959".equals(workOnTime3)){
							if (diffTime(currentTime,workOffTime3)){
								workOffTime3 = currentTime;
							}
						}
						if (diffTime(currentTime,workOnTime3)){
							workOnTime3 = currentTime;
						}
					}
					if (diffTime(offTime3,currentTime,delayTime)){
						if (diffTime(workOffTime3,currentTime)){
							workOffTime3 = currentTime;
						}
					}
				}else{
					workOnTime3 = "";
					workOffTime3 = "";
				}
				if (!"".equals(onTime4)){
					if (diffTime(offTime3,currentTime)&&diffTime(currentTime,onTime4)){
						if (diffTime(onTime4,currentTime,overTime)){
							if (diffTime(currentTime,workOnTime4)){
								workOnTime4 = currentTime;
							}
						}
					}
					if (diffTime(onTime4,currentTime)&&diffTime(currentTime,offTime4)){
						if (!"235959".equals(workOnTime4)){
							if (diffTime(currentTime,workOffTime4)){
								workOffTime4 = currentTime;
							}
						}
						if (diffTime(currentTime,workOnTime4)){
							workOnTime4 = currentTime;
						}
					}
					if (diffTime(offTime4,currentTime)){
						if (diffTime(offTime4,currentTime,delayTime)){
							if (diffTime(workOffTime4,currentTime)){
								workOffTime4 = currentTime;
							}
						}
					}
				}else{
					workOnTime4 = "";
					workOffTime4 = "";
				}
			}
		}else{
			if ("".equals(onTime4)){
				workOnTime4 = "";
				workOffTime4 = "";
			}
			if ("".equals(onTime3)){
				workOnTime3 = "";
				workOffTime3 = "";
			}
			if ("".equals(onTime2)){
				workOnTime2 = "";
				workOffTime2 = "";
			}
			if ("".equals(onTime1)){
				workOnTime1 = "";
				workOffTime1 = "";
			}
		}
		
		return formatCalcWorkTime(workOnTime1,workOffTime1,workOnTime2,workOffTime2,workOnTime3,workOffTime3,workOnTime4,workOffTime4,adjustTime);
	}
	
	/**
	 * 格式生成的实际考勤时间
	 * @param workOnTime1
	 * @param workOffTime1
	 * @param workOnTime2
	 * @param workOffTime2
	 * @param workOnTime3
	 * @param workOffTime3
	 * @param workOnTime4
	 * @param workOffTime4
	 * @param adjustTime
	 * @return
	 */
	private Map formatCalcWorkTime(String workOnTime1,
			String workOffTime1,
			String workOnTime2,
			String workOffTime2,
			String workOnTime3,
			String workOffTime3,
			String workOnTime4,
			String workOffTime4,
			int adjustTime){
		
		if ((!"235959".equals(workOnTime1)&&("000000".equals(workOffTime1)))){
			workOffTime1 = DateUtilExtend.addTime(workOnTime1,adjustTime);
		}
		if (("235959".equals(workOnTime1))&&(!"000000".equals(workOffTime1))){
			workOnTime1 = DateUtilExtend.addTime(workOffTime1,-adjustTime);
		}
		if ((!"235959".equals(workOnTime2)&&("000000".equals(workOffTime2)))){
			workOffTime2 = DateUtilExtend.addTime(workOnTime2,adjustTime);
		}
		if (("235959".equals(workOnTime2))&&(!"000000".equals(workOffTime2))){
			workOnTime2 = DateUtilExtend.addTime(workOffTime2,-adjustTime);
		}
		if ((!"235959".equals(workOnTime3)&&("000000".equals(workOffTime3)))){
			workOffTime3 = DateUtilExtend.addTime(workOnTime3,adjustTime);
		}
		if (("235959".equals(workOnTime3))&&(!"000000".equals(workOffTime3))){
			workOnTime3 = DateUtilExtend.addTime(workOffTime3,-adjustTime);
		}
		if ((!"235959".equals(workOnTime4)&&("000000".equals(workOffTime4)))){
			workOffTime4 = DateUtilExtend.addTime(workOnTime4,adjustTime);
		}
		if (("235959".equals(workOnTime4))&&(!"000000".equals(workOffTime4))){
			workOnTime4 = DateUtilExtend.addTime(workOffTime4,-adjustTime);
		}
		Map returnMap = new HashMap();
		returnMap.put("onTime1",formatWorkTime(workOnTime1));
		returnMap.put("offTime1",formatWorkTime(workOffTime1));
		returnMap.put("onTime2",formatWorkTime(workOnTime2));
		returnMap.put("offTime2",formatWorkTime(workOffTime2));
		returnMap.put("onTime3",formatWorkTime(workOnTime3));
		returnMap.put("offTime3",formatWorkTime(workOffTime3));
		returnMap.put("onTime4",formatWorkTime(workOnTime4));
		returnMap.put("offTime4",formatWorkTime(workOffTime4));
		return returnMap;
	}
	
	/**
	 * 显示工作时间，如果工作时间“235959”，返回“000000”
	 * @param workTime
	 * @return
	 */
	private String formatWorkTime(String workTime){
		if ("235959".equals(workTime)){
			return "000000";
		}else{
			return workTime;
		}
	}

	
	/**
	 * 生成所有考勤人员信息，并把考勤信息写入到考勤数据表中 32017669
	 * hanjiwei modify it 20061019
	 */
	public void createAllWorkInfoByDptConf(Map filter) throws Exception {
		String startDate = (String) filter.get("startDate");
		String endDate = (String) filter.get("endDate");
		String deptId = (String) filter.get("deptId");
		String stuEmpNo = (String) filter.get("stuEmpNo");
		StringBuffer querySql = new StringBuffer(1024);
		querySql.append("select clerk.CUST_ID,clerk.DEPT_ID,clerk.IFOFFICE,clerk.CHECKTYPE_ID")
		.append(" from YKT_CK.T_CLERKINFO clerk")
		.append(" left join YKT_CUR.T_CUSTOMER cust on cust.CUSTID=clerk.CUST_ID")
		.append(" where 1>0");
		if ((!"".equals(deptId))&& !(null==deptId)){
			querySql.append(" and clerk.DEPT_ID='"+deptId+"'");
		}
		if ((!"".equals(stuEmpNo))&& !(null==stuEmpNo)){
			querySql.append(" and cust.STUEMPNO='"+stuEmpNo+"'");
		}
		//System.out.println(querySql);
		List custList = jdbcTemplate.queryForList(querySql.toString());
		
		Map custInfo = new HashMap();		
		long diffDate = DateUtilExtend.diffDate(startDate,endDate);
		for (long diffDay = 0;diffDay<=diffDate;diffDay++){
			String workDate = DateUtilExtend.addDate2(startDate,(int)diffDay);
			custInfo.put("signDate",workDate);
			//custInfo.put("deptId",deptId);
			if (!custList.isEmpty()){
				Iterator tmpList = custList.iterator();
				String ifOffice = "";
				//int i=0;
				while (tmpList.hasNext()){
					// ++i;
					Map custInfoList = (Map) tmpList.next();
					ifOffice = custInfoList.get("IFOFFICE").toString();
					custInfo.put("custId",custInfoList.get("CUST_ID"));
					custInfo.put("deptId",custInfoList.get("DEPT_ID"));
					custInfo.put("checktypeId",custInfoList.get("CHECKTYPE_ID"));
					//非坐班人员考勤信息
					if ("2".equals(ifOffice)){
						//取得考勤人员的实际上班时间和下班时间
						dealWithNoSeatClerk(custInfo);
						//完成后把考勤信息加入报表中去
						//dealWithNoSeatReport(custInfo);
					//坐班人员考勤信息
					}else if ("1".equals(ifOffice)){
						//取得考勤人员的实际上班时间和下班时间
						createPersonWorkInfo(custInfo);
						//完成后把考勤信息加入报表中去
						//dealWithSeatReport(custInfo);
					}
					//System.out.println("1111111111111111111"+i);
				}
			}
		}
	}
	
	/**
	 * 生成所有考勤人员考勤报表 32017669
	 */
	public void createAllWorkReportByDptConf(Map filter) throws Exception{
		String startDate = (String) filter.get("startDate");
		String endDate = (String) filter.get("endDate");
		String deptId = (String) filter.get("deptId");
		String stuEmpNo = (String) filter.get("stuEmpNo");
		StringBuffer querySql = new StringBuffer(1024);
		querySql.append("select clerk.CUST_ID,clerk.DEPT_ID,clerk.IFOFFICE,clerk.CHECKTYPE_ID")
		.append(" from YKT_CK.T_CLERKINFO clerk")
		.append(" left join YKT_CUR.T_CUSTOMER cust on cust.CUSTID=clerk.CUST_ID")
		.append(" where 1>0");
		if ((!"".equals(deptId))&& !(null==deptId)){
			querySql.append(" and clerk.DEPT_ID='"+deptId+"'");
		}
		if ((!"".equals(stuEmpNo))&& !(null==stuEmpNo)){
			querySql.append(" and cust.STUEMPNO='"+stuEmpNo+"'");
		}
		//System.out.println(querySql);
		List custList = jdbcTemplate.queryForList(querySql.toString());
		
		Map custInfo = new HashMap();		
		long diffDate = DateUtilExtend.diffDate(startDate,endDate);
		for (long diffDay = 0;diffDay<=diffDate;diffDay++){
			String workDate = DateUtilExtend.addDate2(startDate,(int)diffDay);
			custInfo.put("signDate",workDate);
			//custInfo.put("deptId",deptId);
			if (!custList.isEmpty()){
				Iterator tmpList = custList.iterator();
				String ifOffice = "";
				while (tmpList.hasNext()){
					Map custInfoList = (Map) tmpList.next();
					ifOffice = custInfoList.get("IFOFFICE").toString();
					custInfo.put("custId",custInfoList.get("CUST_ID"));
					custInfo.put("deptId",custInfoList.get("DEPT_ID"));
					custInfo.put("checktypeId",custInfoList.get("CHECKTYPE_ID"));
					//非坐班人员考勤信息
					if ("2".equals(ifOffice)){
						//取得考勤人员的实际上班时间和下班时间
						//dealWithNoSeatClerk(custInfo);
						//完成后把考勤信息加入报表中去
						dealWithNoSeatReport(custInfo);
					//坐班人员考勤信息
					}else if ("1".equals(ifOffice)){
						//取得考勤人员的实际上班时间和下班时间
						//createPersonWorkInfo(custInfo);
						//完成后把考勤信息加入报表中去
						dealWithSeatReport(custInfo);
					}
				}
			}
		}
	}
	/**
	 * 生成非坐班人员报表
	 * @param filter
	 * hanjiwe modify it 20061201
	 */
	private void dealWithNoSeatReport(Map filter){
		String signDate = (String) filter.get("signDate");
		String custId = String.valueOf(filter.get("custId"));
		List attinfo = getCheckInfoByCustAndDate(signDate,custId);
		//String deptId = String.valueOf(filter.get("deptId"));
		String onTime = "000000";
		String offTime = "000000";
		int workTime =  0;
		int leaveTime = 0;
		String ifOffice = "2";
		String week = DateUtilExtend.getWeekByDate(signDate);
		//如果没有找到考勤记录，并且不是双休日，而且没有请假，那么该考勤人员算是缺席，缺席时间按规定时间算
		if (attinfo.size()==0){
			if (!"6".equals(week)&&!"7".equals(week)&&leaveList(signDate,custId).size()==0){
				leaveTime =  (int)DateUtilExtend.timeDiff1(ClerkConfig.WORKONTIME,ClerkConfig.WORKOFFTIME);
			}
		}else{
			Map attMap = (Map)attinfo.get(0);
			//deptId = attMap.get("CHECKTYPE_ID").toString();
			onTime = oToString(attMap.get("FACT_ONTIME"));
			offTime = oToString(attMap.get("FACT_OFFTIME"));
			workTime =  getWorkTimeValue(onTime,offTime);
			ifOffice = oToString(attMap.get("IFOFFICE"));
		}
		TCheckattReport attReport = new TCheckattReport();
		TCheckattReportId attReportId = new TCheckattReportId();
		attReportId.setCheckDate(signDate);
		attReportId.setCustId(Integer.valueOf(custId));
		attReport.setId(attReportId);
		//attReport.setDeptId(deptId);
		attReport.setIfoffice(ifOffice);
		attReport.setFactValue(new Integer(workTime));
		attReport.setLeaveValue(new Integer(leaveTime));
		
		if ("6".equals(week)||"7".equals(week)){
			attReport.setTworestValue(new Integer(workTime));
		}
		Map leaveInfoMap = getLeaveInfoMap(signDate,custId);
		attReport.setLeaveType(oToString(leaveInfoMap.get("leaveType")));
		attReport.setLeaveTime(Integer.valueOf(oToString(leaveInfoMap.get("leaveTime"))));
		if (exitReportByCustId(custId,signDate)){
			workInfodao.update(attReport);
		}else{
			workInfodao.save(attReport);
		}
		
	}
	/**
	 * 生成坐班人员报表
	 * @param filter
	 * hanjiwei add it 20061201
	 */
	private void dealWithSeatReport(Map filter){
		String signDate = (String) filter.get("signDate");
		String custId = String.valueOf(filter.get("custId"));
		//String deptId = String.valueOf(filter.get("deptId"));
		List workConf = getCheckWorkInfo(custId,signDate);
		if (workConf.size()>0){
			Map workConfMap = (Map)workConf.get(0);
			List attinfo = getCheckInfoByCustAndDate(signDate,custId);
			int factWorkTime =  0;	//实际工作时间(分钟)
			int factWorkNum = 0;	//实际工作次数
			Map calcWorkConfTime = calcWorkConfTime(workConfMap);
			int workConfTime = Integer.parseInt(calcWorkConfTime.get("totWorkTime").toString());//应该工作时间
			int workNum = Integer.parseInt(calcWorkConfTime.get("workNum").toString());//应该工作次数
			int leaveTime = 0;		//缺席时间(分钟)
			int leaveNum = 0;		//缺席次数
			int overTime = 0;		//加班时间(分钟)
			int overNum = 0;		//加班次数
			int lateTime = 0;		//迟到时间(分钟)
			int lateNum = 0;		//迟到次数
			int earlyLeaveTime = 0;	//早退时间(分钟)
			int earlyNum = 0;		//早退次数
			String ifOffice = "1";
			String week = DateUtilExtend.getWeekByDate(signDate);
			//如果没有找到考勤记录，并且不是双休日，而且没有请假，那么该考勤人员算是缺席，缺席时间按规定时间算
			if (attinfo.size()==0){
				if (!"6".equals(week)&&!"7".equals(week)&&leaveList(signDate,custId).size()==0){
					leaveTime =  (int)DateUtilExtend.timeDiff1(ClerkConfig.WORKONTIME,ClerkConfig.WORKOFFTIME);
				}
			}else{
				Map attMap = (Map)attinfo.get(0);
				Map calcFactWorkTime = calcFactWorkTime(attMap);
				factWorkTime =  Integer.parseInt(calcFactWorkTime.get("totWorkTime").toString());
				factWorkNum = Integer.parseInt(calcFactWorkTime.get("workNum").toString());
				Map workReportData = makeWorkReportData(workConfMap,attMap);
				if (factWorkTime-workConfTime>=0){
					overTime = factWorkTime-workConfTime;
					overNum=factWorkNum-workNum;
				}else{
					leaveTime = Integer.parseInt(workReportData.get("totLeaveTime").toString());
					leaveNum = Integer.parseInt(workReportData.get("totLeaveNum").toString());
				}
				ifOffice = attMap.get("IFOFFICE").toString();
				lateTime = Integer.parseInt(workReportData.get("totLateTime").toString());
				lateNum =Integer.parseInt(workReportData.get("totLateNum").toString());
				earlyLeaveTime = Integer.parseInt(workReportData.get("totEarlyTime").toString());
				earlyNum = Integer.parseInt(workReportData.get("totEarlyNum").toString());
			}
			TCheckattReport attReport = new TCheckattReport();
			TCheckattReportId attReportId = new TCheckattReportId();
			attReportId.setCheckDate(signDate);
			attReportId.setCustId(Integer.valueOf(custId));
			attReport.setId(attReportId);
			attReport.setWorktimeValue(new Integer(workConfTime));
			attReport.setWorktimeNum(new Integer(workNum));
			attReport.setOvertimeValue(new Integer(overTime));
			attReport.setExtcheckNum(new Integer(overNum));
			//attReport.setLeaveTime(new Integer(leaveTime));
			attReport.setLeaveNum(new Integer(leaveNum));
			attReport.setLeaveEarly(new Integer(earlyLeaveTime));
			attReport.setEarlyNum(new Integer(earlyNum));
			attReport.setDelayValue(new Integer(lateTime));
			attReport.setDelayNum(new Integer(lateNum));
			//attReport.setDeptId(deptId);
			attReport.setIfoffice(ifOffice);
			attReport.setFactValue(new Integer(factWorkTime));
			attReport.setCheckNum(new Integer(factWorkNum));
			
			if ("6".equals(week)||"7".equals(week)){
				attReport.setTworestValue(new Integer(factWorkTime));
			}
			
			Map leaveInfoMap = getLeaveInfoMap(signDate,custId);
			String leaveMapTime = oToString(leaveInfoMap.get("leaveTime"));
			if ("0".equals(leaveMapTime)){
				attReport.setLeaveValue(new Integer(leaveTime));
			}else{
				attReport.setLeaveValue(new Integer(0));
			}
			attReport.setLeaveType(oToString(leaveInfoMap.get("leaveType")));
			attReport.setLeaveTime(Integer.valueOf(leaveMapTime));
			if (exitReportByCustId(custId,signDate)){
				workInfodao.update(attReport);
			}else{
				workInfodao.save(attReport);
			}
		}
		
	}
	
	/**
	 * 计算考勤上班时间和下班时间的差值
	 * @param onTime
	 * @param offTime
	 * @return
	 * hanjiwei add it 20061201
	 */
	private int getWorkTimeValue(String onTime,String offTime){
		if ("".equals(onTime)||
				"".equals(offTime)||
				null==onTime||
				null==offTime||
				onTime.length()!=6||
				offTime.length()!=6){
			return 0;
		}else if ("000000".equals(onTime)||"000000".equals(offTime)){
			return 0;
		}else{
			return (int)DateUtilExtend.timeDiff1(onTime,offTime);
		}
	}
	
	/**
	 * 早退时间、次数；迟到时间、次数；缺席时间、次数
	 * @param workConfMap
	 * @param attMap
	 * @return
	 */
	private Map makeWorkReportData(Map workConfMap,Map attMap){
		String workOnTime1 = formatWorkTime2(workConfMap.get("ONTIME1"));
		String workOnTime2 = formatWorkTime2(workConfMap.get("ONTIME2"));
		String workOnTime3 = formatWorkTime2(workConfMap.get("ONTIME3"));
		String workOnTime4 = formatWorkTime2(workConfMap.get("ONTIME4"));
		String workOffTime1 = formatWorkTime2(workConfMap.get("OFFTIME1"));
		String workOffTime2 = formatWorkTime2(workConfMap.get("OFFTIME2"));
		String workOffTime3 = formatWorkTime2(workConfMap.get("OFFTIME3"));
		String workOffTime4 = formatWorkTime2(workConfMap.get("OFFTIME4"));
		String factOnTime1 = oToString(attMap.get("FACT_ONTIME1"));
		String factOnTime2 = oToString(attMap.get("FACT_ONTIME2"));
		String factOnTime3 = oToString(attMap.get("FACT_ONTIME3"));
		String factOnTime4 = oToString(attMap.get("FACT_ONTIME4"));
		String factOffTime1 = oToString(attMap.get("FACT_OFFTIME1"));
		String factOffTime2 = oToString(attMap.get("FACT_OFFTIME2"));
		String factOffTime3 = oToString(attMap.get("FACT_OFFTIME3"));
		String factOffTime4 = oToString(attMap.get("FACT_OFFTIME4"));
		
		int leaveNum1 = Integer.parseInt(getWorkData(factOnTime1,factOffTime1,workOnTime1,workOffTime1).get("leaveNum").toString());
		int leaveTime1 = Integer.parseInt(getWorkData(factOnTime1,factOffTime1,workOnTime1,workOffTime1).get("leaveTime").toString());		
		int lateTime1 = Integer.parseInt(getWorkData(factOnTime1,factOffTime1,workOnTime1,workOffTime1).get("lateTime").toString());
		int lateNum1 = Integer.parseInt(getWorkData(factOnTime1,factOffTime1,workOnTime1,workOffTime1).get("lateNum").toString());
		int earlyTime1 = Integer.parseInt(getWorkData(factOnTime1,factOffTime1,workOnTime1,workOffTime1).get("earlyTime").toString());
		int earlyNum1 = Integer.parseInt(getWorkData(factOnTime1,factOffTime1,workOnTime1,workOffTime1).get("earlyNum").toString());
		
		int leaveNum2 = Integer.parseInt(getWorkData(factOnTime2,factOffTime2,workOnTime2,workOffTime2).get("leaveNum").toString());
		int leaveTime2 = Integer.parseInt(getWorkData(factOnTime2,factOffTime2,workOnTime2,workOffTime2).get("leaveTime").toString());		
		int lateTime2 = Integer.parseInt(getWorkData(factOnTime2,factOffTime2,workOnTime2,workOffTime2).get("lateTime").toString());
		int lateNum2 = Integer.parseInt(getWorkData(factOnTime2,factOffTime2,workOnTime2,workOffTime2).get("lateNum").toString());
		int earlyTime2 = Integer.parseInt(getWorkData(factOnTime2,factOffTime2,workOnTime2,workOffTime2).get("earlyTime").toString());
		int earlyNum2 = Integer.parseInt(getWorkData(factOnTime2,factOffTime2,workOnTime2,workOffTime2).get("earlyNum").toString());
		
		int leaveNum3 = Integer.parseInt(getWorkData(factOnTime3,factOffTime3,workOnTime3,workOffTime3).get("leaveNum").toString());
		int leaveTime3 = Integer.parseInt(getWorkData(factOnTime3,factOffTime3,workOnTime3,workOffTime3).get("leaveTime").toString());		
		int lateTime3 = Integer.parseInt(getWorkData(factOnTime3,factOffTime3,workOnTime3,workOffTime3).get("lateTime").toString());
		int lateNum3 = Integer.parseInt(getWorkData(factOnTime3,factOffTime3,workOnTime3,workOffTime3).get("lateNum").toString());
		int earlyTime3 = Integer.parseInt(getWorkData(factOnTime3,factOffTime3,workOnTime3,workOffTime3).get("earlyTime").toString());
		int earlyNum3 = Integer.parseInt(getWorkData(factOnTime3,factOffTime3,workOnTime3,workOffTime3).get("earlyNum").toString());
				
		int leaveNum4 = Integer.parseInt(getWorkData(factOnTime4,factOffTime4,workOnTime4,workOffTime4).get("leaveNum").toString());
		int leaveTime4 = Integer.parseInt(getWorkData(factOnTime4,factOffTime4,workOnTime4,workOffTime4).get("leaveTime").toString());		
		int lateTime4 = Integer.parseInt(getWorkData(factOnTime4,factOffTime4,workOnTime4,workOffTime4).get("lateTime").toString());
		int lateNum4 = Integer.parseInt(getWorkData(factOnTime4,factOffTime4,workOnTime4,workOffTime4).get("lateNum").toString());
		int earlyTime4 = Integer.parseInt(getWorkData(factOnTime4,factOffTime4,workOnTime4,workOffTime4).get("earlyTime").toString());
		int earlyNum4 = Integer.parseInt(getWorkData(factOnTime4,factOffTime4,workOnTime4,workOffTime4).get("earlyNum").toString());
		
		int totLeaveNum = leaveNum1+leaveNum2+leaveNum3+leaveNum4;
		int totLeaveTime = leaveTime1+leaveTime2+leaveTime3+leaveTime4;
		int totLateTime = lateTime1+lateTime2+lateTime3+lateTime4;
		int totLateNum = lateNum1+lateNum2+lateNum3+lateNum4;
		int totEarlyTime = earlyTime1+earlyTime2+earlyTime3+earlyTime4;
		int totEarlyNum = earlyNum1+earlyNum2+earlyNum3+earlyNum4;
		
		Map workReportData = new HashMap();
		workReportData.put("totLeaveNum",new Integer(totLeaveNum));
		workReportData.put("totLeaveTime",new Integer(totLeaveTime));
		workReportData.put("totLateTime",new Integer(totLateTime));
		workReportData.put("totLateNum",new Integer(totLateNum));
		workReportData.put("totEarlyTime",new Integer(totEarlyTime));
		workReportData.put("totEarlyNum",new Integer(totEarlyNum));
		return workReportData;
	}
	
	private Map getWorkData(String factOnTime,String factOffTime,String workOnTime,String workOffTime){
		int leaveNum = 0;
		int leaveTime = 0;		
		int lateTime = 0;
		int lateNum = 0;
		int earlyTime = 0;
		int earlyNum = 0;
		//如果上下班时间都为空，则为缺席，为缺席时则不再记录迟到和早退的记录
		if ("000000".equals(factOnTime) && "000000".equals(factOffTime)){
			leaveNum++;
			leaveTime = getWorkTimeValue(workOnTime,workOffTime);
		}else{
			//开始计算迟到和早退时间和次数
			if (getWorkTimeValue(workOnTime,factOnTime)>0){
				lateTime = getWorkTimeValue(workOnTime,factOnTime);
				lateNum++;
			}
			if (getWorkTimeValue(workOffTime,factOffTime)<0){
				earlyTime = getWorkTimeValue(factOffTime,workOffTime);
				earlyNum++;
			}
			
		}
		Map workData = new HashMap();
		workData.put("leaveNum",new Integer(leaveNum));
		workData.put("leaveTime",new Integer(leaveTime));
		workData.put("lateNum",new Integer(lateNum));
		workData.put("lateTime",new Integer(lateTime));
		workData.put("earlyTime",new Integer(earlyTime));
		workData.put("earlyNum",new Integer(earlyNum));
		return workData;
	}
	/**
	 * 计算应该工作时间,应该工作次数
	 * @return
	 */
	private Map calcWorkConfTime(Map workConfMap){
		String onTime1 = "000000";
		String offTime1 = "000000";
		String onTime2 = "000000";
		String offTime2 = "000000";
		String onTime3 = "000000";
		String offTime3 = "000000";
		String onTime4 = "000000";
		String offTime4 = "000000";
		int totWorkTime = 0;
		onTime1 = formatWorkTime2(workConfMap.get("ONTIME1"));
		offTime1 = formatWorkTime2(workConfMap.get("OFFTIME1"));
		onTime2 = formatWorkTime2(workConfMap.get("ONTIME2"));
		offTime2 = formatWorkTime2(workConfMap.get("OFFTIME2"));
		onTime3 = formatWorkTime2(workConfMap.get("ONTIME3"));
		offTime3 = formatWorkTime2(workConfMap.get("OFFTIME3"));
		onTime4 = formatWorkTime2(workConfMap.get("ONTIME4"));
		offTime4 = formatWorkTime2(workConfMap.get("OFFTIME4"));
		
		int workTime1 = getWorkTimeValue(onTime1,offTime1);
		int workTime2 = getWorkTimeValue(onTime2,offTime2);
		int workTime3 = getWorkTimeValue(onTime3,offTime3);
		int workTime4 = getWorkTimeValue(onTime4,offTime4);
		int workNum = 0;
		if (workTime1>0){
			workNum++;
		}
		if (workTime2>0){
			workNum++;
		}
		if (workTime3>0){
			workNum++;
		}
		if (workTime4>0){
			workNum++;
		}
		totWorkTime =  workTime1+workTime2+workTime3+workTime4;
		Map workConfTime = new HashMap();
		workConfTime.put("totWorkTime",new Integer(totWorkTime));
		workConfTime.put("workNum",new Integer(workNum));
		
		return workConfTime;
	}
	
	/**
	 * 计算实际工作时间,实际考勤次数
	 * @param attinfo
	 * @return
	 * hanjiwei add it 20061201
	 */
	private Map calcFactWorkTime(Map attMap){
		String onTime1 = "000000";
		String offTime1 = "000000";
		String onTime2 = "000000";
		String offTime2 = "000000";
		String onTime3 = "000000";
		String offTime3 = "000000";
		String onTime4 = "000000";
		String offTime4 = "000000";
		
		onTime1 = oToString(attMap.get("FACT_ONTIME1"));
		offTime1 = oToString(attMap.get("FACT_OFFTIME1"));
		onTime2 = oToString(attMap.get("FACT_ONTIME2"));
		offTime2 = oToString(attMap.get("FACT_OFFTIME2"));
		onTime3 = oToString(attMap.get("FACT_ONTIME3"));
		offTime3 = oToString(attMap.get("FACT_OFFTIME3"));
		onTime4 = oToString(attMap.get("FACT_ONTIME4"));
		offTime4 = oToString(attMap.get("FACT_OFFTIME4"));
		
		int totWorkTime = 0;
		int factWorkTime1 = getWorkTimeValue(onTime1,offTime1);
		int factWorkTime2 = getWorkTimeValue(onTime2,offTime2);
		int factWorkTime3 = getWorkTimeValue(onTime3,offTime3);
		int factWorkTime4 = getWorkTimeValue(onTime4,offTime4);
		int workNum = 0;
		
		if (factWorkTime1>0) {
			workNum++;
		}
		if (factWorkTime2>0) {
			workNum++;
		}
		if (factWorkTime3>0) {
			workNum++;
		}
		if (factWorkTime4>0) {
			workNum++;
		}
		
		totWorkTime =  factWorkTime1+factWorkTime2+factWorkTime3+factWorkTime4;
		
		Map factWorkTime = new HashMap();
		factWorkTime.put("totWorkTime",new Integer(totWorkTime));
		factWorkTime.put("workNum",new Integer(workNum));
		return factWorkTime;
	}
	
	/**
	 * 取得请假信息列表
	 * @param signDate
	 * @param custId
	 * @return
	 * hanjiwei add it 20061201
	 */
	private List leaveList(String signDate,String custId){
		StringBuffer queryStr = new StringBuffer(1024);
		queryStr.append("select LEAVE_TYPEID, VALIDITY, STARTDATE,ENDDATE, STARTTIME, ENDTIME")
		.append(" from YKT_CK.T_LEAVEINFO where STARTDATE<=?")
		.append(" and ENDDATE>=? and CUST_ID=?")
		.append(" and VALIDITY='1'");
		List leaveList = jdbcTemplate.queryForList(queryStr.toString(),new Object[]{signDate,signDate,Integer.valueOf(custId)});
		return leaveList;
	}
	
	/**
	 * 非坐班人员计算请假信息到报表中去
	 * @param attReport
	 * @param signDate
	 * @param custId
	 * hanjiwei modify it 20061201
	 */
	private Map getLeaveInfoMap(String signDate,String custId){
		List leaveLst = leaveList(signDate,custId);
		int leaveTime = 0;
		String leaveType = "";
		if (leaveLst.size()>0){
			Map leaveMap = (Map)leaveLst.get(0);
			leaveType = oToString(leaveMap.get("LEAVE_TYPEID"));
			String startDate = oToString(leaveMap.get("STARTDATE"));
			String endDate = oToString(leaveMap.get("ENDDATE"));
			String startTime = oToString(leaveMap.get("STARTTIME"));
			String endTime = oToString(leaveMap.get("ENDTIME"));
			if (startDate.equals(endDate)){
				leaveTime = (int)DateUtilExtend.timeDiff1(startTime,endTime);
			}else{
				if (signDate.equals(startDate)){
					leaveTime = (int)DateUtilExtend.timeDiff1(startTime,ClerkConfig.WORKOFFTIME);
				}else if (signDate.equals(endDate)){
					leaveTime = (int)DateUtilExtend.timeDiff1(ClerkConfig.WORKONTIME,endTime);
				}else{
					leaveTime = (int)DateUtilExtend.timeDiff1(ClerkConfig.WORKONTIME,ClerkConfig.WORKOFFTIME);
				}
			}
		}
		Map leaveInfoMap = new HashMap();
		leaveInfoMap.put("leaveTime",new Integer(leaveTime));
		leaveInfoMap.put("leaveType",leaveType);
		return leaveInfoMap;
	}
	
	/**
	 * 取得考勤人员实际考勤信息
	 * @param signDate
	 * @param custId
	 * @return
	 * hanjiwei add it 20061130
	 */
	private List getCheckInfoByCustAndDate(String signDate,String custId){
		StringBuffer querySql = new StringBuffer(512);
		querySql.append("select CUST_ID, CHECK_DATE, IFOFFICE, FACT_ONTIME, FACT_OFFTIME,")
		.append(" FACT_ONTIME1, FACT_OFFTIME1, FACT_ONTIME2, FACT_OFFTIME2, FACT_ONTIME3, ")
		.append(" FACT_OFFTIME3, FACT_ONTIME4, FACT_OFFTIME4 from YKT_CK.T_CHECKATT_INFO")
		.append(" where CUST_ID=? and CHECK_DATE=?");
		List attInfo = jdbcTemplate.queryForList(querySql.toString(),new Object[]{Integer.valueOf(custId),signDate});
		return attInfo;
	}
	
	/**
	 * 取得考勤人员规定考勤信息
	 * @param custId
	 * @return
	 * hanjiwei add it 20061130
	 */
	private List getCheckWorkInfo(String custId,String signDate){
		StringBuffer querySql = new StringBuffer(1024);
		querySql.append("select workmap.CHECK_TYPEID, workmap.BEGINDATE, workmap.WORKINFO_ID, workmap.WORKTIME_ID,")
				.append(" workmap.IFWORK,workconf.WORKCONF_NAME, workconf.OVERDUE_TIME, workconf.LEAVEEARLY_TIME,")
				.append(" workconf.OVER_TIME,workconf.DELAY_TIME, workconf.CHECK_TIME, worktime.WORKTIME_NAME, ")
				.append(" worktime.ONTIME1,worktime.OFFTIME1, worktime.ONTIME2, worktime.OFFTIME2, worktime.ONTIME3,")
				.append(" worktime.OFFTIME3, worktime.ONTIME4, worktime.OFFTIME4")
				.append(" from YKT_CK.T_CLERKINFO clerkinfo ")
				.append(" left join YKT_CK.T_CHECK_WORKCONFINFO workmap on workmap.CHECK_TYPEID=clerkinfo.CHECKTYPE_ID")
				.append(" left join YKT_CK.T_WORKCONFINFO workconf on workconf.WORKCONF_ID=workmap.WORKINFO_ID")
				.append(" left join YKT_CK.T_WORKTIMEINTO worktime on worktime.WORKTIME_ID=workmap.WORKTIME_ID")
				.append(" where clerkinfo.CUST_ID=?")
				.append(" and workmap.BEGINDATE=?");
		List workInfo = jdbcTemplate.queryForList(querySql.toString(),new Object[]{Integer.valueOf(custId),signDate});
		return workInfo;
	}
	
	/**
	 * 查询考勤人员在一段时间内的工作时间,并按列表返回
	 * @param attMap
	 * @return
	 */
	public List getCustWorkTime(String deptId,String beginDate,String endDate){
		Iterator iter = queryClerk(deptId).iterator();
		//List custWorkTime = null;
		List returnWorkList = new ArrayList();
		while (iter.hasNext()){
			Map custInfo = (Map)iter.next();
			int custId = Integer.parseInt(custInfo.get("CUT_ID").toString());
			StringBuffer querySql = new StringBuffer(512);
			querySql.append("select CUST_ID,ATT_DATE, min(ATT_TIME) onTime,max(ATT_TIME) offTime from (")
			.append(" select CUST_ID,ATT_DATE, ATT_TIME from YKT_CK.T_ATTSERIAL")
			.append(" where cust_id=?").append(" and ATT_DATE>=?")
			.append(" and ATT_DATE<=?")
			.append(" union")
			.append(" select CUST_ID, ATT_DATE, ATT_TIME")
			.append(" from YKT_CK.T_ATTSERIAL_RECORD ")
			.append(" where cust_id=?").append(" and ATT_DATE>=?")
			.append(" and ATT_DATE<=?")
			.append(" )t group by att_date,cust_id order by att_date");
			//System.out.println(querySql.toString());
			List custWorkTime = jdbcTemplate.queryForList(querySql.toString(),new Object[]{new Integer(custId),beginDate,endDate,new Integer(custId),beginDate,endDate});
			//把查询出的人员考勤记录相加放入到list中
			Map workTime = new HashMap();
			String workTimeM = getCustWorkTime(custWorkTime);
			String pubRest = getCustRestTime(getCustPubRest(custId,beginDate,endDate)).toString();
			String personRest = getCustRestTime(getCustPersonRest(custId,beginDate,endDate)).toString();
			float totleTime = 0;
			totleTime = Float.parseFloat(workTimeM)+Float.parseFloat(pubRest)+Float.parseFloat(personRest);
			//计算考勤人员的公事请假时间和私事请假时间
			workTime.put("pubRest",pubRest);
			workTime.put("pubRestH",new Float(Float.parseFloat(pubRest)/60));
			workTime.put("personRest",personRest);
			workTime.put("personRestH",new Float(Float.parseFloat(personRest)/60));
			workTime.put("custId",custInfo.get("CUT_ID"));
			workTime.put("stuempId",custInfo.get("STUEMPID"));
			workTime.put("custName",custInfo.get("STUEMPNAME"));
			workTime.put("deptName",custInfo.get("DEPT_NAME"));
			workTime.put("workTimeM",workTimeM);
			workTime.put("workTime",new Float(Float.parseFloat(workTimeM)/60));
			workTime.put("totleTime",new Float(totleTime/60));
			returnWorkList.add(workTime);
		}
		
		return returnWorkList;
	}
	
	/**
	 * 计算考勤人员在一段时间内的工作时间
	 * @param custWorkTime
	 * @return
	 */
	private String getCustWorkTime(List custWorkTime){
		Iterator timeIter = custWorkTime.iterator();
		int time = 0;
		//DecimalFormat df = new DecimalFormat("0.000"); 
		
		while (timeIter.hasNext()){
			Map custTime = (Map)timeIter.next();
			String onTime = custTime.get("onTime").toString();
			String offTime = custTime.get("offTime").toString();
			time = time+getWorkTimeValue(onTime,offTime);
		}
		//String reTime = df.format(new Float(time/60));
		String reTime = (new Integer(time)).toString();
		return reTime;
	}
	
	/**
	 * 私假时间
	 * @param custId
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	private String getCustPersonRest(int custId,String beginDate,String endDate){
		StringBuffer sql = new StringBuffer(2048);
		sql.append("select CUST_ID, LEAVE_TYPEID,STARTDATE,ENDDATE, STARTTIME, ENDTIME")
		.append(" from YKT_CK.T_LEAVEINFO")
		.append(" where cust_id=").append(custId)
		.append(" and startdate>='").append(beginDate).append("' and enddate<='")
		.append(endDate).append("' and LEAVE_TYPEID not in (").append(Constants.PUBREST)
		.append(")");
		return sql.toString();
	}
	/**
	 * 公假时间
	 * @param custId
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	private String getCustPubRest(int custId,String beginDate,String endDate){
		StringBuffer sql = new StringBuffer(2048);
		sql.append("select CUST_ID, LEAVE_TYPEID,STARTDATE,ENDDATE, STARTTIME, ENDTIME")
		.append(" from YKT_CK.T_LEAVEINFO")
		.append(" where cust_id=").append(custId)
		.append(" and startdate>='").append(beginDate).append("' and enddate<='")
		.append(endDate).append("' and LEAVE_TYPEID in (").append(Constants.PUBREST)
		.append(")");
		return sql.toString();
	}
	
	private Integer getCustRestTime(String sql){
		List custPersonRestTime = jdbcTemplate.queryForList(sql.toString());
		long time = 0;
		Iterator iter = custPersonRestTime.iterator();
		while (iter.hasNext()){
			Map iterMap = (Map)iter.next();
			String bDate = oToString(iterMap.get("STARTDATE"));
			String eDate = oToString(iterMap.get("ENDDATE"));
			String bTime = oToString(iterMap.get("STARTTIME"));
			String eTime = oToString(iterMap.get("ENDTIME"));
			long diffDate = 0;
			long diffTime = 0;
			diffDate = DateUtilExtend.diffDate(bDate,eDate);
			diffTime = DateUtilExtend.timeDiff1(bTime,eTime);
			if (diffDate>0){
				time = time + diffDate*diffTime;
			}else{
				time = time + diffTime;
			}
		}		
		return Integer.valueOf(new Long(time).toString());
	}
	private List queryClerk(String deptId) {
		StringBuffer sql = new StringBuffer(2048);
		sql.append("SELECT B.CUSTID CUT_ID,B.STUEMPNO STUEMPID,B.CUSTNAME STUEMPNAME,")
		.append(" C.DEPT_NAME FROM YKT_CK.T_CLERKINFO A ")
		.append(" LEFT JOIN YKT_CUR.T_CUSTOMER B ON A.CUST_ID=B.CUSTID")
		.append(" LEFT  JOIN YKT_CK.DEPARTMENT C")
		.append(" ON A.DEPT_ID=C.DEPT_ID WHERE 1=1 ");
		//参数处理
		if ((deptId!=null)&&(!"all".equals(deptId))){
			sql.append(" AND A.DEPT_ID = '"+deptId+"'");	
		}
		sql.append(" order by C.DEPT_ID");
		//log.debug("Sql--------------->"+sql.toString());
		List clerkList = jdbcTemplate.queryForList(sql.toString());
		return clerkList;
	}
	
	/**
	private String formatTime(String inTime){
		if ("".equals(inTime) || null==inTime){
			return "";
		}else if ("000000".equals(inTime)){
			return "----";
		}else if ("235959".equals(inTime)){
			return "----";
		}else{
			return inTime.substring(0,2)+":"+inTime.substring(2,4);
		}
		
	}
	**/
	
	/**
	 * 生成教师考勤记录报表
	 * 20071031
	 */
	public List makeCheckReport(String statMonth,String deptId)throws Exception{
		Iterator checkIter = sysService.getCheckClerkInfo(deptId,"1,2,3,4").iterator();
		List checkInfoList = new ArrayList(); 
		while (checkIter.hasNext()){
			Map checkMap = (Map)checkIter.next();
			Map checkInfoMap = new HashMap();
			//取得人员信息和考勤信息并放入到list中
			String deptName = oToString(checkMap.get("dept_name"));
			String stuempNo = oToString(checkMap.get("stuemp_no"));
			String custId = oToString(checkMap.get("cust_id"));
			String custName = oToString(checkMap.get("cut_name"));
			String custType = oToString(checkMap.get("dict_caption"));
			String ofOffice = oToString(checkMap.get("DICT_VALUE"));
			//全勤为√,未考勤为X
			checkInfoMap.put("deptName",deptName);
			checkInfoMap.put("stuempNo",stuempNo);
			checkInfoMap.put("custName",custName);
			checkInfoMap.put("custType",custType);
			checkInfoMap.put("custId",custId);
			Iterator dayIter = sysService.getWeekByDate(statMonth).iterator();
			//checkInfoMap = getYYCheckReportMap(checkInfoMap,custId,dayIter,statMonth,ofOffice);
			checkInfoMap = getHYCheckReportMap(checkInfoMap,custId,dayIter,statMonth);
			checkInfoList.add(checkInfoMap);
		}
		return checkInfoList;
	}
	
	/**
	 * 生成教师考勤记录报表,这个是不需要考勤明细符号的类。
	 * 2008,08,29 --gejinfeng---
	 */
	public List makeCheckReport(String statMonth,String deptId,boolean  noToken)throws Exception{
		Iterator checkIter = sysService.getCheckClerkInfo(deptId,"1,2,3,4").iterator();
		List checkInfoList = new ArrayList(); 
		while (checkIter.hasNext()){
			Map checkMap = (Map)checkIter.next();
			Map checkInfoMap = new HashMap();
			//取得人员信息和考勤信息并放入到list中
			String deptName = oToString(checkMap.get("dept_name"));
			String stuempNo = oToString(checkMap.get("stuemp_no"));
			String custId = oToString(checkMap.get("cust_id"));
			String custName = oToString(checkMap.get("cut_name"));
			String custType = oToString(checkMap.get("dict_caption"));
			String ofOffice = oToString(checkMap.get("DICT_VALUE"));
			
			checkInfoMap.put("deptName",deptName);
			checkInfoMap.put("stuempNo",stuempNo);
			checkInfoMap.put("custName",custName);
			checkInfoMap.put("custType",custType);
			checkInfoMap.put("custId",custId);
			Iterator dayIter = sysService.getWeekByDate(statMonth).iterator();
		//	checkInfoMap = getYYCheckReportMap(checkInfoMap,custId,dayIter,statMonth,ofOffice);
			checkInfoMap = getCheckReportMapNoToken(checkInfoMap,custId,dayIter,statMonth);
			checkInfoList.add(checkInfoMap);
		}
		return checkInfoList;
	}
	
	/**
	 * 生成考勤报表----通用版,没有明细显示,没有半勤概念,只有合计考勤天数
	 * @param checkInfoMap
	 * @param custId
	 * @param statDate
	 * @param dayMap
	 * @param totCheckNum
	 * @param halfCheckNum
	 * @return
	 */
	private Map getCheckReportMapNoToken(
			Map checkInfoMap,
			String custId,
			Iterator dayIter,
			String statMonth){
		int totCheckNum = 0; //全勤次数
		PropertiesConfiguration config = GetPropertiesUtil.getInstance();
		String teaBeginTime = config.getString("teacher.beginTime");
		String teaEndTime = config.getString("teacher.endTime");
		while (dayIter.hasNext()){//如果没有参数设置这项，生成考勤信息也是不需要的，直接从考勤流水表里查，就可以了

			Map dayMap = (Map)dayIter.next();
			//取得当前日期和当前周
			StringBuffer statDate = new StringBuffer(8);
			statDate.append(statMonth.substring(0,4))
					.append(statMonth.substring(5,7))
					.append(dayMap.get("date"));
			//如果是专职教师
			
				if (getTeacherCheckNum(custId,statDate.toString(),teaBeginTime,teaEndTime)>0) {
							totCheckNum = totCheckNum + 1;
							
				}
	
		}
	
		checkInfoMap.put("totNum",new Integer(totCheckNum));
		return checkInfoMap;
	}
	

	/**
	 * 生成考勤报表----通用版
	 * @param checkInfoMap
	 * @param custId
	 * @param statDate
	 * @param dayMap
	 * @param totCheckNum
	 * @param halfCheckNum
	 * @return
	 */
	private Map getCommonCheckReportMap(
			Map checkInfoMap,
			String custId,
			Iterator dayIter,
			String statMonth){
		int totCheckNum = 0; //全勤次数
		int halfCheckNum = 0;//半勤次数
		while (dayIter.hasNext()){
			Map dayMap = (Map)dayIter.next();
			//取得当前日期和当前周
			StringBuffer statDate = new StringBuffer(8);
			statDate.append(statMonth.substring(0,4))
					.append(statMonth.substring(5,7))
					.append(dayMap.get("date"));
			List checkReportList = sysService.getCheckReportList(custId,statDate.toString());
			if (checkReportList.size()==0){
				checkInfoMap.put(dayMap.get("date"),"X");
			}else{
				Map checkReport = (Map)checkReportList.get(0);
				int workTimeNum = Integer.parseInt(checkReport.get("worktime_num").toString());
				int checkNum = Integer.parseInt(checkReport.get("check_num").toString());
				if (workTimeNum==checkNum){
					checkInfoMap.put(dayMap.get("date"),"√");
					totCheckNum = totCheckNum+1;
				}else if (workTimeNum>checkNum){
					checkInfoMap.put(dayMap.get("date"),"O");
					halfCheckNum = halfCheckNum+1;
				}else if (checkNum == 0){
					checkInfoMap.put(dayMap.get("date"),"X");
				}
			}
		}
		checkInfoMap.put("totNum",new Integer(totCheckNum));
		checkInfoMap.put("halfNum",new Integer(halfCheckNum));
		return checkInfoMap;
	}
	
	/**
	 * 通用报表2
	 * @param checkInfoMap
	 * @param custId
	 * @param dayIter
	 * @param statMonth
	 * @return
	 */
	private Map getCommonCheckReportMap1(
			Map checkInfoMap,
			String custId,
			Iterator dayIter,
			String statMonth) throws Exception{
		int totCheckNum = 0; //全勤次数
		int halfCheckNum = 0;//半勤次数
		while (dayIter.hasNext()){
			Map dayMap = (Map)dayIter.next();
			//取得当前日期和当前周
			StringBuffer statDate = new StringBuffer(8);
			statDate.append(statMonth.substring(0,4))
					.append(statMonth.substring(5,7))
					.append(dayMap.get("date"));
			if (sysService.getManCheck(custId,statDate.toString())>0){
				checkInfoMap.put(dayMap.get("date"),"△");
				totCheckNum = totCheckNum+1;
			}else if (sysService.getCardCheck(custId,statDate.toString())>0){
				checkInfoMap.put(dayMap.get("date"),"√");
				totCheckNum = totCheckNum+1;
			}else{
				checkInfoMap.put(dayMap.get("date")," ");
				
			}
		}
		checkInfoMap.put("totNum",new Integer(totCheckNum));
		checkInfoMap.put("halfNum",new Integer(halfCheckNum));
		return checkInfoMap;
	}
	
	//海洋大学考勤统计
	private Map getHYCheckReportMap(
			Map checkInfoMap,
			String custId,
			Iterator dayIter,
			String statMonth ){		
		PropertiesConfiguration config = GetPropertiesUtil.getInstance();
		String teaBeginTime = config.getString("teacher.beginTime");
		String teaEndTime = config.getString("teacher.endTime");
		int totCheckNum = 0;
		while (dayIter.hasNext()){
			Map dayMap = (Map)dayIter.next();
			//取得当前日期和当前周
			StringBuffer statDate = new StringBuffer(8);
			statDate.append(statMonth.substring(0,4))
					.append(statMonth.substring(5,7))
					.append(dayMap.get("date"));
			
			if (getHYCheckNum(custId,statDate.toString(),teaBeginTime,teaEndTime)>0) {
				checkInfoMap.put(dayMap.get("date"),"√");
				totCheckNum++;
			}else{
				checkInfoMap.put(dayMap.get("date"),"X");
			}
			checkInfoMap.put("totNum",new Integer(totCheckNum));
		}
			return checkInfoMap;
	}
	
	/**
	 * 教师考勤报表
	 * @param checkInfoMap
	 * @param custId
	 * @param dayIter
	 * @param statMonth
	 * @param ifOffice
	 * @return
	 */
	private Map getYYCheckReportMap(
			Map checkInfoMap,
			String custId,
			Iterator dayIter,
			String statMonth,
			String ifOffice){		
		PropertiesConfiguration config = GetPropertiesUtil.getInstance();
		String teaBeginTime = config.getString("teacher.beginTime");
		String teaEndTime = config.getString("teacher.endTime");
		String assisBeginTime = config.getString("assistant.beginTime");
		String assisEndTime = config.getString("assistant.endTime");
		String linkTime = config.getString("link.Time");
		
		float teaPatch = config.getFloat("teac.patch");
		float assAllPatch = config.getFloat("ass.alldaypatch");
		float assHalfPatch = config.getFloat("ass.halfdaypatch");
		float longAllPatch = config.getFloat("long.alldaypatch");
		float longHalfPatch = config.getFloat("long.halfdaypatch");
		float busPatch = config.getFloat("bus.patch");
		
		int totCheckNum = 0; //全勤次数
		int halfCheckNum = 0;//半勤次数
		int linkCheckNum = 0;//连班次数
		float patchMoney = 0;//补贴金额
		int holidayNum = 0;  //双休日次数
		while (dayIter.hasNext()){
			Map dayMap = (Map)dayIter.next();
			//取得当前日期和当前周
			StringBuffer statDate = new StringBuffer(8);
			statDate.append(statMonth.substring(0,4))
					.append(statMonth.substring(5,7))
					.append(dayMap.get("date"));
			
			String nextDate = DateUtilExtend.addDate2(statDate.toString(),1);
			int CurlinkCheckNum = getLinkCheckNum(custId,statDate.toString(),linkTime);
			int weekNum = DateUtilExtend.getWeekByDate2(statDate.toString());
			
			//如果是专职教师
			if ("1".equals(ifOffice)){
				int nextLinkNum = getTeacherCheckNum(custId,nextDate,teaBeginTime,teaEndTime);
				if (getTeacherCheckNum(custId,statDate.toString(),teaBeginTime,teaEndTime)>0) {
			
					if (CurlinkCheckNum>0 && nextLinkNum>0){
						checkInfoMap.put(dayMap.get("date"),"//");
						linkCheckNum++;
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							totCheckNum++;
							patchMoney = patchMoney + teaPatch;
						}
					}else{
						checkInfoMap.put(dayMap.get("date"),"√");
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							totCheckNum++;
							patchMoney = patchMoney + teaPatch;
						}
					}
					
				}else{
					checkInfoMap.put(dayMap.get("date"),"X");
				}
			}else if ("2".equals(ifOffice)){
				//教职工人员全勤记录
				int assisNum1 = getAssisCheckNum1(custId,statDate.toString(),assisBeginTime);
				int assisNum2 = getAssisCheckNum2(custId,statDate.toString(),assisEndTime);
				int nextLinkNum1 = getAssisCheckNum1(custId,nextDate,assisBeginTime);
				int nextLinkNum2 = getAssisCheckNum2(custId,nextDate,assisEndTime);
				
				if ((assisNum1>0)&& (assisNum2>0)){
					if (CurlinkCheckNum>0 && (nextLinkNum1>0 || nextLinkNum2>0)){
						checkInfoMap.put(dayMap.get("date"),"//");
						linkCheckNum++;
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							totCheckNum++;
							patchMoney = patchMoney + assAllPatch;
						}
					}else{
						checkInfoMap.put(dayMap.get("date"),"√");
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							totCheckNum++;
							patchMoney = patchMoney + assAllPatch;
						}
					}
				}else if (assisNum1>0 || assisNum2>0){
					if (CurlinkCheckNum>0 && (nextLinkNum1>0 || nextLinkNum2>0)){
						checkInfoMap.put(dayMap.get("date"),"#");
						linkCheckNum++;
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							halfCheckNum++;
							patchMoney = patchMoney + assHalfPatch;
						}
					}else{
						checkInfoMap.put(dayMap.get("date"),"O");
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							halfCheckNum++;
							patchMoney = patchMoney + assHalfPatch;
						}
					}
				}else if (assisNum1==0 && assisNum2==0){
					checkInfoMap.put(dayMap.get("date"),"X");
				}
			}else if ("3".equals(ifOffice)){
			//长期人员	
				int assisNum1 = getAssisCheckNum1(custId,statDate.toString(),assisBeginTime);
				int assisNum2 = getAssisCheckNum2(custId,statDate.toString(),assisEndTime);
				int nextLinkNum1 = getAssisCheckNum1(custId,nextDate,assisBeginTime);
				int nextLinkNum2 = getAssisCheckNum2(custId,nextDate,assisEndTime);
				
				if ((assisNum1>0)&& (assisNum2>0)){
					if (CurlinkCheckNum>0 && (nextLinkNum1>0 || nextLinkNum2>0)){
						checkInfoMap.put(dayMap.get("date"),"//");
						linkCheckNum++;
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							totCheckNum++;
							patchMoney = patchMoney + longAllPatch;
						}
					}else{
						checkInfoMap.put(dayMap.get("date"),"√");
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							totCheckNum++;
							patchMoney = patchMoney + longAllPatch;
						}
					}
				}else if (assisNum1>0 || assisNum2>0){
					if (CurlinkCheckNum>0 && (nextLinkNum1>0 || nextLinkNum2>0)){
						checkInfoMap.put(dayMap.get("date"),"#");
						linkCheckNum++;
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							halfCheckNum++;
							patchMoney = patchMoney + longHalfPatch;
						}
					}else{
						checkInfoMap.put(dayMap.get("date"),"O");
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							halfCheckNum++;
							patchMoney = patchMoney + longHalfPatch;
						}
					}
				}else if (assisNum1==0 && assisNum2==0){
					checkInfoMap.put(dayMap.get("date"),"X");
				}
			}else if ("4".equals(ifOffice)){
			//车队	
				int nextLinkNum = getTeacherCheckNum(custId,nextDate,teaBeginTime,teaEndTime);
				if (getTeacherCheckNum(custId,statDate.toString(),teaBeginTime,teaEndTime)>0) {
					if (CurlinkCheckNum>0 && nextLinkNum>0){
						checkInfoMap.put(dayMap.get("date"),"//");
						linkCheckNum++;
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							totCheckNum++;
							patchMoney = patchMoney + busPatch;
						}
					}else{
						checkInfoMap.put(dayMap.get("date"),"√");
						//判断是否为双休日，如果是，双休日次数加，但总数不加
						if (weekNum==1 || weekNum==7){
							holidayNum++;
						}else{
							totCheckNum++;
							patchMoney = patchMoney + busPatch;
						}
					}
				}else{
					checkInfoMap.put(dayMap.get("date"),"X");
				}
			}
			
		}
		checkInfoMap.put("totNum",new Integer(totCheckNum));
		checkInfoMap.put("halfNum",new Integer(halfCheckNum));
		checkInfoMap.put("linkNum",new Integer(linkCheckNum));
		checkInfoMap.put("patchMoney",String.valueOf(patchMoney));
		checkInfoMap.put("holidayNum",new Integer(holidayNum));

		return checkInfoMap;
	}
	
	/**
	 * 教师考勤次数
	 * @param custId
	 * @param checkDate
	 * @param teaBeginTime
	 * @param teaEndTime
	 * @return
	 */
	private int getTeacherCheckNum(String custId,String checkDate,String teaBeginTime,String teaEndTime){
		StringBuffer sql = new StringBuffer(1024);
		sql.append("select count(*)as num from (")
		.append(" select t.cust_id,t.att_date,t.att_time   from ykt_ck.t_attserial_record t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id where")
		.append(" t.cust_id=? and t.att_date=? and t.att_time>=? and t.att_time<=?")
		.append(" union all")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id where")
		.append(" t.cust_id=? and t.att_date=? and t.att_time>=? and t.att_time<=?)");
		
		int custList=jdbcTemplate.queryForInt(sql.toString(),
				new Object[]{
				Integer.valueOf(custId),
				checkDate,
				teaBeginTime,
				teaEndTime,
				Integer.valueOf(custId),
				checkDate,
				teaBeginTime,
				teaEndTime});
		return custList;
	}
	//统计在考勤类别中的考勤次数 
	private int getHYCheckNum(String custId,String checkDate,String teaBeginTime,String teaEndTime){
		StringBuffer sql = new StringBuffer(1024);
		sql.append( " select count(*)as num " )
		   .append( "  from ( " )
		   .append( "    select t.cust_id,t.att_date,t.att_time ,typeInfo.Type_Id,typeInfo.type_name,w.begindate " )
		   .append( "    from ykt_ck.t_attserial_record t ")
		   .append( "    left join ykt_ck.t_clerkinfo info  on t.cust_id = info.cust_id ")
		   .append( "    inner join ykt_ck.t_checktype typeInfo on  info.checktype_id = typeInfo.Type_Id ")	  
		   .append( "    inner join ykt_ck.t_check_workconfinfo w on w.check_typeid = typeInfo.Type_Id  " )	  
		   .append( "    where t.cust_id=?  and w.begindate= t.att_date and t.att_date=? and t.att_time>=? and t.att_time<=?")	  
		   .append( "    union all")
		   .append( "    select t.cust_id,t.att_date,t.att_time ,typeInfo.Type_Id,typeInfo.type_name,w.begindate " )
		   .append( "    from ykt_ck.t_attserial t ")
		   .append( "    left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id " )
		   .append( "    inner join ykt_ck.t_checktype typeInfo on  info.checktype_id = typeInfo.Type_Id ")	  
		   .append( "    inner join ykt_ck.t_check_workconfinfo w on w.check_typeid = typeInfo.Type_Id  " )	  
		   .append( "    where t.cust_id=?  and w.begindate= t.att_date and t.att_date=? and t.att_time>=? and t.att_time<=?")	
		   .append( " )" );	 
		int custList=jdbcTemplate.queryForInt(sql.toString(),
				new Object[]{
				Integer.valueOf(custId),
				checkDate,
				teaBeginTime,
				teaEndTime,
				Integer.valueOf(custId),
				checkDate,
				teaBeginTime,
				teaEndTime});
		return custList;
	}
	
	private int getTeacherCheckNumByMonth(String custId,String checkMonth,String teaBeginTime,String teaEndTime){
		StringBuffer sql = new StringBuffer(1024);
		sql.append("select count(*)as num from (")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial_record t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id where")
		.append(" t.cust_id=? and substr(t.att_date,1,6)=? and t.att_time>=? and t.att_time<=?")
		.append(" union all")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id where")
		.append(" t.cust_id=? and substr(t.att_date,1,6)=? and t.att_time>=? and t.att_time<=?)");
		
		int custList=jdbcTemplate.queryForInt(sql.toString(),
				new Object[]{
				Integer.valueOf(custId),
				checkMonth,
				teaBeginTime,
				teaEndTime,
				Integer.valueOf(custId),
				checkMonth,
				teaBeginTime,
				teaEndTime});
		return custList;
	}
	
	private int getAssisCheckNum1(String custId,String checkDate,String teaBeginTime){
		StringBuffer sql = new StringBuffer(1024);
		sql.append("select count(*)as num from (")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial_record t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id where")
		.append(" t.cust_id=? and t.att_date=? and t.att_time<=?")
		.append(" union all")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id where")
		.append(" t.cust_id=? and t.att_date=? and t.att_time<=?)");
		int custList=jdbcTemplate.queryForInt(sql.toString(),
				new Object[]{
				Integer.valueOf(custId),
				checkDate,
				teaBeginTime,
				Integer.valueOf(custId),
				checkDate,
				teaBeginTime});
		return custList;
	}
	
	private int getAssisCheckNum2(String custId,String checkDate,String teaEndTime){
		StringBuffer sql = new StringBuffer(1024);
		sql.append("select count(*)as num from (")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial_record t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id where")
		.append(" t.cust_id=? and t.att_date=? and t.att_time>=?")
		.append(" union all")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id where")
		.append(" t.cust_id=? and t.att_date=? and t.att_time>=?)");
		int custList=jdbcTemplate.queryForInt(sql.toString(),
				new Object[]{
				Integer.valueOf(custId),
				checkDate,
				teaEndTime,
				Integer.valueOf(custId),
				checkDate,
				teaEndTime});
		return custList;
	}

	private int getLinkCheckNum(String custId,String checkDate,String linkTime){
		StringBuffer sql = new StringBuffer(1024);
		sql.append("select count(*)as num from (")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial_record t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id ")
		.append(" where t.cust_id=? and t.att_date=? and t.att_time>=?")
		.append(" union all")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id ")
		.append(" where t.cust_id=? and t.att_date=? and t.att_time>=?)");
		int custList=jdbcTemplate.queryForInt(sql.toString(),
				new Object[]{
				Integer.valueOf(custId),
				checkDate,
				linkTime,
				Integer.valueOf(custId),
				checkDate,
				linkTime});
		return custList;
	}
	
	/**
	 * 取得一个时间段内学生考勤记录
	 * @param custId
	 * @param checkDate
	 * @param bTime
	 * @param eTime
	 * @return
	 */
	private int getStuCheckRecord(String custId,String checkDate,String bTime,String eTime){
		StringBuffer sql = new StringBuffer(1024);
		sql.append("select count(*)as num from (")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial_record t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id ")
		.append(" where t.cust_id=? and t.att_date=? and t.att_time>=? and t.att_time<=?")
		.append(" union all")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id ")
		.append(" where t.cust_id=? and t.att_date=? and t.att_time>=? and t.att_time<=?)");
		int checkNum=jdbcTemplate.queryForInt(sql.toString(),
				new Object[]{
				Integer.valueOf(custId),
				checkDate,
				bTime,
				eTime,
				Integer.valueOf(custId),
				checkDate,
				bTime,
				eTime});
		return checkNum;
	}

	private int getStuCheckRecordLate(String custId,String checkDate,String bTime,String eTime){
		StringBuffer sql = new StringBuffer(1024);
		sql.append("select count(*)as num from (")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial_record t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id ")
		.append(" where t.cust_id=? and t.att_date=? and t.att_time>? and t.att_time<=?")
		.append(" union all")
		.append(" select t.cust_id,t.att_date,t.att_time from ykt_ck.t_attserial t")
		.append(" left join ykt_ck.t_clerkinfo info on t.cust_id = info.cust_id ")
		.append(" where t.cust_id=? and t.att_date=? and t.att_time>? and t.att_time<=?)");
		int checkNum=jdbcTemplate.queryForInt(sql.toString(),
				new Object[]{
				Integer.valueOf(custId),
				checkDate,
				bTime,
				eTime,
				Integer.valueOf(custId),
				checkDate,
				bTime,
				eTime});
		return checkNum;
	}
	/**
	 * 学生考勤记录
	 * @param checkInfoMap
	 * @param custId
	 * @param dayIter
	 * @param statMonth
	 * @param ifOffice
	 * @return
	 */
	private Map getYYStuCheckReportMap(
			Map checkInfoMap,
			String custId,
			String beginDate,
			String endDate){		
		PropertiesConfiguration config = GetPropertiesUtil.getInstance();
		String mbTime = config.getString("mBeginTime");
		String mmTime = config.getString("mMiddleTime");
		String meTime = config.getString("mEndTime");
		String ambTime = config.getString("amBeginTime");
		String ammTime = config.getString("amMiddleTime");
		String ameTime = config.getString("amEndTime");
		String pmbTime = config.getString("pmBeginTime");
		String pmmTime = config.getString("pmMiddleTime");
		String pmeTime = config.getString("pmEndTime");
		String nbTime = config.getString("nBeginTime");
		String neTime = config.getString("nendTime");
		
		int checkNum = 0; //正常刷卡
		int lateNum = 0;//迟到次数
		int leaveNum = 0;//缺席次数
		int earlyNum = 0;//早退次数
		String tempDate = beginDate;
		while (DateUtilExtend.diffDate(tempDate,endDate)>=0){
			//早
			if (getStuCheckRecord(custId,tempDate,mbTime,mmTime)>0){
				checkNum++;
				checkInfoMap.put("mo-"+tempDate,"√");
			}else if (getStuCheckRecordLate(custId,tempDate,mmTime,meTime)>0){
				lateNum++;
				checkInfoMap.put("mo-"+tempDate,"⊙");
			}else{
				leaveNum++;
				checkInfoMap.put("mo-"+tempDate,"x");
			}
			//上
			if (getStuCheckRecord(custId,tempDate,ambTime,ammTime)>0){
				checkNum++;
				checkInfoMap.put("am-"+tempDate,"√");
			}else if (getStuCheckRecordLate(custId,tempDate,ammTime,ameTime)>0){
				lateNum++;
				checkInfoMap.put("am-"+tempDate,"⊙");
			}else{
				leaveNum++;
				checkInfoMap.put("am-"+tempDate,"x");
			}
			
			//下
			if (getStuCheckRecord(custId,tempDate,pmbTime,pmmTime)>0){
				checkNum++;
				checkInfoMap.put("pm-"+tempDate,"√");
			}else if (getStuCheckRecordLate(custId,tempDate,pmmTime,pmeTime)>0){
				lateNum++;
				checkInfoMap.put("pm-"+tempDate,"⊙");
			}else{
				leaveNum++;
				checkInfoMap.put("pm-"+tempDate,"x");
			}
			
			//晚
			if (getStuCheckRecord(custId,tempDate,nbTime,neTime)>0){
				checkNum++;
				checkInfoMap.put("ni-"+tempDate,"√");
			}else{
				leaveNum++;
				checkInfoMap.put("ni-"+tempDate,"x");
			}			
			tempDate = DateUtilExtend.addDate2(tempDate.toString(),1);			
		}
		checkInfoMap.put("checkNum",new Integer(checkNum));
		checkInfoMap.put("lateNum",new Integer(lateNum));
		checkInfoMap.put("leaveNum",new Integer(leaveNum));
		checkInfoMap.put("earlyNum",new Integer(earlyNum));
		return checkInfoMap;
	}
	
	/**
	 * 生成学生考勤记录报表
	 * 20071031
	 */
	public List makeStuCheckReport(String beginDate,String endDate,String deptId)throws Exception{
		Iterator checkIter = sysService.getCheckClerkInfo(deptId,"9").iterator();
		List checkInfoList = new ArrayList(); 
		while (checkIter.hasNext()){
			Map checkMap = (Map)checkIter.next();
			Map checkInfoMap = new HashMap();
			//取得人员信息和考勤信息并放入到list中
			String ofOffice = oToString(checkMap.get("DICT_VALUE"));
			if ("9".equals(ofOffice)){
				String deptName = oToString(checkMap.get("dept_name"));
				String stuempNo = oToString(checkMap.get("stuemp_no"));
				String custId = oToString(checkMap.get("cust_id"));
				String custName = oToString(checkMap.get("cut_name"));
				String custType = oToString(checkMap.get("dict_caption"));
				//如果手工考勤里面有信息,半勤为⊙,全勤为√,未考勤为X
				checkInfoMap.put("deptName",deptName);
				checkInfoMap.put("stuempNo",stuempNo);
				checkInfoMap.put("custName",custName);
				checkInfoMap.put("custType",custType);
				checkInfoMap.put("custId",custId);
				//周统计考勤记录
				checkInfoMap = getYYStuCheckReportMap(checkInfoMap,custId,beginDate,endDate);
				checkInfoList.add(checkInfoMap);
			}
		}
		return checkInfoList;
	}
	
	private String oToString(Object in){
		if (null==in){
			return "";
		}else{
			return in.toString();
		}
	}
	
}
