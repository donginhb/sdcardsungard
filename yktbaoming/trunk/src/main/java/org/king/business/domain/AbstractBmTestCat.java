package org.king.business.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


/**
 * AbstractBmTestCat generated by MyEclipse - Hibernate Tools
 */

public abstract class AbstractBmTestCat extends org.king.framework.domain.BaseObject implements java.io.Serializable {


    // Fields    

     private String id;
     private String testCatName;
     private String ifFee;
     private double fee;
     private String state;
     private String updator;
     private String updateTime;
     private Set bmTests = new HashSet(0);


    // Constructors

    /** default constructor */
    public AbstractBmTestCat() {
    }

    
    /** full constructor */
    public AbstractBmTestCat(String testCatName, String ifFee, double fee,String state,String updator, String updateTime, Set bmTests) {
        this.testCatName = testCatName;
        this.ifFee = ifFee;
        this.fee = fee;
        this.state=state;
        this.updator = updator;
        this.updateTime = updateTime;
        this.bmTests = bmTests;
    }

   
    // Property accessors

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getTestCatName() {
        return this.testCatName;
    }
    
    public void setTestCatName(String testCatName) {
        this.testCatName = testCatName;
    }

    public String getIfFee() {
        return this.ifFee;
    }
    
    public void setIfFee(String ifFee) {
        this.ifFee = ifFee;
    }

    public double getFee() {
        return this.fee;
    }
    
    public void setFee(double fee) {
        this.fee = fee;
    }
    
    public String getState() {
        return this.state;
    }
    
    public void setState(String state) {
        this.state = state;
    }

    public String getUpdator() {
        return this.updator;
    }
    
    public void setUpdator(String updator) {
        this.updator = updator;
    }

    public String getUpdateTime() {
        return this.updateTime;
    }
    
    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public Set getBmTests() {
        return this.bmTests;
    }
    
    public void setBmTests(Set bmTests) {
        this.bmTests = bmTests;
    }
   








}