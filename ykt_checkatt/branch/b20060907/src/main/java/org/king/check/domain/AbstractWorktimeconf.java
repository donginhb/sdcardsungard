package org.king.check.domain;



/**
 * AbstractWorktimeconf generated by MyEclipse - Hibernate Tools
 */

public abstract class AbstractWorktimeconf extends org.king.framework.domain.BaseObject implements java.io.Serializable {


    // Fields    

     private String worktimeconfid;
     private String confname;
     private String ondutytime1;
     private String ondutytime2;
     private String ondutytime3;
     private String ondutytime4;
     private String offdutytime1;
     private String offdutytime2;
     private String offdutytime3;
     private String offdutytime4;


    // Constructors

    /** default constructor */
    public AbstractWorktimeconf() {
    }

    
    /** full constructor */
    public AbstractWorktimeconf(String confname,String ondutytime1,String ondutytime2,
    		String ondutytime3,String ondutytime4,String offdutytime1,String offdutytime2,
    		String offdutytime3,String offdutytime4) {
    	this.confname=confname;
    	this.offdutytime1=offdutytime1;
    	this.offdutytime2=offdutytime2;
    	this.offdutytime3=offdutytime3;
    	this.offdutytime4=offdutytime4;
    	this.ondutytime1=ondutytime1;
    	this.ondutytime2=ondutytime2;
    	this.ondutytime3=ondutytime3;
    	this.ondutytime4=ondutytime4;


    }

   
    // Property accessors

    public String getWorktimeconfid() {
        return this.worktimeconfid;
    }
    
    public void setWorktimeconfid(String worktimeconfid) {
        this.worktimeconfid = worktimeconfid;
    }


	public String getConfname() {
		return confname;
	}


	public void setConfname(String confname) {
		this.confname = confname;
	}


	public String getOffdutytime1() {
		return offdutytime1;
	}


	public void setOffdutytime1(String offdutytime1) {
		this.offdutytime1 = offdutytime1;
	}


	public String getOffdutytime2() {
		return offdutytime2;
	}


	public void setOffdutytime2(String offdutytime2) {
		this.offdutytime2 = offdutytime2;
	}


	public String getOffdutytime3() {
		return offdutytime3;
	}


	public void setOffdutytime3(String offdutytime3) {
		this.offdutytime3 = offdutytime3;
	}


	public String getOffdutytime4() {
		return offdutytime4;
	}


	public void setOffdutytime4(String offdutytime4) {
		this.offdutytime4 = offdutytime4;
	}


	public String getOndutytime1() {
		return ondutytime1;
	}


	public void setOndutytime1(String ondutytime1) {
		this.ondutytime1 = ondutytime1;
	}


	public String getOndutytime2() {
		return ondutytime2;
	}


	public void setOndutytime2(String ondutytime2) {
		this.ondutytime2 = ondutytime2;
	}


	public String getOndutytime3() {
		return ondutytime3;
	}


	public void setOndutytime3(String ondutytime3) {
		this.ondutytime3 = ondutytime3;
	}


	public String getOndutytime4() {
		return ondutytime4;
	}


	public void setOndutytime4(String ondutytime4) {
		this.ondutytime4 = ondutytime4;
	}


   








}