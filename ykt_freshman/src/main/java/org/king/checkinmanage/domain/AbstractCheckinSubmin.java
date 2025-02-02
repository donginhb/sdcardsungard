package org.king.checkinmanage.domain;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;



/**
 * AbstractCheckinSubmin generated by MyEclipse - Hibernate Tools
 */

public abstract class AbstractCheckinSubmin extends org.king.framework.domain.BaseObject implements java.io.Serializable {


    // Fields    

     private String id;
     private String classId;
     private String classNo;
     private String ifSubmitted;


    // Constructors

    /** default constructor */
    public AbstractCheckinSubmin() {
    }

    
    /** full constructor */
    public AbstractCheckinSubmin(String classId, String classNo, String ifSubmitted) {
        this.classId = classId;
        this.classNo = classNo;
        this.ifSubmitted = ifSubmitted;
    }

   
    // Property accessors

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getClassId() {
        return this.classId;
    }
    
    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClassNo() {
        return this.classNo;
    }
    
    public void setClassNo(String classNo) {
        this.classNo = classNo;
    }

    public String getIfSubmitted() {
        return this.ifSubmitted;
    }
    
    public void setIfSubmitted(String ifSubmitted) {
        this.ifSubmitted = ifSubmitted;
    }


	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof AbstractCheckinSubmin)) {
			return false;
		}
		AbstractCheckinSubmin rhs = (AbstractCheckinSubmin) object;
		return new EqualsBuilder().append(this.classId, rhs.classId).append(
				this.classNo, rhs.classNo).append(this.ifSubmitted,
				rhs.ifSubmitted).append(this.id, rhs.id).isEquals();
	}


	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(118970797, -1484361679).append(this.classId)
				.append(this.classNo).append(this.ifSubmitted).append(this.id)
				.toHashCode();
	}


	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("classId", this.classId)
				.append("classNo", this.classNo).append("ifSubmitted",
						this.ifSubmitted).append("id", this.id).toString();
	}
   








}