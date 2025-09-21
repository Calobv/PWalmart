
package paquete;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the paquete package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _GetArticulosInfo_QNAME = new QName("http://paquete/", "getArticulosInfo");
    private final static QName _GetArticulosInfoResponse_QNAME = new QName("http://paquete/", "getArticulosInfoResponse");
    private final static QName _GetRedesSociales_QNAME = new QName("http://paquete/", "getRedesSociales");
    private final static QName _GetRedesSocialesResponse_QNAME = new QName("http://paquete/", "getRedesSocialesResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: paquete
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link GetArticulosInfo }
     * 
     */
    public GetArticulosInfo createGetArticulosInfo() {
        return new GetArticulosInfo();
    }

    /**
     * Create an instance of {@link GetArticulosInfoResponse }
     * 
     */
    public GetArticulosInfoResponse createGetArticulosInfoResponse() {
        return new GetArticulosInfoResponse();
    }

    /**
     * Create an instance of {@link GetRedesSociales }
     * 
     */
    public GetRedesSociales createGetRedesSociales() {
        return new GetRedesSociales();
    }

    /**
     * Create an instance of {@link GetRedesSocialesResponse }
     * 
     */
    public GetRedesSocialesResponse createGetRedesSocialesResponse() {
        return new GetRedesSocialesResponse();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetArticulosInfo }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://paquete/", name = "getArticulosInfo")
    public JAXBElement<GetArticulosInfo> createGetArticulosInfo(GetArticulosInfo value) {
        return new JAXBElement<GetArticulosInfo>(_GetArticulosInfo_QNAME, GetArticulosInfo.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetArticulosInfoResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://paquete/", name = "getArticulosInfoResponse")
    public JAXBElement<GetArticulosInfoResponse> createGetArticulosInfoResponse(GetArticulosInfoResponse value) {
        return new JAXBElement<GetArticulosInfoResponse>(_GetArticulosInfoResponse_QNAME, GetArticulosInfoResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetRedesSociales }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://paquete/", name = "getRedesSociales")
    public JAXBElement<GetRedesSociales> createGetRedesSociales(GetRedesSociales value) {
        return new JAXBElement<GetRedesSociales>(_GetRedesSociales_QNAME, GetRedesSociales.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetRedesSocialesResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://paquete/", name = "getRedesSocialesResponse")
    public JAXBElement<GetRedesSocialesResponse> createGetRedesSocialesResponse(GetRedesSocialesResponse value) {
        return new JAXBElement<GetRedesSocialesResponse>(_GetRedesSocialesResponse_QNAME, GetRedesSocialesResponse.class, null, value);
    }

}
