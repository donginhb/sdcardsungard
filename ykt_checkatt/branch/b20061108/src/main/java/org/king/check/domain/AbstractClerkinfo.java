package org.king.check.domain;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;



/**
 * AbstractClerkinfo generated by MyEclipse - Hibernate Tools
 */

public abstract class AbstractClerkinfo extends org.king.framework.domain.BaseObject implements java.io.Serializable {


    // Fields    

     private Integer custId;
     private String deptId;
     private String ifoffice;
     private String kqdeptId;
     private String comments;


    // Constructors

    /** default constructor */
    public AbstractClerkinfo() {
    }

    
    /** full constructor */
    public AbstractClerkinfo(String deptId, String ifoffice, String kqdeptId, String comments) {
        this.deptId = deptId;
        this.ifoffice = ifoffice;
        this.kqdeptId = kqdeptId;
        this.comments = comments;
    }

   
    // Property accessors

    public Integer getCustId() {
        return this.custId;
    }
    
    public void setCustId(Integer custId) {
        this.custId = custId;
    }

    public String getDeptId() {
        return this.deptId;
    }
    
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getIfoffice() {
        return this.ifoffice;
    }
    
    public void setIfoffice(String ifoffice) {
        this.ifoffice = ifoffice;
    }

    public String getKqdeptId() {
        return this.kqdeptId;
    }
    
    public void setKqdeptId(String kqdeptId) {
        this.kqdeptId = kqdeptId;
    }

    public String getComments() {
        return this.comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
    }


	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof AbstractClerkinfo)) {
			return false;
		}
		AbstractClerkinfo rhs = (AbstractClerkinfo) object;
		return new EqualsBuilder().append(this.comments, rhs.comments).append(
				this.kqdeptId, rhs.kqdeptId)
				.append(this.ifoffice, rhs.ifoffice).append(this.custId,
						rhs.custId).append(this.deptId, rhs.deptId).isEquals();
	}


	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(1264837919, -510077849)
				.append(this.comments).append(this.kqdeptId).append(
						this.ifoffice).append(this.custId).append(this.deptId)
				.toHashCode();
	}


	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("comments", this.comments)
				.append("deptId", this.deptId)
				.append("kqdeptId", this.kqdeptId)
				.append("custId", this.custId)
				.append("ifoffice", this.ifoffice).toString();
	}

}