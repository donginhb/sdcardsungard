/*
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized
 * by MyEclipse Hibernate tool integration.
 *
 * Created Tue Nov 14 13:16:00 CST 2006 by MyEclipse Hibernate Tool.
 */
package com.kingstargroup.form;

import java.io.Serializable;

/**
 * A class that represents a row in the MONITORS table. 
 * You can customize the behavior of this class by editing the class, {@link Monitors()}.
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized
 * by MyEclipse Hibernate tool integration.
 */
public abstract class AbstractMonitors 
    implements Serializable
{
    /** The cached hash code value for this instance.  Settting to 0 triggers re-calculation. */
    private int hashValue = 0;

    /** The simple primary key value. */
    private MonitorsKey id;

    /** The value of the simple valuestr property. */
    private java.lang.String valuestr;

    /** The value of the simple modified property. */
    private java.util.Date modified;

    /**
     * Simple constructor of AbstractMonitors instances.
     */
    public AbstractMonitors()
    {
    }

    /**
     * Constructor of AbstractMonitors instances given a composite primary key.
     * @param id
     */
    public AbstractMonitors(MonitorsKey id)
    {
        this.setId(id);
    }

    /**
     * Return the composite id instance that identifies this object.
     * @return MonitorsKey
     */
    public MonitorsKey getId()
    {
        return this.id;
    }

    /**
     * Set the composite id instance that identifies this object.
     * @param id
     */
    public void setId(MonitorsKey id)
    {
        this.hashValue = 0;
        this.id = id;
    }

    /**
     * Return the value of the VALUESTR column.
     * @return java.lang.String
     */
    public java.lang.String getValuestr()
    {
        return this.valuestr;
    }

    /**
     * Set the value of the VALUESTR column.
     * @param valuestr
     */
    public void setValuestr(java.lang.String valuestr)
    {
        this.valuestr = valuestr;
    }

    /**
     * Return the value of the MODIFIED column.
     * @return java.util.Date
     */
    public java.util.Date getModified()
    {
        return this.modified;
    }

    /**
     * Set the value of the MODIFIED column.
     * @param modified
     */
    public void setModified(java.util.Date modified)
    {
        this.modified = modified;
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
        if (! (rhs instanceof Monitors))
            return false;
        Monitors that = (Monitors) rhs;
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
