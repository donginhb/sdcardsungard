package com.kingstargroup.conference.hibernate.form;



/**
 * AbstractTPifErrcode generated by MyEclipse - Hibernate Tools
 */

public abstract class AbstractTPifErrcode  implements java.io.Serializable {


    // Fields    

     private Integer ecode;
     private String emsg;


    // Constructors

    /** default constructor */
    public AbstractTPifErrcode() {
    }

	/** minimal constructor */
    public AbstractTPifErrcode(Integer ecode) {
        this.ecode = ecode;
    }
    
    /** full constructor */
    public AbstractTPifErrcode(Integer ecode, String emsg) {
        this.ecode = ecode;
        this.emsg = emsg;
    }

   
    // Property accessors

    public Integer getEcode() {
        return this.ecode;
    }
    
    public void setEcode(Integer ecode) {
        this.ecode = ecode;
    }

    public String getEmsg() {
        return this.emsg;
    }
    
    public void setEmsg(String emsg) {
        this.emsg = emsg;
    }
   








}