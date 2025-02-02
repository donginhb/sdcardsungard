package org.king.check.domain;

import java.util.Date;


/**
 * AbstractLeaveinfo generated by MyEclipse - Hibernate Tools
 */

public abstract class AbstractLeaveinfo extends org.king.framework.domain.BaseObject 

implements java.io.Serializable {


    // Fields    

     private String leaveinfoid;
     private String description;
     private Date startdate;
     private Date enddate;
     private Date recorddate;
     private String operatorid;
     private String flag;


    // Constructors

     private Department department;
     
     private Tclerkinfo clerk;
     
    /** default constructor */
    public AbstractLeaveinfo() {
    }

    
    /** full constructor */
    public AbstractLeaveinfo(String description, Date startdate, Date enddate,Department 

department,Tclerkinfo clerk,Date recorddate,Integer operatorid,String flag) {
        this.description = description;
        this.startdate = startdate;
        this.enddate = enddate;
        this.department=department;
        this.clerk=clerk;
        this.recorddate=recorddate;
        this.flag=flag;
    }

   
    // Property accessors

    public String getLeaveinfoid() {
        return this.leaveinfoid;
    }
    
    public void setLeaveinfoid(String leaveinfoid) {
        this.leaveinfoid = leaveinfoid;
    }

    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStartdate() {
        return this.startdate;
    }
    
    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Date getEnddate() {
        return this.enddate;
    }
    
    public void setEnddate(Date enddate) {
        this.enddate = enddate;
    }


	public Department getDepartment() {
		return department;
	}


	public void setDepartment(Department department) {
		this.department = department;
	}


	public Tclerkinfo getClerk() {
		return clerk;
	}


	public void setClerk(Tclerkinfo clerk) {
		this.clerk = clerk;
	}


	public String getOperatorid() {
		return operatorid;
	}


	public void setOperatorid(String operatorid) {
		this.operatorid = operatorid;
	}


	public Date getRecorddate() {
		return recorddate;
	}


	public void setRecorddate(Date recorddate) {
		this.recorddate = recorddate;
	}


	public String getFlag() {
		return flag;
	}


	public void setFlag(String flag) {
		this.flag = flag;
	}
    
    
   








}