
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
 *         &lt;element name="FolderCreateResult" type="{urn:thesecretserver.com}CreateFolderResult" minOccurs="0"/>
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
    "folderCreateResult"
})
@XmlRootElement(name = "FolderCreateResponse")
public class FolderCreateResponse {

    @XmlElement(name = "FolderCreateResult")
    protected CreateFolderResult folderCreateResult;

    /**
     * Gets the value of the folderCreateResult property.
     * 
     * @return
     *     possible object is
     *     {@link CreateFolderResult }
     *     
     */
    public CreateFolderResult getFolderCreateResult() {
        return folderCreateResult;
    }

    /**
     * Sets the value of the folderCreateResult property.
     * 
     * @param value
     *     allowed object is
     *     {@link CreateFolderResult }
     *     
     */
    public void setFolderCreateResult(CreateFolderResult value) {
        this.folderCreateResult = value;
    }

}
