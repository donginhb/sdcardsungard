package org.king.checkinmanage.domain;

import java.sql.Timestamp;
import java.util.Date;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;


/**
 * AbstractStucheckininfo generated by MyEclipse - Hibernate Tools
 */

public abstract class AbstractStucheckininfo extends org.king.framework.domain.BaseObject implements java.io.Serializable {


    // Fields    

     private String id;
     private String studentNo;
     private String enrollNo;
     private String enrollYear;
     private String ifCheckedin;
     private String reason;
     private String ifChecked;
     private String ifReserve;
     private String ifLeaveSchool;
     private String ifGotMaterial;
     private String ifGotEcard;
     private String ifGotStucard;
     private String memo;
     private String ifSubmitted;
     private String updatorId;
     private Timestamp updateTime;


    // Constructors

    /** default constructor */
    public AbstractStucheckininfo() {
    }

	/** minimal constructor */
    public AbstractStucheckininfo(String studentNo, String enrollNo, String enrollYear, String ifCheckedin, String ifChecked, String ifReserve, String ifLeaveSchool, String ifGotMaterial, String ifGotEcard, String ifGotStucard, String ifSubmitted) {
        this.studentNo = studentNo;
        this.enrollNo = enrollNo;
        this.enrollYear = enrollYear;
        this.ifCheckedin = ifCheckedin;
        this.ifChecked = ifChecked;
        this.ifReserve = ifReserve;
        this.ifLeaveSchool = ifLeaveSchool;
        this.ifGotMaterial = ifGotMaterial;
        this.ifGotEcard = ifGotEcard;
        this.ifGotStucard = ifGotStucard;
        this.ifSubmitted = ifSubmitted;
    }
    
    /** full constructor */
    public AbstractStucheckininfo(String studentNo, String enrollNo, String enrollYear, String ifCheckedin, String reason, String ifChecked, String ifReserve, String ifLeaveSchool, String ifGotMaterial, String ifGotEcard, String ifGotStucard, String memo, String ifSubmitted, String updatorId, Timestamp updateTime) {
        this.studentNo = studentNo;
        this.enrollNo = enrollNo;
        this.enrollYear = enrollYear;
        this.ifCheckedin = ifCheckedin;
        this.reason = reason;
        this.ifChecked = ifChecked;
        this.ifReserve = ifReserve;
        this.ifLeaveSchool = ifLeaveSchool;
        this.ifGotMaterial = ifGotMaterial;
        this.ifGotEcard = ifGotEcard;
        this.ifGotStucard = ifGotStucard;
        this.memo = memo;
        this.ifSubmitted = ifSubmitted;
        this.updatorId = updatorId;
        this.updateTime = updateTime;
    }

   
    // Property accessors

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getStudentNo() {
        return this.studentNo;
    }
    
    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }

    public String getEnrollNo() {
        return this.enrollNo;
    }
    
    public void setEnrollNo(String enrollNo) {
        this.enrollNo = enrollNo;
    }

    public String getEnrollYear() {
        return this.enrollYear;
    }
    
    public void setEnrollYear(String enrollYear) {
        this.enrollYear = enrollYear;
    }

    public String getIfCheckedin() {
        return this.ifCheckedin;
    }
    
    public void setIfCheckedin(String ifCheckedin) {
        this.ifCheckedin = ifCheckedin;
    }

    public String getReason() {
        return this.reason;
    }
    
    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getIfChecked() {
        return this.ifChecked;
    }
    
    public void setIfChecked(String ifChecked) {
        this.ifChecked = ifChecked;
    }

    public String getIfReserve() {
        return this.ifReserve;
    }
    
    public void setIfReserve(String ifReserve) {
        this.ifReserve = ifReserve;
    }

    public String getIfLeaveSchool() {
        return this.ifLeaveSchool;
    }
    
    public void setIfLeaveSchool(String ifLeaveSchool) {
        this.ifLeaveSchool = ifLeaveSchool;
    }

    public String getIfGotMaterial() {
        return this.ifGotMaterial;
    }
    
    public void setIfGotMaterial(String ifGotMaterial) {
        this.ifGotMaterial = ifGotMaterial;
    }

    public String getIfGotEcard() {
        return this.ifGotEcard;
    }
    
    public void setIfGotEcard(String ifGotEcard) {
        this.ifGotEcard = ifGotEcard;
    }

    public String getIfGotStucard() {
        return this.ifGotStucard;
    }
    
    public void setIfGotStucard(String ifGotStucard) {
        this.ifGotStucard = ifGotStucard;
    }

    public String getMemo() {
        return this.memo;
    }
    
    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getIfSubmitted() {
        return this.ifSubmitted;
    }
    
    public void setIfSubmitted(String ifSubmitted) {
        this.ifSubmitted = ifSubmitted;
    }

    public String getUpdatorId() {
        return this.updatorId;
    }
    
    public void setUpdatorId(String updatorId) {
        this.updatorId = updatorId;
    }

    public Timestamp getUpdateTime() {
        return this.updateTime;
    }
    
    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof AbstractStucheckininfo)) {
			return false;
		}
		AbstractStucheckininfo rhs = (AbstractStucheckininfo) object;
		return new EqualsBuilder().append(this.updateTime, rhs.updateTime)
				.append(this.memo, rhs.memo).append(this.ifChecked,
						rhs.ifChecked)
				.append(this.ifCheckedin, rhs.ifCheckedin).append(this.id,
						rhs.id).append(this.ifGotEcard, rhs.ifGotEcard).append(
						this.reason, rhs.reason).append(this.enrollNo,
						rhs.enrollNo).append(this.studentNo, rhs.studentNo)
				.append(this.updatorId, rhs.updatorId).append(this.enrollYear,
						rhs.enrollYear).append(this.ifLeaveSchool,
						rhs.ifLeaveSchool).append(this.ifSubmitted,
						rhs.ifSubmitted).append(this.ifGotMaterial,
						rhs.ifGotMaterial).append(this.ifGotStucard,
						rhs.ifGotStucard).append(this.ifReserve, rhs.ifReserve)
				.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-600582151, 113921407).append(
				this.updateTime).append(this.memo).append(this.ifChecked)
				.append(this.ifCheckedin).append(this.id).append(
						this.ifGotEcard).append(this.reason).append(
						this.enrollNo).append(this.studentNo).append(
						this.updatorId).append(this.enrollYear).append(
						this.ifLeaveSchool).append(this.ifSubmitted).append(
						this.ifGotMaterial).append(this.ifGotStucard).append(
						this.ifReserve).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("ifGotEcard", this.ifGotEcard).append("enrollYear",
						this.enrollYear).append("id", this.id).append(
						"updatorId", this.updatorId).append("ifLeaveSchool",
						this.ifLeaveSchool).append("ifSubmitted",
						this.ifSubmitted).append("ifChecked", this.ifChecked)
				.append("memo", this.memo).append("ifGotStucard",
						this.ifGotStucard)
				.append("updateTime", this.updateTime).append("reason",
						this.reason)
				.append("ifGotMaterial", this.ifGotMaterial).append(
						"ifReserve", this.ifReserve).append("ifCheckedin",
						this.ifCheckedin).append("studentNo", this.studentNo)
				.append("enrollNo", this.enrollNo).toString();
	}

	


}