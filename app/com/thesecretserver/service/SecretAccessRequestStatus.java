
package com.thesecretserver.service;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlEnumValue;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java-Klasse f�r SecretAccessRequestStatus.
 * 
 * <p>Das folgende Schemafragment gibt den erwarteten Content an, der in dieser Klasse enthalten ist.
 * <p>
 * <pre>
 * &lt;simpleType name="SecretAccessRequestStatus">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *     &lt;enumeration value="Pending"/>
 *     &lt;enumeration value="Approved"/>
 *     &lt;enumeration value="Denied"/>
 *     &lt;enumeration value="Canceled"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlType(name = "SecretAccessRequestStatus")
@XmlEnum
public enum SecretAccessRequestStatus {

    @XmlEnumValue("Pending")
    PENDING("Pending"),
    @XmlEnumValue("Approved")
    APPROVED("Approved"),
    @XmlEnumValue("Denied")
    DENIED("Denied"),
    @XmlEnumValue("Canceled")
    CANCELED("Canceled");
    private final String value;

    SecretAccessRequestStatus(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static SecretAccessRequestStatus fromValue(String v) {
        for (SecretAccessRequestStatus c: SecretAccessRequestStatus.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
