/**
 * Copyright (C), 2000-2006, Kingstar Co., Ltd.<br>
 * File name: .java<br>
 * Description: TradeSerialDAO取得某个账号消费明细<br>
 * Return: List<br>
 * Modify History: <br>
 * 操作类型    操作人     操作时间       操作内容<br>
 * ======================================<br>
 *  创建      韩纪伟     2006-5-10  <br>
 * @author 韩纪伟
 * @version
 * @since 1.0
 */
package com.kingstargroup.advquery.hibernate.dao;

import java.util.Iterator;
import java.util.List;

import com.kingstargroup.advquery.util.Utility;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import com.kingstargroup.advquery.customer.TCifCustomer;
import com.kingstargroup.advquery.hibernate.HibernateSessionFactory;

public class AccountDAO extends BasicDAO {
    /**
     * Description:singleton pattern
     *
     * @return Modify History:
     */
    public static AccountDAO getInstance() {
        if (_instance == null) {
            _instance = new AccountDAO();
        }
        return _instance;
    }

    public List getHandTrade(String stuempno,String beginDate, String endDate, String tradedevice, String tradecard, String tradelogno) throws HibernateException {
        Session s = getSession();
        StringBuffer sqlStr = new StringBuffer();
        sqlStr.append("select t.*\n" +
                "  from ((select bak_date,\n" +
                "                bak_time,\n" +
                "                serial_no,\n" +
                "                other_seri_no,\n" +
                "                serial_type,\n" +
                "                serial_state,\n" +
                "                operate_date,\n" +
                "                operate_time,\n" +
                "                collect_date,\n" +
                "                collect_time,\n" +
                "                enteract_date,\n" +
                "                enteract_time,\n" +
                "                maindevice_id,\n" +
                "                device_id,\n" +
                "                devphy999_id,\n" +
                "                showid,\n" +
                "                card_id,\n" +
                "                purse_id,\n" +
                "                trade_count,\n" +
                "                trade_fee,\n" +
                "                in_balance,\n" +
                "                out_balance,\n" +
                "                deposit_fee,\n" +
                "                in_fee,\n" +
                "                cost_fee,\n" +
                "                boardfee,\n" +
                "                customer_id,\n" +
                "                oper_code,\n" +
                "                out_account_id,\n" +
                "                in_account_id,\n" +
                "                b_act_id,\n" +
                "                sys_id,\n" +
                "                tmark,\n" +
                "                ecode,\n" +
                "                reviseserial_no,\n" +
                "                comu_ver,\n" +
                "                b.STUEMP_NO,\n" +
                "                b.cut_name,\n" +
                "                b.CUT_TYPE\n" +
                "           from ykt_his.t_tif_tradeserial_his a\n" +
                "           left join ykt_cur.t_cif_customer b on a.customer_id = b.cut_id\n" +
                "          where operate_date >= '" + beginDate + "'\n" +
                "            and operate_date <= '" + endDate + "') union all\n" +
                "        (select '' bak_date,\n" +
                "                '' bak_time,\n" +
                "                serial_no,\n" +
                "                other_seri_no,\n" +
                "                serial_type,\n" +
                "                serial_state,\n" +
                "                operate_date,\n" +
                "                operate_time,\n" +
                "                collect_date,\n" +
                "                collect_time,\n" +
                "                enteract_date,\n" +
                "                enteract_time,\n" +
                "                maindevice_id,\n" +
                "                device_id,\n" +
                "                devphy999_id,\n" +
                "                showid,\n" +
                "                card_id,\n" +
                "                purse_id,\n" +
                "                trade_count,\n" +
                "                trade_fee,\n" +
                "                in_balance,\n" +
                "                out_balance,\n" +
                "                deposit_fee,\n" +
                "                in_fee,\n" +
                "                cost_fee,\n" +
                "                boardfee,\n" +
                "                customer_id,\n" +
                "                oper_code,\n" +
                "                out_account_id,\n" +
                "                in_account_id,\n" +
                "                b_act_id,\n" +
                "                sys_id,\n" +
                "                tmark,\n" +
                "                ecode,\n" +
                "                reviseserial_no,\n" +
                "                comu_ver,\n" +
                "                b.STUEMP_NO,\n" +
                "                b.cut_name,\n" +
                "                b.CUT_TYPE\n" +
                "           from ykt_cur.t_tif_tradeserial a\n" +
                "           left join ykt_cur.t_cif_customer b on a.customer_id = b.cut_id\n" +
                "          where operate_date >= '" + beginDate + "'\n" +
                "            and operate_date <= '" + endDate + "')) t ");
        sqlStr.append(" where 1=1 and trade_fee=0 and device_id in (select device_id from t_pif_device where devtype=1055) ");
        if(!Utility.isEmpty(stuempno)){
            sqlStr.append(" and stuemp_no='" +stuempno+ "'");
        }
        if(!Utility.isEmpty(tradedevice)){
            sqlStr.append(" and devphy999_id='" +tradedevice.toUpperCase()+ "'");
        }
        if(!Utility.isEmpty(tradecard)){
            sqlStr.append(" and card_id=" +tradecard+ "");
        }
        if(!Utility.isEmpty(tradelogno)){
            sqlStr.append(" and serial_no=" +tradelogno );
        }

        sqlStr.append(" order by operate_date desc, operate_time desc");
        try {
            SQLQuery q = s.createSQLQuery(sqlStr.toString());
            q.addScalar("serial_no", Hibernate.STRING);
            q.addScalar("STUEMP_NO", Hibernate.STRING);
            q.addScalar("cut_name", Hibernate.STRING);
            q.addScalar("card_id", Hibernate.STRING);
            q.addScalar("operate_date", Hibernate.STRING);
            q.addScalar("operate_time", Hibernate.STRING);
            q.addScalar("collect_date", Hibernate.STRING);
            q.addScalar("collect_time", Hibernate.STRING);
            q.addScalar("enteract_date", Hibernate.STRING);
            q.addScalar("enteract_time", Hibernate.STRING);
            q.addScalar("devphy999_id", Hibernate.STRING);
            _log.debug(q.getQueryString());
            return q.list();
        } catch (HibernateException he) {
            _log.error(he);
            return null;
        }
    }

    public List getOneAccountDetail(String custNo, String beginDate, String endDate) throws HibernateException {
        Session s = getSession();
        StringBuffer sqlStr = new StringBuffer();
        sqlStr.append("select log.OPERATE_DATE, log.OPERATE_TIME, log.DEVICE_ID, log.RECORD_OPER,log.COMMENTS,log.OP_FEE")
                .append(" from YKT_CUR.T_TIF_TRADELOG log,YKT_CUR.T_AIF_ACCOUNT acc ,YKT_CUR.T_CIF_CUSTOMER cust")
                .append(" where log.ACT_ID=acc.ACCOUNT_ID and acc.CUSTOMER_ID=cust.CUT_ID and")
                .append(" OPERATE_DATE>=:begindate and OPERATE_DATE <=:enddate and cust.CUT_ID=:custno ")
                .append(" union all")
                .append(" select log.OPERATE_DATE, log.OPERATE_TIME, log.DEVICE_ID, log.RECORD_OPER,log.COMMENTS,log.OP_FEE")
                .append(" from YKT_HIS.T_TIF_TRADELOG_HIS log,YKT_CUR.T_AIF_ACCOUNT acc ,YKT_CUR.T_CIF_CUSTOMER cust")
                .append(" where log.ACT_ID=acc.ACCOUNT_ID and acc.CUSTOMER_ID=cust.CUT_ID and ")
                .append(" log.BAK_DATE>=:begindate and log.BAK_DATE <=:enddate and cust.CUT_ID=:custno ");

        try {
            SQLQuery q = s.createSQLQuery(sqlStr.toString());
            q.addScalar("OPERATE_DATE", Hibernate.STRING);
            q.addScalar("OPERATE_TIME", Hibernate.STRING);
            q.addScalar("DEVICE_ID", Hibernate.INTEGER);
            q.addScalar("RECORD_OPER", Hibernate.STRING);
            q.addScalar("COMMENTS", Hibernate.STRING);
            q.addScalar("OP_FEE", Hibernate.FLOAT);
            q.setString("begindate", beginDate);
            q.setString("enddate", endDate);
            q.setString("custno", custNo);
            return q.list();
        } catch (HibernateException he) {
            _log.error(he);
            return null;
        }
    }

    public String getDevNameByDevId(int devid) throws HibernateException {
        Session s = getSession();
        String devname = "";
        try {
            if (0 != devid) {

                String sqlString = " select  device_name from ykt_cur.t_pif_device where device_id=:devid ";
                SQLQuery q = s.createSQLQuery(sqlString.toString());
                q.setInteger("devid", devid);
                q.addScalar("device_name", Hibernate.STRING);
                List list = q.list();
                if (list != null && list.size() > 0) {
                    devname = list.get(0).toString();
                }
                return devname;
            } else {
                return "";
            }
        } catch (HibernateException he) {
            _log.error(he);
            return null;
        }
    }

    public String getCustIdBystuempNo(String stuempNo) {
        String custId = "";
        Session session = HibernateSessionFactory.currentSession();
        try {
            Query query = session.createQuery(" from TCifCustomer where stuempNo = :stuempNo");
            query.setString("stuempNo", stuempNo);
            List list = query.list();
            Iterator iter = list.iterator();
            while (iter.hasNext()) {
                TCifCustomer row = (TCifCustomer) iter.next();
                custId = row.getCutId().toString();
                break;
            }
            return custId;
        } catch (HibernateException e) {
            _log.error(e);
            return custId;
        } finally {
            HibernateSessionFactory.closeSession();
        }
    }

    private static AccountDAO _instance;
    private static Log _log = LogFactory.getLog(AccountDAO.class.getClass());
}