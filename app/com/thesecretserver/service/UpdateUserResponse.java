
package com.thesecretserver.service;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="UpdateUserResult" type="{urn:thesecretserver.com}UpdateUserResult" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "updateUserResult"
})
@XmlRootElement(name = "UpdateUserResponse")
public class UpdateUserResponse {

    @XmlElement(name = "UpdateUserResult")
    protected UpdateUserResult updateUserResult;

    /**
     * Gets the value of the updateUserResult property.
     * 
     * @return
     *     possible object is
     *     {@link UpdateUserResult }
     *     
     */
    public UpdateUserResult getUpdateUserResult() {
        return updateUserResult;
    }

    /**
     * Sets the value of the updateUserResult property.
     * 
     * @param value
     *     allowed object is
     *     {@link UpdateUserResult }
     *     
     */
    public void setUpdateUserResult(UpdateUserResult value) {
        this.updateUserResult = value;
    }

}
