
package com.thesecretserver.service;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java-Klasse f�r anonymous complex type.
 * 
 * <p>Das folgende Schemafragment gibt den erwarteten Content an, der in dieser Klasse enthalten ist.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="VersionGetResult" type="{urn:thesecretserver.com}VersionGetResult" minOccurs="0"/>
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
    "versionGetResult"
})
@XmlRootElement(name = "VersionGetResponse")
public class VersionGetResponse {

    @XmlElement(name = "VersionGetResult")
    protected VersionGetResult versionGetResult;

    /**
     * Ruft den Wert der versionGetResult-Eigenschaft ab.
     * 
     * @return
     *     possible object is
     *     {@link VersionGetResult }
     *     
     */
    public VersionGetResult getVersionGetResult() {
        return versionGetResult;
    }

    /**
     * Legt den Wert der versionGetResult-Eigenschaft fest.
     * 
     * @param value
     *     allowed object is
     *     {@link VersionGetResult }
     *     
     */
    public void setVersionGetResult(VersionGetResult value) {
        this.versionGetResult = value;
    }

}
