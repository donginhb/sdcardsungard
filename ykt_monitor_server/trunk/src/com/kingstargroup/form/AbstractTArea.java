package com.kingstargroup.form;

/**
 * AbstractTArea entity provides the base persistence definition of the TArea
 * entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public abstract class AbstractTArea implements java.io.Serializable {

	// Fields

	private String areacode;
	private String areaname;
	private String fareacode;
	private long arealevel;
	private String addr;
	private String remark;

	// Constructors

	/** default constructor */
	public AbstractTArea() {
	}

	/** minimal constructor */
	public AbstractTArea(String areacode) {
		this.areacode = areacode;
	}

	/** full constructor */
	public AbstractTArea(String areacode, String areaname, String fareacode,
			long arealevel, String addr, String remark) {
		this.areacode = areacode;
		this.areaname = areaname;
		this.fareacode = fareacode;
		this.arealevel = arealevel;
		this.addr = addr;
		this.remark = remark;
	}

	// Property accessors

	public String getAreacode() {
		return this.areacode;
	}

	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}

	public String getAreaname() {
		return this.areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public String getFareacode() {
		return this.fareacode;
	}

	public void setFareacode(String fareacode) {
		this.fareacode = fareacode;
	}

	public long getArealevel() {
		return this.arealevel;
	}

	public void setArealevel(long arealevel) {
		this.arealevel = arealevel;
	}

	public String getAddr() {
		return this.addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}