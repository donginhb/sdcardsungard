/*
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized
 * by MyEclipse Hibernate tool integration.
 *
 * Created Wed Oct 19 14:01:02 CST 2005 by MyEclipse Hibernate Tool.
 */
package com.kingstargroup.ecard.hibernate.advquery;

import java.io.Serializable;

/**
 * A class representing a composite primary key id for the T_TIF_REPORT_ACTIVE
 * table.  This object should only be instantiated for use with instances 
 * of the TTifReportActive class.
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized 
 * by MyEclipse Hibernate tool integration.
 */
public class TReportActiveKey
    implements Serializable
{
    /** The cached hash code value for this instance.  Settting to 0 triggers re-calculation. */
    private volatile int hashValue = 0;

    /** The value of the BALANCE_DATE component of this composite id. */
    private java.lang.String balanceDate;

    /** The value of the SERI_TYPE component of this composite id. */
    private java.lang.Integer seriType;

    /**
     * Simple constructor of TTifReportActiveKey instances.
     */
    public TReportActiveKey()
    {
    }

    /**
     * Returns the value of the balanceDate property.
     * @return java.lang.String
     */
    public java.lang.String getBalanceDate()
    {
        return balanceDate;
    }

    /**
     * Sets the value of the balanceDate property.
     * @param balanceDate
     */
    public void setBalanceDate(java.lang.String balanceDate)
    {
        hashValue = 0;
        this.balanceDate = balanceDate;
    }

    /**
     * Returns the value of the seriType property.
     * @return java.lang.Integer
     */
    public java.lang.Integer getSeriType()
    {
        return seriType;
    }

    /**
     * Sets the value of the seriType property.
     * @param seriType
     */
    public void setSeriType(java.lang.Integer seriType)
    {
        hashValue = 0;
        this.seriType = seriType;
    }

    /**
     * Implementation of the equals comparison on the basis of equality of the id components.
     * @param rhs
     * @return boolean
     */
    public boolean equals(Object rhs)
    {
        if (rhs == null)
            return false;
        if (! (rhs instanceof TReportActiveKey))
            return false;
        TReportActiveKey that = (TReportActiveKey) rhs;
        if (this.getBalanceDate() == null || that.getBalanceDate() == null)
        {
            return false;
        }
        if (! this.getBalanceDate().equals(that.getBalanceDate()))
        {
            return false;
        }
        if (this.getSeriType() == null || that.getSeriType() == null)
        {
            return false;
        }
        if (! this.getSeriType().equals(that.getSeriType()))
        {
            return false;
        }
        return true;
    }

    /**
     * Implementation of the hashCode method conforming to the Bloch pattern with
     * the exception of array properties (these are very unlikely primary key types).
     * @return int
     */
    public int hashCode()
    {
        if (this.hashValue == 0)
        {
            int result = 17;
            int balanceDateValue = this.getBalanceDate() == null ? 0 : this.getBalanceDate().hashCode();
            result = result * 37 + balanceDateValue;
            int seriTypeValue = this.getSeriType() == null ? 0 : this.getSeriType().hashCode();
            result = result * 37 + seriTypeValue;
            this.hashValue = result;
        }
        return this.hashValue;
    }
}