
package com.thesecretserver.service;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for Permission complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="Permission">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="UserOrGroup" type="{urn:thesecretserver.com}GroupOrUserRecord" minOccurs="0"/>
 *         &lt;element name="View" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="Edit" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="Owner" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="SecretAccessRoleName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="SecretAccessRoleId" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Permission", propOrder = {
    "userOrGroup",
    "view",
    "edit",
    "owner",
    "secretAccessRoleName",
    "secretAccessRoleId"
})
public class Permission {

    @XmlElement(name = "UserOrGroup")
    protected GroupOrUserRecord userOrGroup;
    @XmlElement(name = "View")
    protected boolean view;
    @XmlElement(name = "Edit")
    protected boolean edit;
    @XmlElement(name = "Owner")
    protected boolean owner;
    @XmlElement(name = "SecretAccessRoleName")
    protected String secretAccessRoleName;
    @XmlElement(name = "SecretAccessRoleId", required = true, type = Integer.class, nillable = true)
    protected Integer secretAccessRoleId;

    /**
     * Gets the value of the userOrGroup property.
     * 
     * @return
     *     possible object is
     *     {@link GroupOrUserRecord }
     *     
     */
    public GroupOrUserRecord getUserOrGroup() {
        return userOrGroup;
    }

    /**
     * Sets the value of the userOrGroup property.
     * 
     * @param value
     *     allowed object is
     *     {@link GroupOrUserRecord }
     *     
     */
    public void setUserOrGroup(GroupOrUserRecord value) {
        this.userOrGroup = value;
    }

    /**
     * Gets the value of the view property.
     * 
     */
    public boolean isView() {
        return view;
    }

    /**
     * Sets the value of the view property.
     * 
     */
    public void setView(boolean value) {
        this.view = value;
    }

    /**
     * Gets the value of the edit property.
     * 
     */
    public boolean isEdit() {
        return edit;
    }

    /**
     * Sets the value of the edit property.
     * 
     */
    public void setEdit(boolean value) {
        this.edit = value;
    }

    /**
     * Gets the value of the owner property.
     * 
     */
    public boolean isOwner() {
        return owner;
    }

    /**
     * Sets the value of the owner property.
     * 
     */
    public void setOwner(boolean value) {
        this.owner = value;
    }

    /**
     * Gets the value of the secretAccessRoleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSecretAccessRoleName() {
        return secretAccessRoleName;
    }

    /**
     * Sets the value of the secretAccessRoleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSecretAccessRoleName(String value) {
        this.secretAccessRoleName = value;
    }

    /**
     * Gets the value of the secretAccessRoleId property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getSecretAccessRoleId() {
        return secretAccessRoleId;
    }

    /**
     * Sets the value of the secretAccessRoleId property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setSecretAccessRoleId(Integer value) {
        this.secretAccessRoleId = value;
    }

}
