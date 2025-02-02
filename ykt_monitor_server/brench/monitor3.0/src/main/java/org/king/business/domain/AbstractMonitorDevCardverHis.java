package org.king.business.domain;

/**
 * AbstractMonitorDevCardverHis entity provides the base persistence definition
 * of the MonitorDevCardverHis entity. @author MyEclipse Persistence Tools
 */

public abstract class AbstractMonitorDevCardverHis extends
		org.king.framework.domain.BaseObject implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer deviceid;
	private String cardvarno;
	private String entertime;
	private String lastupdate;
	private Integer lasttime;
	private String lattestverno;

	// Constructors

	/** default constructor */
	public AbstractMonitorDevCardverHis() {
	}

	/** full constructor */
	public AbstractMonitorDevCardverHis(Integer deviceid, String cardvarno,
			String entertime, String lastupdate, Integer lasttime,
			String lattestverno) {
		this.deviceid = deviceid;
		this.cardvarno = cardvarno;
		this.entertime = entertime;
		this.lastupdate = lastupdate;
		this.lasttime = lasttime;
		this.lattestverno = lattestverno;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getDeviceid() {
		return this.deviceid;
	}

	public void setDeviceid(Integer deviceid) {
		this.deviceid = deviceid;
	}

	public String getCardvarno() {
		return this.cardvarno;
	}

	public void setCardvarno(String cardvarno) {
		this.cardvarno = cardvarno;
	}

	public String getEntertime() {
		return this.entertime;
	}

	public void setEntertime(String entertime) {
		this.entertime = entertime;
	}

	public String getLastupdate() {
		return this.lastupdate;
	}

	public void setLastupdate(String lastupdate) {
		this.lastupdate = lastupdate;
	}

	public Integer getLasttime() {
		return this.lasttime;
	}

	public void setLasttime(Integer lasttime) {
		this.lasttime = lasttime;
	}

	public String getLattestverno() {
		return this.lattestverno;
	}

	public void setLattestverno(String lattestverno) {
		this.lattestverno = lattestverno;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 0;
		result = prime * result
				+ ((cardvarno == null) ? 0 : cardvarno.hashCode());
		result = prime * result
				+ ((deviceid == null) ? 0 : deviceid.hashCode());
		result = prime * result
				+ ((entertime == null) ? 0 : entertime.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((lasttime == null) ? 0 : lasttime.hashCode());
		result = prime * result
				+ ((lastupdate == null) ? 0 : lastupdate.hashCode());
		result = prime * result
				+ ((lattestverno == null) ? 0 : lattestverno.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		AbstractMonitorDevCardverHis other = (AbstractMonitorDevCardverHis) obj;
		if (cardvarno == null) {
			if (other.cardvarno != null)
				return false;
		} else if (!cardvarno.equals(other.cardvarno))
			return false;
		if (deviceid == null) {
			if (other.deviceid != null)
				return false;
		} else if (!deviceid.equals(other.deviceid))
			return false;
		if (entertime == null) {
			if (other.entertime != null)
				return false;
		} else if (!entertime.equals(other.entertime))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (lasttime == null) {
			if (other.lasttime != null)
				return false;
		} else if (!lasttime.equals(other.lasttime))
			return false;
		if (lastupdate == null) {
			if (other.lastupdate != null)
				return false;
		} else if (!lastupdate.equals(other.lastupdate))
			return false;
		if (lattestverno == null) {
			if (other.lattestverno != null)
				return false;
		} else if (!lattestverno.equals(other.lattestverno))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "AbstractMonitorDevCardverHis [cardvarno=" + cardvarno
				+ ", deviceid=" + deviceid + ", entertime=" + entertime
				+ ", id=" + id + ", lasttime=" + lasttime + ", lastupdate="
				+ lastupdate + ", lattestverno=" + lattestverno + "]";
	}
}