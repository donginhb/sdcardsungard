/*
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized
 * by MyEclipse Hibernate tool integration.
 *
 * Created Wed Oct 19 14:07:21 CST 2005 by MyEclipse Hibernate Tool.
 */
package com.kingstargroup.advquery.shopposlog;

import java.io.Serializable;

/**
 * A class representing a composite primary key id for the T_CIF_SHOP_POS_LOG
 * table.  This object should only be instantiated for use with instances 
 * of the TCifShopPosLog class.
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized 
 * by MyEclipse Hibernate tool integration.
 */
public class TCifShopPosLogKey
    implements Serializable
{
    /** The cached hash code value for this instance.  Settting to 0 triggers re-calculation. */
    private volatile int hashValue = 0;

    /** The value of the UPDATE_DATE component of this composite id. */
    private java.lang.String updateDate;

    /** The value of the ID component of this composite id. */
    private java.lang.Integer id;

    /**
     * Simple constructor of TCifShopPosLogKey instances.
     */
    public TCifShopPosLogKey()
    {
    }

    /**
     * Returns the value of the updateDate property.
     * @return java.lang.String
     */
    public java.lang.String getUpdateDate()
    {
        return updateDate;
    }

    /**
     * Sets the value of the updateDate property.
     * @param updateDate
     */
    public void setUpdateDate(java.lang.String updateDate)
    {
        hashValue = 0;
        this.updateDate = updateDate;
    }

    /**
     * Returns the value of the id property.
     * @return java.lang.Integer
     */
    public java.lang.Integer getId()
    {
        return id;
    }

    /**
     * Sets the value of the id property.
     * @param id
     */
    public void setId(java.lang.Integer id)
    {
        hashValue = 0;
        this.id = id;
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
        if (! (rhs instanceof TCifShopPosLogKey))
            return false;
        TCifShopPosLogKey that = (TCifShopPosLogKey) rhs;
        if (this.getUpdateDate() == null || that.getUpdateDate() == null)
        {
            return false;
        }
        if (! this.getUpdateDate().equals(that.getUpdateDate()))
        {
            return false;
        }
        if (this.getId() == null || that.getId() == null)
        {
            return false;
        }
        if (! this.getId().equals(that.getId()))
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
            int updateDateValue = this.getUpdateDate() == null ? 0 : this.getUpdateDate().hashCode();
            result = result * 37 + updateDateValue;
            int idValue = this.getId() == null ? 0 : this.getId().hashCode();
            result = result * 37 + idValue;
            this.hashValue = result;
        }
        return this.hashValue;
    }
}
