package org.king.checkinmanage.domain;
// Generated by MyEclipse - Hibernate Tools

import java.util.Date;


/**
 * StuFeeInfo generated by MyEclipse - Hibernate Tools
 */
public class StuFeeInfo extends AbstractStuFeeInfo implements java.io.Serializable {

    // Constructors

    /** default constructor */
    public StuFeeInfo() {
    }

    
    /** full constructor */
    public StuFeeInfo(String studentNo, String feeItem, long shouldPay, long exactPay, String updatorId, Date updateTime) {
        super(studentNo, feeItem, shouldPay, exactPay, updatorId, updateTime);        
    }
   
}
