package com.kingstargroup.fdykt.cardcard;

import java.sql.SQLException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessages;

import com.kingstar.bcc.bccclt;
import com.kingstargroup.fdykt.BccctlInit;
import com.kingstargroup.fdykt.KSConfiguration;
import com.kingstargroup.fdykt.dao.DB2AccountDAO;
import com.kingstargroup.fdykt.dao.DB2CardDAO;
import com.kingstargroup.fdykt.dao.KSDaoSessionFactory;
import com.kingstargroup.fdykt.dto.CardDTO;
import com.kingstargroup.fdykt.util.BccUtil;
import com.kingstargroup.fdykt.util.DateUtil;

public class CardCardCheckAction extends Action {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(CardCardCheckAction.class);

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		KSDaoSessionFactory.createSession();
		ActionForward forward = docheck(mapping, form, request, response);
		try {
			KSDaoSessionFactory.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return forward;
	}

	private ActionForward docheck(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {

		DB2CardDAO carddao = new DB2CardDAO();
		DB2AccountDAO accdao = new DB2AccountDAO();
//		HttpSession session = request.getSession(false);
		
		String money = request.getParameter("money");
		String cardphyno = request.getParameter("cardphyno");
		String cardbalance = request.getParameter("cardbalance");
		String cardcnt = request.getParameter("cardcnt");
		String outcardphyno = request.getParameter("outcardphyno");
		String outcardbalance = request.getParameter("outcardbalance");
		String outcardcnt = request.getParameter("outcardcnt");

		request.setAttribute("money", money);
		request.setAttribute("cardphyno", cardphyno);
		request.setAttribute("cardbalance", cardbalance);
		request.setAttribute("cardcnt", cardcnt);
		request.setAttribute("outcardphyno", outcardphyno);
		request.setAttribute("outcardbalance", outcardbalance);
		request.setAttribute("outcardcnt", outcardcnt);
		String ipServer = KSConfiguration.getInstance().getProperty("drtpip1",
		"172.0.0.1");
		String drtpPort = KSConfiguration.getInstance().getProperty(
				"drtpport1", "4000");
		String svrFunc = KSConfiguration.getInstance().getProperty(
				"mainfunction1", "6000");
		
		request.setAttribute("ipServer", ipServer);
		request.setAttribute("drtpPort", drtpPort);
		request.setAttribute("svrFunc", svrFunc);


		ActionErrors errors = new ActionErrors();
		CardDTO card = new CardDTO();
		CardDTO outcard = new CardDTO();
		try {
			card = carddao.getCardInfoById(cardphyno);
			outcard = carddao.getCardInfoById(outcardphyno);
		} catch (Exception e) {
			// TODO: handle exception
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"back.error", "卡信息读取失败"));
			saveErrors(request, errors);
			return mapping.findForward("failure");
		}
		String reqip = request.getRemoteAddr();
		// reqip = "10.49.188.50";
		int deviceid = -2;
		try {
			deviceid = accdao.getdevidFromip(reqip);
			if (deviceid < 0) {
				errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
						"deviceid.notregister"));
				saveErrors(request, errors);
				return mapping.findForward("failure");
			}
		} catch (Exception e1) {
			e1.printStackTrace();
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"deviceid.notregister"));
			saveErrors(request, errors);
			return mapping.findForward("failure");
		}

		long xpackhandle = 0;
		int drtpno = 0;
		int errcode[] = { 1 };
		byte errmsg[] = new byte[300];
		int branchno = 0;// 后台drtp功能号
		int mainfunction = KSConfiguration.getInstance().getPropertyAsInt(
				"mainfunction1", 9000);
		int func = KSConfiguration.getInstance().getPropertyAsInt(
				"logicfunc_cardcard_check", 846328);// 后台业务功能号
		int tries = KSConfiguration.getInstance().getPropertyAsInt("tries", 3);// 默认重试次数
		int[] RetCode = new int[1];
		int[] RecordCount = new int[1];
		bccclt bcc = null;
		try {
			bcc = BccctlInit.getBccctlInstance();
			xpackhandle = bcc.NewXpackHandle(KSConfiguration.getInstance()
					.getProperty("cpackfile", "/opt/cpack.dat").getBytes());
			if (0 != xpackhandle) {
				bcc.SetRequestType(xpackhandle, func);
				bcc.SetStringFieldByName(xpackhandle, 0, "lwithdraw_flag"
						.getBytes(), String.valueOf(deviceid).getBytes());// 终端号
				bcc.SetIntFieldByName(xpackhandle, 0, "lbank_acc_type"
						.getBytes(), 1);// 交易标志

				bcc.SetStringFieldByName(xpackhandle, 0, "scust_auth"
						.getBytes(), DateUtil.getNow().getBytes());// 发送方凭证号

				bcc.SetStringFieldByName(xpackhandle, 0,
						"sstation1".getBytes(), cardphyno.getBytes());// 物理卡号

				bcc.SetIntFieldByName(xpackhandle, 0, "lvol0".getBytes(),
						Integer.parseInt(String.valueOf(card.getCardno())));// 卡号
				bcc.SetIntFieldByName(xpackhandle, 0, "lvol6".getBytes(),
						Integer.parseInt(cardcnt));// 交易次数
				bcc.SetIntFieldByName(xpackhandle, 0, "lvol7".getBytes(),
						Integer.parseInt(cardbalance));// 卡交易前余额(分)
				
				bcc.SetIntFieldByName(xpackhandle, 0, "lvol2".getBytes(),
						Integer.parseInt(String.valueOf(outcard.getCardno())));// 卡号
				bcc.SetIntFieldByName(xpackhandle, 0, "lvol3".getBytes(),
						Integer.parseInt(outcardcnt));// 交易次数
				bcc.SetIntFieldByName(xpackhandle, 0, "lsafe_level".getBytes(),
						Integer.parseInt(outcardbalance));// 卡交易前余额(分)
				
				
				bcc.SetIntFieldByName(xpackhandle, 0, "lvol1".getBytes(),
						(int)(Double.parseDouble(money)*100));// 转账金额(分)

				boolean bccret = false;
				bccret = bcc.CallRequest(xpackhandle, drtpno, branchno,
						mainfunction, 10000, errcode, errmsg);

				if (bccret) {
					bcc.GetRetCode(xpackhandle, RetCode);
					bcc.GetRecordCount(xpackhandle, RecordCount);
					if (0 == RetCode[0]) {
						if (0 < RecordCount[0]) {
							byte[] inStr = new byte[300];
							int[] intRec = new int[1];

							Arrays.fill(intRec, 0);
							bcc.GetIntFieldByName(xpackhandle, 0, "lserial1"
									.getBytes(), intRec);// 流水号
							String serial_no = String.valueOf(intRec[0]);

							Arrays.fill(intRec, 0);
							bcc.GetIntFieldByName(xpackhandle, 0, "lvol8"
									.getBytes(), intRec);// 余额（分）
							String card_amount = String.valueOf(intRec[0]);
							
							Arrays.fill(intRec, 0);
							bcc.GetIntFieldByName(xpackhandle, 0, "lsafe_level2"
									.getBytes(), intRec);// 余额（分）
							String out_card_amount = String.valueOf(intRec[0]);

							Arrays.fill(inStr, (byte) 0);
							bcc.GetStringFieldByName(xpackhandle, 0, "sdate3"
									.getBytes(), inStr, 300);
							String sdate3 = BccUtil.getStringFromByte(inStr);
							
							Arrays.fill(inStr, (byte) 0);
							bcc.GetStringFieldByName(xpackhandle, 0, "stime3"
									.getBytes(), inStr, 300);
							String stime3 = BccUtil.getStringFromByte(inStr);
							
							
							Arrays.fill(inStr, (byte) 0);
							bcc.GetStringFieldByName(xpackhandle, 0, "sphone3"
									.getBytes(), inStr, 300);
							String sphone3 = BccUtil.getStringFromByte(inStr);
							
							Arrays.fill(inStr, (byte) 0);
							bcc.GetStringFieldByName(xpackhandle, 0, "saddr"
									.getBytes(), inStr, 300);
							String saddr = BccUtil.getStringFromByte(inStr);

							request.setAttribute("serialNo", serial_no);
							request.setAttribute("sphone3", sphone3);
							request.setAttribute("sdate3", sdate3);
							request.setAttribute("stime3", stime3);
							request.setAttribute("saddr", saddr);
							request.setAttribute("cardAmount",card_amount);
							request.setAttribute("outcardAmount",
									out_card_amount);
							logger.info("卡卡转账模拟入账成功,物理卡号：" + cardphyno + "，入账日期：" + sphone3 + "，流水号："
									+ serial_no + ",转出卡出卡值：" + card_amount
									+ "分");
							return mapping.findForward("success");
						} else {

							logger.info("卡卡转账模拟入账失败,后台处理失败,物理卡号：" + cardphyno);
							errors.add(ActionMessages.GLOBAL_MESSAGE,
									new ActionError("back.error", "后台处理失败"));
							saveErrors(request, errors);
							return mapping.findForward("failure");
						}

					} else {
						// 失败
						if (0 < RecordCount[0]) {
							byte[] vsmess = new byte[300];
							bcc.GetStringFieldByName(xpackhandle, 0, "vsmess"
									.getBytes(), vsmess, 300);
							String vs_mess = BccUtil.getStringFromByte(vsmess);
							errors.add(ActionMessages.GLOBAL_MESSAGE,
									new ActionError("back.error", vs_mess));
							saveErrors(request, errors);

							logger.info("卡卡转账模拟入账失败,后台处理失败,物理卡号：" + cardphyno + "返回错误信息："
									+ vs_mess);
							return mapping.findForward("failure");
						} else {

							errors.add(ActionMessages.GLOBAL_MESSAGE,
									new ActionError("back.error", "后台处理失败"));
							saveErrors(request, errors);
							logger.info("卡卡转账模拟入账失败,后台处理失败,物理卡号：" + cardphyno+ "返回错误信息：无");
							return mapping.findForward("failure");
						}

					}

				} else {
					// 请求失败

					String err_msg = BccUtil.getStringFromByte(errmsg);
					logger.info("模拟入账失败,后台处理失败,物理卡号：" + cardphyno + "connect:errcode=" + errcode[0]
							+ "msg=" + err_msg);
					errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
							"back.error", "后台通讯暂时不可用，请稍后重试！ " + err_msg));
					saveErrors(request, errors);
					return mapping.findForward("failure");
				}
			}
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"back.error", "系统出现异常，请稍后重试！"));
			saveErrors(request, errors);
			return mapping.findForward("failure");

		} catch (Exception e) {
			// TODO: handle exception
			logger.error(e.getMessage());
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"back.error", "系统出现异常，请稍后重试！"));
			saveErrors(request, errors);
			return mapping.findForward("failure");
		} catch (UnsatisfiedLinkError e) {
			logger.error(e.getMessage());
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"back.error", "系统出现异常，请稍后重试！"));
			saveErrors(request, errors);
			return mapping.findForward("failure");
		} finally {
			if (xpackhandle != 0) {
				bcc.DeleteXpackHandle(xpackhandle);
			}
		}
		
		
		
		/**
		 * 
		 */
//		request.setAttribute("serialNo", "1234567");
//		request.setAttribute("sdate3", "20100317");
//		request.setAttribute("outCardAmount",String.valueOf(Integer.parseInt(cardBala)*100-Integer.parseInt(money)*100));
//		return mapping.findForward("success");

	}
}
