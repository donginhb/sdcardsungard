/*
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized
 * by MyEclipse Hibernate tool integration.
 *
 * Created Wed Oct 19 14:02:33 CST 2005 by MyEclipse Hibernate Tool.
 */
package com.kingstargroup.advquery.reportoper;

import java.io.Serializable;

/**
 * A class that represents a row in the T_TIF_REPORT_OPER table. 
 * You can customize the behavior of this class by editing the class, {@link TTifReportOper()}.
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized
 * by MyEclipse Hibernate tool integration.
 */
public abstract class AbstractTTifReportOper 
    implements Serializable
{
    /** The cached hash code value for this instance.  Settting to 0 triggers re-calculation. */
    private int hashValue = 0;

    /** The simple primary key value. */
    private TTifReportOperKey id;

    /** The value of the simple happenNum property. */
    private java.lang.Integer happenNum;

    /** The value of the simple happenAmt property. */
    private java.lang.Double happenAmt;

    /** The value of the simple mngAmt property. */
    private java.lang.Double mngAmt;

    /** The value of the simple ensureAmt property. */
    private java.lang.Double ensureAmt;

    /** The value of the simple costAmt property. */
    private java.lang.Double costAmt;

    /** The value of the simple depAmt property. */
    private java.lang.Double depAmt;

    /** The value of the simple earnAmt property. */
    private java.lang.Double earnAmt;

    /** The value of the simple bankAmt property. */
    private java.lang.Double bankAmt;

    /** The value of the simple cashAmt property. */
    private java.lang.Double cashAmt;

    /** The value of the simple dataSign property. */
    private java.lang.String dataSign;

    /** The value of the simple reserve1 property. */
    private java.lang.String reserve1;

    /** The value of the simple reserve2 property. */
    private java.lang.String reserve2;

    /**
     * Simple constructor of AbstractTTifReportOper instances.
     */
    public AbstractTTifReportOper()
    {
    }

    /**
     * Constructor of AbstractTTifReportOper instances given a composite primary key.
     * @param id
     */
    public AbstractTTifReportOper(TTifReportOperKey id)
    {
        this.setId(id);
    }

    /**
     * Return the composite id instance that identifies this object.
     * @return TTifReportOperKey
     */
    public TTifReportOperKey getId()
    {
        return this.id;
    }

    /**
     * Set the composite id instance that identifies this object.
     * @param id
     */
    public void setId(TTifReportOperKey id)
    {
        this.hashValue = 0;
        this.id = id;
    }

    /**
     * Return the value of the HAPPEN_NUM column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getHappenNum()
    {
        return this.happenNum;
    }

    /**
     * Set the value of the HAPPEN_NUM column.
     * @param happenNum
     */
    public void setHappenNum(java.lang.Integer happenNum)
    {
        this.happenNum = happenNum;
    }

    /**
     * Return the value of the HAPPEN_AMT column.
     * @return java.lang.Double
     */
    public java.lang.Double getHappenAmt()
    {
        return this.happenAmt;
    }

    /**
     * Set the value of the HAPPEN_AMT column.
     * @param happenAmt
     */
    public void setHappenAmt(java.lang.Double happenAmt)
    {
        this.happenAmt = happenAmt;
    }

    /**
     * Return the value of the MNG_AMT column.
     * @return java.lang.Double
     */
    public java.lang.Double getMngAmt()
    {
        return this.mngAmt;
    }

    /**
     * Set the value of the MNG_AMT column.
     * @param mngAmt
     */
    public void setMngAmt(java.lang.Double mngAmt)
    {
        this.mngAmt = mngAmt;
    }

    /**
     * Return the value of the ENSURE_AMT column.
     * @return java.lang.Double
     */
    public java.lang.Double getEnsureAmt()
    {
        return this.ensureAmt;
    }

    /**
     * Set the value of the ENSURE_AMT column.
     * @param ensureAmt
     */
    public void setEnsureAmt(java.lang.Double ensureAmt)
    {
        this.ensureAmt = ensureAmt;
    }

    /**
     * Return the value of the COST_AMT column.
     * @return java.lang.Double
     */
    public java.lang.Double getCostAmt()
    {
        return this.costAmt;
    }

    /**
     * Set the value of the COST_AMT column.
     * @param costAmt
     */
    public void setCostAmt(java.lang.Double costAmt)
    {
        this.costAmt = costAmt;
    }

    /**
     * Return the value of the DEP_AMT column.
     * @return java.lang.Double
     */
    public java.lang.Double getDepAmt()
    {
        return this.depAmt;
    }

    /**
     * Set the value of the DEP_AMT column.
     * @param depAmt
     */
    public void setDepAmt(java.lang.Double depAmt)
    {
        this.depAmt = depAmt;
    }

    /**
     * Return the value of the EARN_AMT column.
     * @return java.lang.Double
     */
    public java.lang.Double getEarnAmt()
    {
        return this.earnAmt;
    }

    /**
     * Set the value of the EARN_AMT column.
     * @param earnAmt
     */
    public void setEarnAmt(java.lang.Double earnAmt)
    {
        this.earnAmt = earnAmt;
    }

    /**
     * Return the value of the BANK_AMT column.
     * @return java.lang.Double
     */
    public java.lang.Double getBankAmt()
    {
        return this.bankAmt;
    }

    /**
     * Set the value of the BANK_AMT column.
     * @param bankAmt
     */
    public void setBankAmt(java.lang.Double bankAmt)
    {
        this.bankAmt = bankAmt;
    }

    /**
     * Return the value of the CASH_AMT column.
     * @return java.lang.Double
     */
    public java.lang.Double getCashAmt()
    {
        return this.cashAmt;
    }

    /**
     * Set the value of the CASH_AMT column.
     * @param cashAmt
     */
    public void setCashAmt(java.lang.Double cashAmt)
    {
        this.cashAmt = cashAmt;
    }

    /**
     * Return the value of the DATA_SIGN column.
     * @return java.lang.String
     */
    public java.lang.String getDataSign()
    {
        return this.dataSign;
    }

    /**
     * Set the value of the DATA_SIGN column.
     * @param dataSign
     */
    public void setDataSign(java.lang.String dataSign)
    {
        this.dataSign = dataSign;
    }

    /**
     * Return the value of the RESERVE1 column.
     * @return java.lang.String
     */
    public java.lang.String getReserve1()
    {
        return this.reserve1;
    }

    /**
     * Set the value of the RESERVE1 column.
     * @param reserve1
     */
    public void setReserve1(java.lang.String reserve1)
    {
        this.reserve1 = reserve1;
    }

    /**
     * Return the value of the RESERVE2 column.
     * @return java.lang.String
     */
    public java.lang.String getReserve2()
    {
        return this.reserve2;
    }

    /**
     * Set the value of the RESERVE2 column.
     * @param reserve2
     */
    public void setReserve2(java.lang.String reserve2)
    {
        this.reserve2 = reserve2;
    }

    /**
     * Implementation of the equals comparison on the basis of equality of the primary key values.
     * @param rhs
     * @return boolean
     */
    public boolean equals(Object rhs)
    {
        if (rhs == null)
            return false;
        if (! (rhs instanceof TTifReportOper))
            return false;
        TTifReportOper that = (TTifReportOper) rhs;
        if (this.getId() == null || that.getId() == null)
            return false;
        return (this.getId().equals(that.getId()));
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
            if (this.getId() == null)
            {
                result = super.hashCode();
            }
            else
            {
                result = this.getId().hashCode();
            }
            this.hashValue = result;
        }
        return this.hashValue;
    }
}
