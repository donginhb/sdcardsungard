package com.kingstargroup.fdykt.dao;

import org.apache.log4j.Logger;

import java.sql.*;
import java.util.*;

import com.kingstargroup.fdykt.KSConfiguration;
import com.kingstargroup.fdykt.KSConstant;
import com.kingstargroup.fdykt.dto.*;

public class DB2CardDAO extends DB2ActionDAO {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(DB2CardDAO.class);

	public CardDTO getCardInfo(String cardId) throws ClassNotFoundException,
			SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;
		ResultSet result = null;

		try {
			conn = getConnection();
			try {
				sql = "select * from YKT_CUR.T_PIF_CARD where Card_id="
						+ cardId;
				stm = conn.prepareStatement(sql);
				result = stm.executeQuery();
				result.next();
				CardDTO temp = new CardDTO();
				temp.setCardId(result.getString("Card_id"));
				temp.setCosumerId(result.getString("Cosumer_id"));
				temp.setStateId(result.getString("State_id"));
				temp.setPassword(result.getString("password"));
				return temp;
			} finally {
				if (stm != null) {
					stm.close();
				}
			}
		} catch (SQLException e1) {
			logger.error("读取卡信息失败[" + e1.getMessage() + "]卡号:" + cardId);
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}
	}  

	public CardDTO getCardInfoByIdPwd(String phisicalNo, String pwd)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;
		ResultSet result = null;

		try {
			conn = getConnection();
			sql = "select * from ykt_cur.T_PIF_Card card where card.physical_No='"
					+ phisicalNo
					+ "'"
					+ " and card.password='"
					+ pwd
					+ "'"
					+ " and state_id <> '2000' ";
			stm = conn.prepareStatement(sql);
			result = stm.executeQuery();

			if (result.next()) {
				CardDTO temp = new CardDTO();
				temp.setCardId(result.getString("Card_id"));
				temp.setCosumerId(result.getString("Cosumer_id"));
				temp.setStateId(result.getString("State_id"));
				return temp;
			}
			return null;
		} catch (SQLException e1) {
			logger.error("读取卡信息失败[" + e1.getMessage() + "]卡号:" + phisicalNo
					+ "密码[" + pwd + "]");
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}

	}

	public CardDTO getCardInfoById(String phisicalNo)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;
		ResultSet result = null;

		try {
			conn = getConnection();
			sql = "select * from ykt_cur.T_PIF_Card card where card.physical_No='"
					+ phisicalNo + "'" + " and state_id <> '2000' ";
			stm = conn.prepareStatement(sql);
			result = stm.executeQuery();

			if (result.next()) {
				CardDTO temp = new CardDTO();
				temp.setCardId(result.getString("Card_id"));
				temp.setCosumerId(result.getString("Cosumer_id"));
				temp.setStateId(result.getString("State_id"));
				return temp;
			}
			return null;
		} catch (SQLException e1) {
			logger.error("读取卡信息失败[" + e1.getMessage() + "]卡号:" + phisicalNo);
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}
	}

	public CardDTO getCardInfoByCardNo(String cardno)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;
		ResultSet result = null;

		try {
			String phisicalNo = Integer.toHexString(Integer.parseInt(cardno))
					.toUpperCase();
			for (int i = phisicalNo.length(); i < 8; i++) {
				phisicalNo = "0" + phisicalNo;// pad left
			}
			conn = getConnection();
			sql = "select * from ykt_cur.T_PIF_Card card where card.physical_No='"
					+ phisicalNo + "'" + " and state_id <> '2000' ";
			stm = conn.prepareStatement(sql);
			result = stm.executeQuery();

			if (result.next()) {
				CardDTO temp = new CardDTO();
				temp.setCardId(result.getString("Card_id"));
				temp.setCosumerId(result.getString("Cosumer_id"));
				temp.setStateId(result.getString("State_id"));
				return temp;
			}
			return null;
		} catch (SQLException e1) {
			// logger.error("读取卡信息失败[" + e1.getMessage() + "]卡号:" + phisicalNo);
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}
	}

	public String getEndDate() throws ClassNotFoundException, SQLException,
			Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;
		ResultSet result = null;

		try {
			conn = getConnection();
			sql = "Select value from YKT_CUR.T_PIF_CUR_SYSPARA where id=9";
			stm = conn.prepareStatement(sql);
			result = stm.executeQuery();
			result.next();
			String enddate;
			int v = result.getInt("value");
			Calendar now = Calendar.getInstance();
			now.add(Calendar.DATE, v);
			String year = (new Integer(now.get(Calendar.YEAR))).toString();
			String month = (new Integer(now.get(Calendar.MONTH) + 1))
					.toString();
			if (month.length() == 1) {
				month = "0" + month;
			}
			String day = (new Integer(now.get(Calendar.DATE))).toString();
			if (day.length() == 1) {
				day = "0" + day;
			}
			enddate = year + month + day;
			return enddate;
		} catch (SQLException e1) {
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}
	}

	public void createLossInfo(CardLossInfoDTO lossinfo)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;
		try {
			conn = getConnection();
			sql = "insert into YKT_CUR.T_PIF_CARDLOSSINFO values('"
					+ lossinfo.getOperateDate() + "','"
					+ lossinfo.getOperateTime() + "'," + lossinfo.getCardId()
					+ "," + lossinfo.getStateId() + ",'"
					+ lossinfo.getBeginDate() + "','" + lossinfo.getEndDate()
					+ "')";
			stm = conn.prepareStatement(sql);
			stm.execute();
		} catch (SQLException e1) {
			logger.error("挂失信息表写入失败,卡号[" + lossinfo.getCardId());
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}
	}

	public void createBlackSheet(BlackSheetDTO blacksheet)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;

		try {
			conn = getConnection();
			sql = "insert into    YKT_CUR.T_TIF_BLACK_SHEET (CARD_ID, VOLUME, VALIDDATE, STATE_ID, IS_AD, OPERATE_DATE, OPERATE_TIME,USEFLAG) values("
					+ blacksheet.getCardId() + ",'" + blacksheet.getVolume()
					+ "','" + blacksheet.getValiddate() + "',"
					+ blacksheet.getStateId() + "," + blacksheet.getIsAd()
					+ ",'" + blacksheet.getOperateDate() + "','"
					+ blacksheet.getOperateTime() + "',0)";
			logger.debug("create black sql [ " + sql + "]");
			stm = conn.prepareStatement(sql);
			stm.execute();
		} catch (SQLException e1) {
			logger.error("插入黑名单失败,卡号[" + blacksheet.getCardId() + "]"+e1.getMessage());
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}
	}

	private int getSequence(Connection conn, String sequenceTable)
			throws ClassNotFoundException, SQLException, Exception {
		Statement stm = null;
		ResultSet result = null;
		String sql = "select " + sequenceTable
				+ ".nextval mysequence from dual";
		stm = conn.createStatement();
		result = stm.executeQuery(sql);
		int ret = 0;
		if (result.next()) {
			ret = result.getInt("mysequence");
		}
		return ret;
	}

	public void createMesList(MesListDTO meslist)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		Statement stm = null;
		ResultSet result = null;
		Statement updateStm = null;
		try {
			// 获得数据库连接
			conn = getConnection();
			// 保存所有要广播的设备 ID
			try {
				ArrayList sysID = new ArrayList(1000);
				sql = "select system_id from YKT_CUR.T_PIF_SUBSYSTEM where "
						+ " system_type=12 and state=3";
				stm = conn.createStatement();
				result = stm.executeQuery(sql);
				while (result.next()) {
					sysID.add(result.getString("system_id"));
				}
				// 创建更新的 Statement
				updateStm = conn.createStatement();
				// 取得广播记录的主键
				Object[] systemIDAry = sysID.toArray();
				if (systemIDAry.length == 0) {
					return;
				}
				/*
				 * sql = "select key_value from YKT_CUR.T_PIF_SYSKEY where " + "
				 * key_code='T_TIF_MESLIST'"; ResultSet temp =
				 * stm.executeQuery(sql); int currMesID = 0; if (temp.next()) {
				 * currMesID = temp.getInt("key_value"); // 更新广播记录主键的当前值 sql =
				 * "update YKT_CUR.T_PIF_SYSKEY set key_value=" + (currMesID +
				 * systemIDAry.length) + " where key_code='T_TIF_MESLIST'";
				 * stm.executeUpdate(sql); } else { throw new SQLException("No
				 * primary key generate!"); }
				 */
				// 为所有设备增加广播记录
				int sequence = 0;
				for (int i = 0; i < systemIDAry.length; ++i) {

					meslist.setDeviceId((String) systemIDAry[i]);
					StringBuffer sqlBuf = new StringBuffer(1024);
					String database = KSConfiguration.getInstance()
							.getProperty("database", "db2");
					if ("db2".equalsIgnoreCase(database)) {
						sqlBuf
								.append(
										"insert into YKT_CUR.T_TIF_MESLIST(funid,stateid")
								.append(
										",sendcount,level,device_id,indt,startdt,enddt")
								.append(
										",ecode,emsg,incontent,outcontent,pfunid,max_send_cnt)values(")
								.append(meslist.getFunId()).append(",").append(
										meslist.getStateId()).append(",0,")
								.append(meslist.getLevel()).append(",").append(
										meslist.getDeviceId()).append(",'")
								.append(meslist.getIndt()).append("','','',")
								.append(meslist.getEcode()).append(",'','")
								.append(meslist.getIncontent()).append(
										"','',0,100)");
					} else if ("oracle".equalsIgnoreCase(database)) {
						sequence = getSequence(conn, "ykt_cur.S_T_TIF_MESLIST");
						sqlBuf
								.append(
										"insert into YKT_CUR.T_TIF_MESLIST(mesid,funid,stateid")
								.append(
										",sendcount,\"LEVEL\",device_id,devid,indt,startdt,enddt")
								.append(
										",ecode,emsg,incontent,outcontent,pfunid,max_send_cnt)values(")
								.append(sequence).append(",").append(
										meslist.getFunId()).append(",").append(
										meslist.getStateId()).append(",0,")
								.append(meslist.getLevel()).append(",").append(
										meslist.getDeviceId()).append(",0,'")
								.append(meslist.getIndt()).append("','','',")
								.append(meslist.getEcode()).append(",'','")
								.append(meslist.getIncontent()).append(
										"','',0,100)");
					}

					// logger.error("sql [" + sqlBuf.toString() + "]");
					updateStm.addBatch(sqlBuf.toString());
				}
				// 批量插入记录
				updateStm.executeBatch();
			} finally {
				if (updateStm != null) {
					updateStm.close();
				}
				if (stm != null) {
					stm.close();
				}
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
			logger.error("挂失插入消息队列失败");
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (updateStm != null) {
				updateStm.close();
			}
			if (stm != null) {
				stm.close();
			}
		}
	}

	public void updateCardState(String cardId, String state_id)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;

		try {
			conn = getConnection();
			sql = "update YKT_CUR.T_PIF_CARD set state_id='" + state_id
					+ "' where card_id=" + cardId;
			stm = conn.prepareStatement(sql);
			stm.executeUpdate();
		} catch (SQLException e1) {
			logger.error("更新卡状态失败,卡号[" + cardId + "]state[" + state_id + "]");
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}
	}

	public void updateCardPassword(String physicalNo, String password)
			throws Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;

		try {
			conn = getConnection();
			sql = "update ykt_cur.t_pif_card set password='" + password
					+ "' where physical_No='" + physicalNo + "'"
					+ " and state_id <> '2000' ";
			// logger.debug("sql[" + sql + "]");
			stm = conn.prepareStatement(sql);
			stm.executeUpdate();
		} catch (SQLException el) {
			logger.error("修改密码失败,physicalNo[" + physicalNo + "]");
			el.printStackTrace();
			throw (el);
		} finally {
			if (stm != null)
				stm.close();
		}
	}

	public void updateCardPassword(int cardId, String password)
			throws Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;

		try {
			conn = getConnection();
			sql = "update ykt_cur.t_pif_card set password='" + password
					+ "' where card_id=" + cardId + " and state_id <> '2000' ";
			// logger.debug("sql[" + sql + "]");
			stm = conn.prepareStatement(sql);
			stm.executeUpdate();
		} catch (SQLException el) {
			logger.error("修改密码失败,cardId[" + cardId + "]");
			// conn.rollback();
			el.printStackTrace();
			throw (el);
		} finally {
			if (stm != null)
				stm.close();
		}
	}

	public void updateLossState(String sysdate, String cardid)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;

		try {
			conn = getConnection();
			sql = "update ykt_cur.t_pif_cardlossinfo set state_id = 2, end_date = '"
					+ sysdate + "' where state_id = 1 and card_id=" + cardid;
			stm = conn.prepareStatement(sql);
			stm.executeUpdate();
		} catch (SQLException e1) {
			logger.error("更新卡挂失表失败,cardno[" + cardid + "]");
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}
	}

	public int isCancel(String cutid, String cardid)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;
		ResultSet result = null;

		try {
			conn = getConnection();
			// 还有正常卡(写卡失败的卡)
			sql = "select type_id from YKT_CUR.T_PIF_CARD where COSUMER_ID="
					+ cutid + " and (state_id='" + KSConstant.CARDSTAT_NORMAL
					+ "' or state_id='" + KSConstant.CARDSTAT_WFAIL + "') "
					+ " and card_id<>" + cardid;
			stm = conn.prepareStatement(sql);
			result = stm.executeQuery();
			if (result.next()) {
				/*
				 * int type = result.getInt("type_id"); if (type ==
				 * KSConstant.CARDTYPE_MAIN) { return
				 * KSConstant.MAINCARD_UNLOSSED; // 该客户正式卡未挂失,不能办临时卡 } else {
				 * return KSConstant.TEMPCARD_EXISTS; // 该客户有一张临时卡可正常使用,不能再办临时卡 }
				 */
				return KSConstant.MAINCARD_UNLOSSED;
			} else {
				return 0; //
			}
		} catch (SQLException e1) {
			logger.error("查询卡状态失败,custid[" + cutid + "]");
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}
	}

	public CardDTO getCardState(String phisicalNo)
			throws ClassNotFoundException, SQLException, Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement stm = null;
		ResultSet result = null;

		try {
			conn = getConnection();
			sql = "select * from ykt_cur.T_PIF_Card card where card.physical_No='"
					+ phisicalNo + "' and  state_id <> '2000' ";
			stm = conn.prepareStatement(sql);
			result = stm.executeQuery();

			if (result.next()) {
				CardDTO temp = new CardDTO();
				temp.setCardId(result.getString("Card_id"));
				temp.setCosumerId(result.getString("Cosumer_id"));
				temp.setStateId(result.getString("State_id"));
				return temp;
			}
			return null;
		} catch (SQLException e1) {
			logger.error("读取卡信息失败[" + e1.getMessage() + "]卡号:" + phisicalNo);
			throw (e1);
		} catch (Exception e) {
			e.printStackTrace();
			throw (e);
		} finally {
			if (stm != null) {
				stm.close();
			}
		}

	}
}
