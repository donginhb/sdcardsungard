package org.king.check.domain;



/**
 * AbstractDepartconf generated by MyEclipse - Hibernate Tools
 */

public abstract class AbstractDepartconf  implements java.io.Serializable {


    // Fields    

     private String deptconfid;
    /* private String departmentid;
     private String worktimeconfid;
     private String workconfid;*/
     private String startdate;
     private String enddate;
     private Department department;
     private Workconf workconf;
     private Worktimeconf worktimeconf;
     private String isseat;
     private String restinwkd;


    // Constructors

    /** default constructor */
    public AbstractDepartconf() {
    }

    
    /** full constructor */
    public AbstractDepartconf(Department department, Worktimeconf worktimeconf, Workconf workconf, String startdate, String enddate,String isseat,String restinwkd) {
        this.department=department;
        this.startdate = startdate;
        this.enddate = enddate;
        this.workconf=workconf;
        this.worktimeconf=worktimeconf;
        this.isseat=isseat;
        this.restinwkd=restinwkd;
    }

   
    // Property accessors

    public String getDeptconfid() {
        return this.deptconfid;
    }
    
    public void setDeptconfid(String deptconfid) {
        this.deptconfid = deptconfid;
    }


    public Department getDepartment() {
		return department;
	}


	public void setDepartment(Department department) {
		this.department = department;
	}


	public Workconf getWorkconf() {
		return workconf;
	}


	public void setWorkconf(Workconf workconf) {
		this.workconf = workconf;
	}


	public Worktimeconf getWorktimeconf() {
		return worktimeconf;
	}


	public void setWorktimeconf(Worktimeconf worktimeconf) {
		this.worktimeconf = worktimeconf;
	}


	public String getStartdate() {
        return this.startdate;
    }
    
    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    public String getEnddate() {
        return this.enddate;
    }
    
    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }


	public String getIsseat() {
		return isseat;
	}


	public void setIsseat(String isseat) {
		this.isseat = isseat;
	}


	public String getRestinwkd() {
		return restinwkd;
	}


	public void setRestinwkd(String restinwkd) {
		this.restinwkd = restinwkd;
	}
   








}