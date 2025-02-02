/**
 * CacheControl.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2RC3 Feb 28, 2005 (10:15:14 EST) WSDL2Java emitter.
 */

package oasis.names.tc.wsrp.v1.types;

public class CacheControl  implements java.io.Serializable {
    private int expires;
    private java.lang.String userScope;
    private java.lang.String validateTag;
    private oasis.names.tc.wsrp.v1.types.Extension[] extensions;

    public CacheControl() {
    }

    public CacheControl(
           int expires,
           oasis.names.tc.wsrp.v1.types.Extension[] extensions,
           java.lang.String userScope,
           java.lang.String validateTag) {
           this.expires = expires;
           this.userScope = userScope;
           this.validateTag = validateTag;
           this.extensions = extensions;
    }


    /**
     * Gets the expires value for this CacheControl.
     * 
     * @return expires
     */
    public int getExpires() {
        return expires;
    }


    /**
     * Sets the expires value for this CacheControl.
     * 
     * @param expires
     */
    public void setExpires(int expires) {
        this.expires = expires;
    }


    /**
     * Gets the userScope value for this CacheControl.
     * 
     * @return userScope
     */
    public java.lang.String getUserScope() {
        return userScope;
    }


    /**
     * Sets the userScope value for this CacheControl.
     * 
     * @param userScope
     */
    public void setUserScope(java.lang.String userScope) {
        this.userScope = userScope;
    }


    /**
     * Gets the validateTag value for this CacheControl.
     * 
     * @return validateTag
     */
    public java.lang.String getValidateTag() {
        return validateTag;
    }


    /**
     * Sets the validateTag value for this CacheControl.
     * 
     * @param validateTag
     */
    public void setValidateTag(java.lang.String validateTag) {
        this.validateTag = validateTag;
    }


    /**
     * Gets the extensions value for this CacheControl.
     * 
     * @return extensions
     */
    public oasis.names.tc.wsrp.v1.types.Extension[] getExtensions() {
        return extensions;
    }


    /**
     * Sets the extensions value for this CacheControl.
     * 
     * @param extensions
     */
    public void setExtensions(oasis.names.tc.wsrp.v1.types.Extension[] extensions) {
        this.extensions = extensions;
    }

    public oasis.names.tc.wsrp.v1.types.Extension getExtensions(int i) {
        return this.extensions[i];
    }

    public void setExtensions(int i, oasis.names.tc.wsrp.v1.types.Extension _value) {
        this.extensions[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof CacheControl)) return false;
        CacheControl other = (CacheControl) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.expires == other.getExpires() &&
            ((this.userScope==null && other.getUserScope()==null) || 
             (this.userScope!=null &&
              this.userScope.equals(other.getUserScope()))) &&
            ((this.validateTag==null && other.getValidateTag()==null) || 
             (this.validateTag!=null &&
              this.validateTag.equals(other.getValidateTag()))) &&
            ((this.extensions==null && other.getExtensions()==null) || 
             (this.extensions!=null &&
              java.util.Arrays.equals(this.extensions, other.getExtensions())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        _hashCode += getExpires();
        if (getUserScope() != null) {
            _hashCode += getUserScope().hashCode();
        }
        if (getValidateTag() != null) {
            _hashCode += getValidateTag().hashCode();
        }
        if (getExtensions() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getExtensions());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getExtensions(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(CacheControl.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("urn:oasis:names:tc:wsrp:v1:types", "CacheControl"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("expires");
        elemField.setXmlName(new javax.xml.namespace.QName("urn:oasis:names:tc:wsrp:v1:types", "expires"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("userScope");
        elemField.setXmlName(new javax.xml.namespace.QName("urn:oasis:names:tc:wsrp:v1:types", "userScope"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("validateTag");
        elemField.setXmlName(new javax.xml.namespace.QName("urn:oasis:names:tc:wsrp:v1:types", "validateTag"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("extensions");
        elemField.setXmlName(new javax.xml.namespace.QName("urn:oasis:names:tc:wsrp:v1:types", "extensions"));
        elemField.setXmlType(new javax.xml.namespace.QName("urn:oasis:names:tc:wsrp:v1:types", "Extension"));
        elemField.setMinOccurs(0);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
