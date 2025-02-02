package org.king.classmanage.domain;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;



/**
 * AbstractStudentmodel generated by MyEclipse - Hibernate Tools
 */

public abstract class AbstractStudentmodel extends org.king.framework.domain.BaseObject implements java.io.Serializable {


    // Fields    

     private String studentId;
     private String studentNo;
     private Classmodel yxClass;
     private String enterenceNo;
     private String examNo;
     private String tempecardNo;
     private String idCard;
     private String stuName;
     private String gender;
     private String birthday;
     private String homeTelephone;
     private String nation;
     private String nationality;
     private String fromProvince;
     private String midSchCode;
     private String midSchName;
     private String polityBg;
     private String majorin;
     private String department;
     private String specIntrst;
     private String studentType;
     private String enrollYear;
     private String curGrade;
     private String dormId;
     private String idType;
     private String cultureMode;
     private String studentChar;
     private Integer checkornot;
     private Integer schoolornot;
     private String adminCollege;


    // Constructors

    /** default constructor */
    public AbstractStudentmodel() {
    }

	/** minimal constructor */
    public AbstractStudentmodel(Classmodel yxClass,String studentNo) {
    	this.yxClass = yxClass;
        this.studentNo = studentNo;
    }
    
    /** full constructor */
    public AbstractStudentmodel(Classmodel yxClass,String studentNo,String enterenceNo, String examNo, String tempecardNo, String idCard, String stuName, String gender, String birthday, String homeTelephone, String nation, String nationality, String fromProvince, String midSchCode, String midSchName, String polityBg, String majorin, String department, String specIntrst, String studentType, String enrollYear, String curGrade, String dormId,String idType,String cultureMode,String studentChar,Integer checkornot,Integer schoolornot,String adminCollege) {
        this.studentNo = studentNo;
        this.yxClass = yxClass;
        this.enterenceNo = enterenceNo;
        this.examNo = examNo;
        this.tempecardNo = tempecardNo;
        this.idCard = idCard;
        this.stuName = stuName;
        this.gender = gender;
        this.birthday = birthday;
        this.homeTelephone = homeTelephone;
        this.nation = nation;
        this.nationality = nationality;
        this.fromProvince = fromProvince;
        this.midSchCode = midSchCode;
        this.midSchName = midSchName;
        this.polityBg = polityBg;
        this.majorin = majorin;
        this.department = department;
        this.specIntrst = specIntrst;
        this.studentType = studentType;
        this.enrollYear = enrollYear;
        this.curGrade = curGrade;
        this.dormId = dormId;
        this.idType=idType;
        this.cultureMode=cultureMode;
        this.studentChar=studentChar;
        this.checkornot=checkornot;
        this.schoolornot=schoolornot;
        this.adminCollege=adminCollege;
    }

   
    // Property accessors

    public String getStudentId() {
        return this.studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentNo() {
        return this.studentNo;
    }
    
    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }

    /**
	 * @return Returns the yxClass.
	 */
	public Classmodel getYxClass() {
		return yxClass;
	}

	/**
	 * @param yxClass The yxClass to set.
	 */
	public void setYxClass(Classmodel yxClass) {
		this.yxClass = yxClass;
	}

	public String getEnterenceNo() {
        return this.enterenceNo;
    }
    
    public void setEnterenceNo(String enterenceNo) {
        this.enterenceNo = enterenceNo;
    }

    public String getExamNo() {
        return this.examNo;
    }
    
    public void setExamNo(String examNo) {
        this.examNo = examNo;
    }

    public String getTempecardNo() {
        return this.tempecardNo;
    }
    
    public void setTempecardNo(String tempecardNo) {
        this.tempecardNo = tempecardNo;
    }

    public String getIdCard() {
        return this.idCard;
    }
    
    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getStuName() {
        return this.stuName;
    }
    
    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getGender() {
        return this.gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirthday() {
        return this.birthday;
    }
    
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getHomeTelephone() {
        return this.homeTelephone;
    }
    
    public void setHomeTelephone(String homeTelephone) {
        this.homeTelephone = homeTelephone;
    }

    public String getNation() {
        return this.nation;
    }
    
    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getNationality() {
        return this.nationality;
    }
    
    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getFromProvince() {
        return this.fromProvince;
    }
    
    public void setFromProvince(String fromProvince) {
        this.fromProvince = fromProvince;
    }

    public String getMidSchCode() {
        return this.midSchCode;
    }
    
    public void setMidSchCode(String midSchCode) {
        this.midSchCode = midSchCode;
    }

    public String getMidSchName() {
        return this.midSchName;
    }
    
    public void setMidSchName(String midSchName) {
        this.midSchName = midSchName;
    }

    public String getPolityBg() {
        return this.polityBg;
    }
    
    public void setPolityBg(String polityBg) {
        this.polityBg = polityBg;
    }

    public String getMajorin() {
        return this.majorin;
    }
    
    public void setMajorin(String majorin) {
        this.majorin = majorin;
    }

    public String getDepartment() {
        return this.department;
    }
    
    public void setDepartment(String department) {
        this.department = department;
    }

    public String getSpecIntrst() {
        return this.specIntrst;
    }
    
    public void setSpecIntrst(String specIntrst) {
        this.specIntrst = specIntrst;
    }

    public String getStudentType() {
        return this.studentType;
    }
    
    public void setStudentType(String studentType) {
        this.studentType = studentType;
    }

    public String getEnrollYear() {
        return this.enrollYear;
    }
    
    public void setEnrollYear(String enrollYear) {
        this.enrollYear = enrollYear;
    }

    public String getCurGrade() {
        return this.curGrade;
    }
    
    public void setCurGrade(String curGrade) {
        this.curGrade = curGrade;
    }

    public String getDormId() {
        return this.dormId;
    }
    
    public void setDormId(String dormId) {
        this.dormId = dormId;
    }
    
    public String getIdType() {
        return this.idType;
    }
    
    public void setIdType(String idType) {
        this.idType = idType;
    }
    
    public String getCultureMode() {
        return this.cultureMode;
    }
    
    public void setCultureMode(String cultureMode) {
        this.cultureMode = cultureMode;
    }
    
    public String getStudentChar() {
        return this.studentChar;
    }
    
    public void setStudentChar(String studentChar) {
        this.studentChar = studentChar;
    }
    
    public Integer getCheckornot() {
        return this.checkornot;
    }
    
    public void setCheckornot(Integer checkornot) {
        this.checkornot = checkornot;
    }
    
    public Integer getSchoolornot() {
        return this.schoolornot;
    }
    
    public void setSchoolornot(Integer schoolornot) {
        this.schoolornot = schoolornot;
    }
    
    public String getAdminCollege() {
        return this.adminCollege;
    }
    
    public void setAdminCollege(String adminCollege) {
        this.adminCollege = adminCollege;
    }

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof AbstractStudentmodel)) {
			return false;
		}
		AbstractStudentmodel rhs = (AbstractStudentmodel) object;
		return new EqualsBuilder().append(this.midSchName, rhs.midSchName)
				.append(this.studentId, rhs.studentId).append(this.gender,
						rhs.gender).append(this.dormId, rhs.dormId).append(
						this.fromProvince, rhs.fromProvince).append(
						this.yxClass, rhs.yxClass).append(this.curGrade,
						rhs.curGrade).append(this.majorin, rhs.majorin).append(
						this.polityBg, rhs.polityBg).append(this.nationality,
						rhs.nationality).append(this.enterenceNo,
						rhs.enterenceNo)
				.append(this.midSchCode, rhs.midSchCode).append(
						this.department, rhs.department).append(this.examNo,
						rhs.examNo).append(this.homeTelephone,
						rhs.homeTelephone).append(this.tempecardNo,
						rhs.tempecardNo).append(this.idCard, rhs.idCard)
				.append(this.stuName, rhs.stuName).append(this.studentNo,
						rhs.studentNo).append(this.nation, rhs.nation).append(
						this.studentType, rhs.studentType).append(
						this.enrollYear, rhs.enrollYear).append(
						this.specIntrst, rhs.specIntrst).append(this.birthday,
						rhs.birthday).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(995676783, -1751090617).append(
				this.midSchName).append(this.studentId).append(this.gender)
				.append(this.dormId).append(this.fromProvince).append(
						this.yxClass).append(this.curGrade)
				.append(this.majorin).append(this.polityBg).append(
						this.nationality).append(this.enterenceNo).append(
						this.midSchCode).append(this.department).append(
						this.examNo).append(this.homeTelephone).append(
						this.tempecardNo).append(this.idCard).append(
						this.stuName).append(this.studentNo)
				.append(this.nation).append(this.studentType).append(
						this.enrollYear).append(this.specIntrst).append(
						this.birthday).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("midSchName", this.midSchName).append("studentId",
						this.studentId).append("gender", this.gender).append(
						"dormId", this.dormId).append("fromProvince",
						this.fromProvince).append("yxClass", this.yxClass)
				.append("curGrade", this.curGrade).append("majorin",
						this.majorin).append("polityBg", this.polityBg).append(
						"nationality", this.nationality).append("enterenceNo",
						this.enterenceNo).append("midSchCode", this.midSchCode)
				.append("department", this.department).append("examNo",
						this.examNo)
				.append("homeTelephone", this.homeTelephone).append(
						"tempecardNo", this.tempecardNo).append("idCard",
						this.idCard).append("stuName", this.stuName).append(
						"studentNo", this.studentNo).append("nation",
						this.nation).append("studentType", this.studentType)
				.append("enrollYear", this.enrollYear).append("specIntrst",
						this.specIntrst).append("birthday", this.birthday)
				.toString();
	}





}