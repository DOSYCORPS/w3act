
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
 *         &lt;element name="GetSecretResult" type="{urn:thesecretserver.com}GetSecretResult" minOccurs="0"/>
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
    "getSecretResult"
})
@XmlRootElement(name = "GetSecretResponse")
public class GetSecretResponse {

    @XmlElement(name = "GetSecretResult")
    protected GetSecretResult getSecretResult;

    /**
     * Ruft den Wert der getSecretResult-Eigenschaft ab.
     * 
     * @return
     *     possible object is
     *     {@link GetSecretResult }
     *     
     */
    public GetSecretResult getGetSecretResult() {
        return getSecretResult;
    }

    /**
     * Legt den Wert der getSecretResult-Eigenschaft fest.
     * 
     * @param value
     *     allowed object is
     *     {@link GetSecretResult }
     *     
     */
    public void setGetSecretResult(GetSecretResult value) {
        this.getSecretResult = value;
    }

}
