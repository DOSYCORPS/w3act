<?xml version="1.0" encoding="utf-8"?>
<wsdl:definitions xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:tns="urn:thesecretserver.com" xmlns:s1="urn:thesecretserver.com/AbstractTypes" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" targetNamespace="urn:thesecretserver.com" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">
  <wsdl:documentation xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">Webservice for standard integration.</wsdl:documentation>
  <wsdl:types>
    <s:schema elementFormDefault="qualified" targetNamespace="urn:thesecretserver.com">
      <s:element name="ApproveSecretAccessRequest">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="approvalId" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="hours" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="userOverride" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="ApproveSecretAccessRequestResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="ApproveSecretAccessRequestResult" type="tns:RequestApprovalResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="RequestApprovalResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:GenericResult">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="ApprovalInfo" type="tns:ApprovalInfo" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="GenericResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="ErrorMessage" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ApprovalInfo">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="Status" type="tns:SecretAccessRequestStatus" />
          <s:element minOccurs="0" maxOccurs="1" name="Responder" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="ResponseDate" type="s:dateTime" />
          <s:element minOccurs="0" maxOccurs="1" name="ResponseComment" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="ExpirationDate" nillable="true" type="s:dateTime" />
        </s:sequence>
      </s:complexType>
      <s:simpleType name="SecretAccessRequestStatus">
        <s:restriction base="s:string">
          <s:enumeration value="Pending" />
          <s:enumeration value="Approved" />
          <s:enumeration value="Denied" />
          <s:enumeration value="Canceled" />
        </s:restriction>
      </s:simpleType>
      <s:element name="DenySecretAccessRequest">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="approvalId" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="userOverride" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="DenySecretAccessRequestResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="DenySecretAccessRequestResult" type="tns:RequestApprovalResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="Authenticate">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="username" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="password" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="organization" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="domain" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AuthenticateResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AuthenticateResult" type="tns:AuthenticateResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="AuthenticateResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="Token" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfString">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="string" nillable="true" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="ImpersonateUser">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="username" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="organization" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="domain" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="ImpersonateUserResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="ImpersonateUserResult" type="tns:ImpersonateResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="ImpersonateResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="Token" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="AuthorizeURL" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="AuthenticateRADIUS">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="username" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="password" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="organization" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="domain" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="radiusPassword" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AuthenticateRADIUSResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AuthenticateRADIUSResult" type="tns:AuthenticateResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetTokenIsValid">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetTokenIsValidResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetTokenIsValidResult" type="tns:TokenIsValidResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="TokenIsValidResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="1" maxOccurs="1" name="MaxOfflineSeconds" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="Version" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetSecretLegacy">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretLegacyResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSecretLegacyResult" type="tns:GetSecretResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetSecretResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretError" type="tns:SecretError" />
          <s:element minOccurs="0" maxOccurs="1" name="Secret" type="tns:Secret" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SecretError">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="ErrorCode" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="ErrorMessage" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="AllowsResponse" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="CommentTitle" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="AdditionalCommentTitle" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="Secret">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Items" type="tns:ArrayOfSecretItem" />
          <s:element minOccurs="1" maxOccurs="1" name="Id" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretTypeId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="FolderId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="IsWebLauncher" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="CheckOutMinutesRemaining" nillable="true" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="IsCheckedOut" nillable="true" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="CheckOutUserDisplayName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="CheckOutUserId" nillable="true" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="IsOutOfSync" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="IsRestricted" nillable="true" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="OutOfSyncReason" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretSettings" type="tns:SecretSettings" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretPermissions" type="tns:SecretPermissions" />
          <s:element minOccurs="0" maxOccurs="1" name="Active" nillable="true" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSecretItem">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SecretItem" nillable="true" type="tns:SecretItem" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SecretItem">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Value" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="Id" nillable="true" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="FieldId" nillable="true" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="FieldName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="IsFile" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="IsNotes" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="IsPassword" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="FieldDisplayName" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SecretSettings">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="AutoChangeEnabled" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="RequiresApprovalForAccess" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="RequiresComment" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="CheckOutEnabled" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="CheckOutChangePasswordEnabled" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="ProxyEnabled" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="SessionRecordingEnabled" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="RestrictSshCommands" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="AllowOwnersUnrestrictedSshCommands" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="PrivilegedSecretId" nillable="true" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="AssociatedSecretIds" type="tns:ArrayOfInt" />
          <s:element minOccurs="0" maxOccurs="1" name="Approvers" type="tns:ArrayOfGroupOrUserRecord" />
          <s:element minOccurs="0" maxOccurs="1" name="SshCommandMenuAccessPermissions" type="tns:ArrayOfSshCommandMenuAccessPermission" />
          <s:element minOccurs="1" maxOccurs="1" name="IsChangeToSettings" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfInt">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="int" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfGroupOrUserRecord">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="GroupOrUserRecord" nillable="true" type="tns:GroupOrUserRecord" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="GroupOrUserRecord">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="DomainName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="IsUser" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="GroupId" nillable="true" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="UserId" nillable="true" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSshCommandMenuAccessPermission">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SshCommandMenuAccessPermission" nillable="true" type="tns:SshCommandMenuAccessPermission" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SshCommandMenuAccessPermission">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="GroupOrUserRecord" type="tns:GroupOrUserRecord" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="ConcurrencyId" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="DisplayName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="SshCommandMenuName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="IsUnrestricted" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="SshCommandMenuId" nillable="true" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SecretPermissions">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="CurrentUserHasView" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="CurrentUserHasEdit" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="CurrentUserHasOwner" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="InheritPermissionsEnabled" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="IsChangeToPermissions" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="Permissions" type="tns:ArrayOfPermission" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfPermission">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="Permission" nillable="true" type="tns:Permission" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="Permission">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="UserOrGroup" type="tns:GroupOrUserRecord" />
          <s:element minOccurs="1" maxOccurs="1" name="View" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="Edit" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="Owner" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretAccessRoleName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretAccessRoleId" nillable="true" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetSecret">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="loadSettingsAndPermissions" nillable="true" type="s:boolean" />
            <s:element minOccurs="0" maxOccurs="1" name="codeResponses" type="tns:ArrayOfCodeResponse" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="ArrayOfCodeResponse">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="CodeResponse" nillable="true" type="tns:CodeResponse" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="CodeResponse">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="ErrorCode" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Comment" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="AdditionalComment" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="TicketSystemId" nillable="true" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetSecretResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSecretResult" type="tns:GetSecretResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetCheckOutStatus">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetCheckOutStatusResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetCheckOutStatusResult" type="tns:GetCheckOutStatusResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetCheckOutStatusResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="Secret" type="tns:Secret" />
          <s:element minOccurs="1" maxOccurs="1" name="CheckOutMinutesRemaining" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="IsCheckedOut" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="CheckOutUserDisplayName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="CheckOutUserId" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:element name="ChangePassword">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="currentPassword" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="newPassword" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="ChangePasswordResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="ChangePasswordResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="WebServiceResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetSecretsByFieldValue">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="fieldName" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="showDeleted" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretsByFieldValueResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSecretsByFieldValueResult" type="tns:GetSecretsByFieldValueResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetSecretsByFieldValueResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="Secrets" type="tns:ArrayOfSecret" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSecret">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="Secret" nillable="true" type="tns:Secret" />
        </s:sequence>
      </s:complexType>
      <s:element name="SearchSecretsByFieldValue">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="fieldName" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="showDeleted" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="showRestricted" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsByFieldValueResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchSecretsByFieldValueResult" type="tns:SearchSecretsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SearchSecretsResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretSummaries" type="tns:ArrayOfSecretSummary" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSecretSummary">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SecretSummary" nillable="true" type="tns:SecretSummary" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SecretSummary">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SecretId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretTypeName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretTypeId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="FolderId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="IsRestricted" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetSecretsByExposedFieldValue">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="fieldName" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="showDeleted" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="showPartialMatches" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretsByExposedFieldValueResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSecretsByExposedFieldValueResult" type="tns:GetSecretsByFieldValueResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsByExposedFieldValue">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="fieldName" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="showDeleted" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="showRestricted" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="showPartialMatches" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsByExposedFieldValueResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchSecretsByExposedFieldValueResult" type="tns:SearchSecretsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsByExposedValues">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="showDeleted" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="showRestricted" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="showPartialMatches" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsByExposedValuesResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchSecretsByExposedValuesResult" type="tns:SearchSecretsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AddUser">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="newUser" type="tns:User" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="User">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="Id" nillable="true" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="UserName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="DisplayName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="DomainId" nillable="true" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="IsApplicationAccount" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="RadiusTwoFactor" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="EmailTwoFactor" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="RadiusUserName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="EmailAddress" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Password" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="Enabled" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="DuoTwoFactor" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="OATHTwoFactor" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:element name="AddUserResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AddUserResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecrets">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="includeDeleted" nillable="true" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="includeRestricted" nillable="true" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchSecretsResult" type="tns:SearchSecretsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsLegacy">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsLegacyResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchSecretsLegacyResult" type="tns:SearchSecretsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsByFolder">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="folderId" nillable="true" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="includeSubFolders" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="includeDeleted" nillable="true" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="includeRestricted" nillable="true" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsByFolderResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchSecretsByFolderResult" type="tns:SearchSecretsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsByFolderLegacy">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="folderId" nillable="true" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="includeSubFolders" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretsByFolderLegacyResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchSecretsByFolderLegacyResult" type="tns:SearchSecretsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetFavorites">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="includeRestricted" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetFavoritesResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetFavoritesResult" type="tns:GetFavoritesResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetFavoritesResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretSummaries" type="tns:ArrayOfSecretSummary" />
        </s:sequence>
      </s:complexType>
      <s:element name="UpdateIsFavorite">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="isFavorite" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UpdateIsFavoriteResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="UpdateIsFavoriteResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AddSecret">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretTypeId" type="s:int" />
            <s:element minOccurs="0" maxOccurs="1" name="secretName" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="secretFieldIds" type="tns:ArrayOfInt" />
            <s:element minOccurs="0" maxOccurs="1" name="secretItemValues" type="tns:ArrayOfString" />
            <s:element minOccurs="1" maxOccurs="1" name="folderId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AddSecretResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AddSecretResult" type="tns:AddSecretResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="AddSecretResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="Secret" type="tns:Secret" />
        </s:sequence>
      </s:complexType>
      <s:element name="AddNewSecret">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="secret" type="tns:Secret" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AddNewSecretResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AddNewSecretResult" type="tns:AddSecretResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetNewSecret">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretTypeId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="folderId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetNewSecretResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetNewSecretResult" type="tns:GetSecretResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretTemplateFields">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretTypeId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretTemplateFieldsResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSecretTemplateFieldsResult" type="tns:GetSecretTemplateFieldsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetSecretTemplateFieldsResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="Fields" type="tns:ArrayOfSecretField" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSecretField">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SecretField" nillable="true" type="tns:SecretField" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SecretField">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="DisplayName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="Id" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="IsPassword" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="IsUrl" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="IsNotes" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="IsFile" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:element name="UpdateSecret">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="secret" type="tns:Secret" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UpdateSecretResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="UpdateSecretResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretTemplates">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretTemplatesResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSecretTemplatesResult" type="tns:GetSecretTemplatesResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetSecretTemplatesResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretTemplates" type="tns:ArrayOfSecretTemplate" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSecretTemplate">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SecretTemplate" nillable="true" type="tns:SecretTemplate" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SecretTemplate">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="Id" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Fields" type="tns:ArrayOfSecretField" />
        </s:sequence>
      </s:complexType>
      <s:element name="GeneratePassword">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretFieldId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GeneratePasswordResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GeneratePasswordResult" type="tns:GeneratePasswordResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GeneratePasswordResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="GeneratedPassword" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
        </s:sequence>
      </s:complexType>
      <s:element name="DeactivateSecret">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="DeactivateSecretResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="DeactivateSecretResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="VersionGet">
        <s:complexType />
      </s:element>
      <s:element name="VersionGetResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="VersionGetResult" type="tns:VersionGetResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="VersionGetResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="Version" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="FolderGet">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="folderId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="FolderGetResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="FolderGetResult" type="tns:GetFolderResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetFolderResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Folder" type="tns:Folder" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="1" maxOccurs="1" name="Success" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="Folder">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="Id" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="TypeId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="ParentFolderId" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:element name="FolderUpdate">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="modifiedFolder" type="tns:Folder" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="FolderUpdateResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="FolderUpdateResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="FolderGetAllChildren">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="parentFolderId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="FolderGetAllChildrenResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="FolderGetAllChildrenResult" type="tns:GetFoldersResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetFoldersResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Folders" type="tns:ArrayOfFolder" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="1" maxOccurs="1" name="Success" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfFolder">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="Folder" nillable="true" type="tns:Folder" />
        </s:sequence>
      </s:complexType>
      <s:element name="FolderCreate">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="folderName" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="parentFolderId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="folderTypeId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="FolderCreateResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="FolderCreateResult" type="tns:CreateFolderResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="CreateFolderResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:WebServiceResult">
            <s:sequence>
              <s:element minOccurs="1" maxOccurs="1" name="FolderId" type="s:int" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="FolderExtendedCreate">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="folder" type="tns:FolderExtended" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="FolderExtended">
        <s:complexContent mixed="false">
          <s:extension base="tns:Folder">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="PermissionSettings" type="tns:FolderPermissions" />
              <s:element minOccurs="0" maxOccurs="1" name="Settings" type="tns:FolderSettings" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="FolderPermissions">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="IsChangeToPermissions" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="InheritPermissionsEnabled" nillable="true" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="Permissions" type="tns:ArrayOfFolderPermission" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfFolderPermission">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="FolderPermission" nillable="true" type="tns:FolderPermission" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="FolderPermission">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="UserOrGroup" type="tns:GroupOrUserRecord" />
          <s:element minOccurs="0" maxOccurs="1" name="FolderAccessRoleName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="FolderAccessRoleId" nillable="true" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretAccessRoleName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretAccessRoleId" nillable="true" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="FolderSettings">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="IsChangeToSettings" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="InheritSecretPolicy" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretPolicyId" nillable="true" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:element name="FolderExtendedCreateResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="FolderExtendedCreateResult" type="tns:FolderExtendedCreateResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="FolderExtendedCreateResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:FolderExtendedResultBase">
            <s:sequence>
              <s:element minOccurs="1" maxOccurs="1" name="FolderId" type="s:int" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="FolderExtendedResultBase">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="Success" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
        </s:sequence>
      </s:complexType>
      <s:element name="FolderExtendedGet">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="folderId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="FolderExtendedGetResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="FolderExtendedGetResult" type="tns:FolderExtendedGetResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="FolderExtendedGetResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:FolderExtendedResultBase">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="Folder" type="tns:FolderExtended" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="FolderExtendedUpdate">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="folder" type="tns:FolderExtended" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="FolderExtendedUpdateResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="FolderExtendedUpdateResult" type="tns:FolderExtendedUpdateResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="FolderExtendedUpdateResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:FolderExtendedResultBase" />
        </s:complexContent>
      </s:complexType>
      <s:element name="FolderExtendedGetNew">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="folderExtendedGetNewRequest" type="tns:FolderExtendedGetNewRequest" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="FolderExtendedGetNewRequest">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="FolderName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="ParentFolderId" nillable="true" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="InheritPermissions" nillable="true" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:element name="FolderExtendedGetNewResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="FolderExtendedGetNewResult" type="tns:FolderExtendedGetNewResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="FolderExtendedGetNewResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:FolderExtendedResultBase">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="Folder" type="tns:FolderExtended" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="SearchFolders">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="folderName" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchFoldersResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchFoldersResult" type="tns:SearchFolderResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SearchFolderResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="Folders" type="tns:ArrayOfFolder" />
        </s:sequence>
      </s:complexType>
      <s:element name="DownloadFileAttachment">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="DownloadFileAttachmentResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="DownloadFileAttachmentResult" type="tns:FileDownloadResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="FileDownloadResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:WebServiceResult">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="FileAttachment" type="s:base64Binary" />
              <s:element minOccurs="0" maxOccurs="1" name="FileName" type="s:string" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="DownloadFileAttachmentByItemId">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="secretItemId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="DownloadFileAttachmentByItemIdResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="DownloadFileAttachmentByItemIdResult" type="tns:FileDownloadResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UploadFileAttachment">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="0" maxOccurs="1" name="fileData" type="s:base64Binary" />
            <s:element minOccurs="0" maxOccurs="1" name="fileName" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UploadFileAttachmentResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="UploadFileAttachmentResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UploadFileAttachmentByItemId">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="secretItemId" type="s:int" />
            <s:element minOccurs="0" maxOccurs="1" name="fileData" type="s:base64Binary" />
            <s:element minOccurs="0" maxOccurs="1" name="fileName" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UploadFileAttachmentByItemIdResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="UploadFileAttachmentByItemIdResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="ExpireSecret">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="ExpireSecretResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="ExpireSecretResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SetCheckOutEnabled">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="setCheckOut" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="setPasswordChangeOnCheckIn" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="checkOutInterval" nillable="true" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SetCheckOutEnabledResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SetCheckOutEnabledResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="ImportXML">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="xml" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="ImportXMLResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="ImportXMLResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretAudit">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretAuditResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSecretAuditResult" type="tns:GetSecretAuditResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetSecretAuditResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretAudits" type="tns:ArrayOfAuditSecret" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfAuditSecret">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="AuditSecret" nillable="true" type="tns:AuditSecret" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="AuditSecret">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="AuditSecretId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="DateRecorded" type="s:dateTime" />
          <s:element minOccurs="0" maxOccurs="1" name="Action" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Notes" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="UserId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="IpAddress" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="ReferenceId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="ByUserDisplayName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="TicketNumber" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="AddDependency">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="dependency" type="tns:Dependency" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="Dependency">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SecretId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretDependencyTypeId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="MachineName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="ServiceName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="PrivilegedAccountSecretId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="Active" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="RestartOnPasswordChange" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="WaitBeforeSeconds" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="AdditionalInfo" type="tns:AdditionalDependencyInfoJson" />
          <s:element minOccurs="0" maxOccurs="1" name="Description" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="ScriptId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretDependencyId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SSHKeySecretId" nillable="true" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="AdditionalDependencyInfoJson">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Regex" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="PowershellArguments" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="SshArguments" type="tns:ArrayOfSshScriptArgument" />
          <s:element minOccurs="0" maxOccurs="1" name="SqlArguments" type="tns:ArrayOfSqlScriptArgument" />
          <s:element minOccurs="0" maxOccurs="1" name="OdbcConnectionArguments" type="tns:ArrayOfOdbcConnectionArg" />
          <s:element minOccurs="0" maxOccurs="1" name="Port" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Database" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="ServerKeyDigest" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSshScriptArgument">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SshScriptArgument" nillable="true" type="tns:SshScriptArgument" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SshScriptArgument">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Value" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="SshType" type="tns:SshArgumentType" />
        </s:sequence>
      </s:complexType>
      <s:simpleType name="SshArgumentType">
        <s:restriction base="s:string">
          <s:enumeration value="Interpreted" />
          <s:enumeration value="Literal" />
        </s:restriction>
      </s:simpleType>
      <s:complexType name="ArrayOfSqlScriptArgument">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SqlScriptArgument" nillable="true" type="tns:SqlScriptArgument" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SqlScriptArgument">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Value" />
          <s:element minOccurs="1" maxOccurs="1" name="DbType" type="tns:DbType" />
        </s:sequence>
      </s:complexType>
      <s:simpleType name="DbType">
        <s:restriction base="s:string">
          <s:enumeration value="AnsiString" />
          <s:enumeration value="Binary" />
          <s:enumeration value="Byte" />
          <s:enumeration value="Boolean" />
          <s:enumeration value="Currency" />
          <s:enumeration value="Date" />
          <s:enumeration value="DateTime" />
          <s:enumeration value="Decimal" />
          <s:enumeration value="Double" />
          <s:enumeration value="Guid" />
          <s:enumeration value="Int16" />
          <s:enumeration value="Int32" />
          <s:enumeration value="Int64" />
          <s:enumeration value="Object" />
          <s:enumeration value="SByte" />
          <s:enumeration value="Single" />
          <s:enumeration value="String" />
          <s:enumeration value="Time" />
          <s:enumeration value="UInt16" />
          <s:enumeration value="UInt32" />
          <s:enumeration value="UInt64" />
          <s:enumeration value="VarNumeric" />
          <s:enumeration value="AnsiStringFixedLength" />
          <s:enumeration value="StringFixedLength" />
          <s:enumeration value="Xml" />
          <s:enumeration value="DateTime2" />
          <s:enumeration value="DateTimeOffset" />
        </s:restriction>
      </s:simpleType>
      <s:complexType name="ArrayOfOdbcConnectionArg">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="OdbcConnectionArg" nillable="true" type="tns:OdbcConnectionArg" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="OdbcConnectionArg">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Value" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="AddDependencyResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AddDependencyResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="RemoveDependency">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="dependencyId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="RemoveDependencyResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="RemoveDependencyResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetDependencies">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetDependenciesResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Dependencies" type="tns:ArrayOfDependency" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="1" maxOccurs="1" name="Success" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfDependency">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="Dependency" nillable="true" type="tns:Dependency" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetDependenciesResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetDependenciesResult" type="tns:GetDependenciesResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetDistributedEngines">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetSitesResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Sites" type="tns:ArrayOfSite" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="1" maxOccurs="1" name="Success" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSite">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="Site" nillable="true" type="tns:Site" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="Site">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SiteId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="OrganizationId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="SymmetricKey" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="SymmetricKeyIV" type="s:base64Binary" />
          <s:element minOccurs="0" maxOccurs="1" name="InitializationVector" type="s:base64Binary" />
          <s:element minOccurs="0" maxOccurs="1" name="SiteName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="Active" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="HeartbeatInterval" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="UseWebSite" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="SystemSite" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="LastModifiedDate" type="s:dateTime" />
          <s:element minOccurs="0" maxOccurs="1" name="WinRMEndpoint" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="EnableCredSSPForWinRM" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="SiteConnectorId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="SiteConnector" type="tns:SiteConnector" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SiteConnector">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SiteConnectorId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="SiteConnectorName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="QueueType" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="HostName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="Port" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="Active" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="Validated" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="UseSsl" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="SslCertificateThumbprint" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="LastModifiedDate" type="s:dateTime" />
          <s:element minOccurs="0" maxOccurs="1" name="UserName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="PasswordIV" type="s:base64Binary" />
          <s:element minOccurs="0" maxOccurs="1" name="Version" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetDistributedEnginesResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetDistributedEnginesResult" type="tns:GetSitesResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetTicketSystems">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetTicketSystemsResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="TicketSystems" type="tns:ArrayOfTicketSystem" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="1" maxOccurs="1" name="Success" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfTicketSystem">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="TicketSystem" nillable="true" type="tns:TicketSystem" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="TicketSystem">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="TicketSystemId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Description" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="IsDefault" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetTicketSystemsResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetTicketSystemsResult" type="tns:GetTicketSystemsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AssignSite">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="siteId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AssignSiteResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AssignSiteResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="CheckIn">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="CheckInResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="CheckInResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AddSecretCustomAudit">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="0" maxOccurs="1" name="notes" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="ipAddress" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="referenceId" nillable="true" type="s:int" />
            <s:element minOccurs="0" maxOccurs="1" name="ticketNumber" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="userId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AddSecretCustomAuditResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AddSecretCustomAuditResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UpdateSecretPermission">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="0" maxOccurs="1" name="groupOrUserRecord" type="tns:GroupOrUserRecord" />
            <s:element minOccurs="1" maxOccurs="1" name="view" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="edit" type="s:boolean" />
            <s:element minOccurs="1" maxOccurs="1" name="owner" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UpdateSecretPermissionResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="UpdateSecretPermissionResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="CheckInByKey">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="sessionKey" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="CheckInByKeyResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="CheckInByKeyResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="WhoAmI">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="UserInfoResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="DisplayName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="UserName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="KnownAs" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="UserId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="DomainId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="DomainName" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="WhoAmIResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="WhoAmIResult" type="tns:UserInfoResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetAllGroups">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetAllGroupsResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="0" maxOccurs="1" name="Groups" type="tns:ArrayOfGroup" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfGroup">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="Group" nillable="true" type="tns:Group" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="Group">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="Id" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="DomainId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="DomainName" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetAllGroupsResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetAllGroupsResult" type="tns:GetAllGroupsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AssignUserToGroup">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="userId" type="s:int" />
            <s:element minOccurs="1" maxOccurs="1" name="groupId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AssignUserToGroupResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AssignUserToGroupResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSSHLoginCredentials">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSSHLoginCredentialsResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSSHLoginCredentialsResult" type="tns:SSHCredentialsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SSHCredentialsResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:WebServiceResult">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="Username" type="s:string" />
              <s:element minOccurs="0" maxOccurs="1" name="Password" type="s:string" />
              <s:element minOccurs="0" maxOccurs="1" name="Host" type="s:string" />
              <s:element minOccurs="0" maxOccurs="1" name="Port" type="s:string" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="GetSSHLoginCredentialsWithMachine">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="0" maxOccurs="1" name="machine" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSSHLoginCredentialsWithMachineResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSSHLoginCredentialsWithMachineResult" type="tns:SSHCredentialsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchUsers">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="searchTerm" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="includeInactiveUsers" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetUsersResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Users" type="tns:ArrayOfUser" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfUser">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="User" nillable="true" type="tns:User" />
        </s:sequence>
      </s:complexType>
      <s:element name="SearchUsersResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchUsersResult" type="tns:GetUsersResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetUser">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="userId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetUserResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="User" type="tns:User" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetUserResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetUserResult" type="tns:GetUserResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UpdateUser">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="user" type="tns:User" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="UpdateUserResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="User" type="tns:User" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
        </s:sequence>
      </s:complexType>
      <s:element name="UpdateUserResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="UpdateUserResult" type="tns:UpdateUserResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretItemHistoryByFieldName">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
            <s:element minOccurs="0" maxOccurs="1" name="fieldDisplayName" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SecretItemHistoryResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
          <s:element minOccurs="1" maxOccurs="1" name="Success" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretItemHistories" type="tns:ArrayOfSecretItemHistoryWebServiceResult" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSecretItemHistoryWebServiceResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SecretItemHistoryWebServiceResult" nillable="true" type="tns:SecretItemHistoryWebServiceResult" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SecretItemHistoryWebServiceResult">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SecretItemHistoryId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="UserId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretItemId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="Date" type="s:dateTime" />
          <s:element minOccurs="0" maxOccurs="1" name="ItemValueNew" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="ItemValueNew2" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetSecretItemHistoryByFieldNameResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSecretItemHistoryByFieldNameResult" type="tns:SecretItemHistoryResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSecretPolicyForSecret">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="secretId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SecretPolicyForSecret">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SecretId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretPolicyId" nillable="true" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="Inherit" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetSecretPolicyForSecretResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSecretPolicyForSecretResult" type="tns:SecretPolicyForSecretResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SecretPolicyForSecretResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:WebServiceResult">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="SecretPolicyForSecret" type="tns:SecretPolicyForSecret" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="AssignSecretPolicyForSecret">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="secretPolicyForSecret" type="tns:SecretPolicyForSecret" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AssignSecretPolicyForSecretResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AssignSecretPolicyForSecretResult" type="tns:SecretPolicyForSecretResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SearchSecretPolicies">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="term" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="includeInactive" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SecretPolicySummary">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SecretPolicyId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretPolicyName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="SecretPolicyDescription" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="Active" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSecretPolicySummary">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SecretPolicySummary" nillable="true" type="tns:SecretPolicySummary" />
        </s:sequence>
      </s:complexType>
      <s:element name="SearchSecretPoliciesResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SearchSecretPoliciesResult" type="tns:SearchSecretPoliciesResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SearchSecretPoliciesResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:WebServiceResult">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="SecretPolicies" type="tns:ArrayOfSecretPolicySummary" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="RunActiveDirectorySynchronization">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="RunActiveDirectorySynchronizationResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="RunActiveDirectorySynchronizationResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AddGroupToActiveDirectorySynchronization">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="addGroupRequestMessage" type="tns:AddGroupRequestMessage" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="AddGroupRequestMessage">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="GroupName" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="DomainId" nillable="true" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="DomainName" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="AddGroupToActiveDirectorySynchronizationResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AddGroupToActiveDirectorySynchronizationResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AddSecretPolicy">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="secretPolicy" type="tns:SecretPolicyDetail" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SecretPolicyDetail">
        <s:complexContent mixed="false">
          <s:extension base="tns:SecretPolicySummary">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="SecretPolicyItems" type="tns:ArrayOfSecretPolicyItem" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="ArrayOfSecretPolicyItem">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SecretPolicyItem" nillable="true" type="tns:SecretPolicyItem" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SecretPolicyItem">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SecretPolicyItemMapId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretPolicyItemId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="PolicyApplyCode" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="EnabledValue" nillable="true" type="s:boolean" />
          <s:element minOccurs="1" maxOccurs="1" name="IntegerValue" nillable="true" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="SecretId" nillable="true" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="StringValue" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Description" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="ValueType" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="ParentSecretPolicyItemId" nillable="true" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="SectionName" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="UserGroupMaps" type="tns:ArrayOfUserGroupMap" />
          <s:element minOccurs="0" maxOccurs="1" name="SshCommandMenuGroupMaps" type="tns:ArrayOfSshCommandMenuGroupMap" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfUserGroupMap">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="UserGroupMap" nillable="true" type="tns:UserGroupMap" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="UserGroupMap">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="Id" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="UserGroupMapType" type="tns:UserGroupMapType" />
        </s:sequence>
      </s:complexType>
      <s:simpleType name="UserGroupMapType">
        <s:restriction base="s:string">
          <s:enumeration value="User" />
          <s:enumeration value="Group" />
        </s:restriction>
      </s:simpleType>
      <s:complexType name="ArrayOfSshCommandMenuGroupMap">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SshCommandMenuGroupMap" nillable="true" type="tns:SshCommandMenuGroupMap" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SshCommandMenuGroupMap">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SshCommandMenuId" nillable="true" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="UserGroupMap" type="tns:UserGroupMap" />
        </s:sequence>
      </s:complexType>
      <s:element name="AddSecretPolicyResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AddSecretPolicyResult" type="tns:SecretPolicyResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="SecretPolicyResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:WebServiceResult">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="SecretPolicy" type="tns:SecretPolicyDetail" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="GetNewSecretPolicy">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetNewSecretPolicyResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetNewSecretPolicyResult" type="tns:SecretPolicyResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetSSHCommandMenu">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="sshCommandMenuId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetSshCommandMenuResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="SshCommandMenu" type="tns:SshCommandMenu" />
          <s:element minOccurs="0" maxOccurs="1" name="SshCommands" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SshCommandMenu">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="SshCommandMenuId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="Active" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="Description" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetSSHCommandMenuResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetSSHCommandMenuResult" type="tns:GetSshCommandMenuResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SaveSSHCommandMenu">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="sshCommandMenu" type="tns:SshCommandMenu" />
            <s:element minOccurs="0" maxOccurs="1" name="commandsText" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="deleteCommands" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="SaveSSHCommandMenuResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SaveSSHCommandMenuResult" type="tns:GetSshCommandMenuResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetAllSSHCommandMenus">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="includeInactive" nillable="true" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetSshCommandMenusResult">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="SshCommandMenus" type="tns:ArrayOfSshCommandMenu" />
          <s:element minOccurs="0" maxOccurs="1" name="Errors" type="tns:ArrayOfString" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSshCommandMenu">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SshCommandMenu" nillable="true" type="tns:SshCommandMenu" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetAllSSHCommandMenusResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetAllSSHCommandMenusResult" type="tns:GetSshCommandMenusResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="DeleteSSHCommandMenu">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="sshCommandMenuId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="DeleteSSHCommandMenuResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="DeleteSSHCommandMenuResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="RestoreSSHCommandMenu">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="sshCommandMenuId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="RestoreSSHCommandMenuResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="RestoreSSHCommandMenuResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="AddScript">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="newUserScript" type="tns:UserScript" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="UserScript" abstract="true">
        <s:sequence>
          <s:element minOccurs="1" maxOccurs="1" name="ScriptId" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Description" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Script" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="Active" type="s:boolean" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="PowerShellUserScript">
        <s:complexContent mixed="false">
          <s:extension base="tns:UserScript" />
        </s:complexContent>
      </s:complexType>
      <s:complexType name="SqlUserScript">
        <s:complexContent mixed="false">
          <s:extension base="tns:UserScript">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="AdditionalDataObject" type="tns:AdditionalDataSqlObject" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="AdditionalDataSqlObject">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Params" type="tns:ArrayOfSqlScriptArgument2" />
          <s:element minOccurs="1" maxOccurs="1" name="PasswordChangerId" type="s:int" />
          <s:element minOccurs="1" maxOccurs="1" name="Version" type="s:int" />
          <s:element minOccurs="0" maxOccurs="1" name="Database" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Port" type="s:string" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfSqlScriptArgument2">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SqlScriptArgument2" nillable="true" type="tns:SqlScriptArgument2" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SqlScriptArgument2">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Value" />
          <s:element minOccurs="1" maxOccurs="1" name="DbType" type="tns:DbType" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SshUserScript">
        <s:complexContent mixed="false">
          <s:extension base="tns:UserScript">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="AdditionalDataObject" type="tns:AdditionalDataSshObject" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="AdditionalDataSshObject">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Port" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="LineEnding" type="tns:LineEnding" />
          <s:element minOccurs="1" maxOccurs="1" name="DoNotUseEnvironment" type="s:boolean" />
          <s:element minOccurs="0" maxOccurs="1" name="Params" type="tns:ArrayOfSshScriptArgument2" />
          <s:element minOccurs="1" maxOccurs="1" name="Version" type="s:int" />
        </s:sequence>
      </s:complexType>
      <s:simpleType name="LineEnding">
        <s:restriction base="s:string">
          <s:enumeration value="NewLine" />
          <s:enumeration value="CarriageReturn" />
          <s:enumeration value="CarriageReturnNewLine" />
        </s:restriction>
      </s:simpleType>
      <s:complexType name="ArrayOfSshScriptArgument2">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="SshScriptArgument2" nillable="true" type="tns:SshScriptArgument2" />
        </s:sequence>
      </s:complexType>
      <s:complexType name="SshScriptArgument2">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="Name" type="s:string" />
          <s:element minOccurs="0" maxOccurs="1" name="Value" type="s:string" />
          <s:element minOccurs="1" maxOccurs="1" name="SshType" type="tns:SshArgumentType2" />
        </s:sequence>
      </s:complexType>
      <s:simpleType name="SshArgumentType2">
        <s:restriction base="s:string">
          <s:enumeration value="Interpreted" />
          <s:enumeration value="Literal" />
        </s:restriction>
      </s:simpleType>
      <s:element name="AddScriptResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="AddScriptResult" type="tns:WebServiceResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetAllScripts">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="includeInactiveUserScripts" type="s:boolean" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="ArrayOfUserScript">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="UserScript" nillable="true" type="tns:UserScript" />
        </s:sequence>
      </s:complexType>
      <s:element name="GetAllScriptsResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetAllScriptsResult" type="tns:GetUserScriptsResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetUserScriptsResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:WebServiceResult">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="UserScripts" type="tns:ArrayOfUserScript" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="GetScript">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="1" maxOccurs="1" name="userScriptId" type="s:int" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="GetScriptResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="GetScriptResult" type="tns:GetUserScriptResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="GetUserScriptResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:WebServiceResult">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="UserScript" type="tns:UserScript" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="UpdateScript">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="token" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="userScript" type="tns:UserScript" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="UpdateScriptResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="UpdateScriptResult" type="tns:UpdateUserScriptResult" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="UpdateUserScriptResult">
        <s:complexContent mixed="false">
          <s:extension base="tns:WebServiceResult">
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="UserScript" type="tns:UserScript" />
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="RequestApprovalResult" nillable="true" type="tns:RequestApprovalResult" />
      <s:element name="AuthenticateResult" nillable="true" type="tns:AuthenticateResult" />
      <s:element name="ImpersonateResult" nillable="true" type="tns:ImpersonateResult" />
      <s:element name="TokenIsValidResult" nillable="true" type="tns:TokenIsValidResult" />
      <s:element name="GetSecretResult" nillable="true" type="tns:GetSecretResult" />
      <s:element name="GetCheckOutStatusResult" nillable="true" type="tns:GetCheckOutStatusResult" />
      <s:element name="WebServiceResult" nillable="true" type="tns:WebServiceResult" />
      <s:element name="GetSecretsByFieldValueResult" nillable="true" type="tns:GetSecretsByFieldValueResult" />
      <s:element name="SearchSecretsResult" nillable="true" type="tns:SearchSecretsResult" />
      <s:element name="GetFavoritesResult" nillable="true" type="tns:GetFavoritesResult" />
      <s:element name="AddSecretResult" nillable="true" type="tns:AddSecretResult" />
      <s:element name="GetSecretTemplateFieldsResult" nillable="true" type="tns:GetSecretTemplateFieldsResult" />
      <s:element name="GetSecretTemplatesResult" nillable="true" type="tns:GetSecretTemplatesResult" />
      <s:element name="GeneratePasswordResult" nillable="true" type="tns:GeneratePasswordResult" />
      <s:element name="VersionGetResult" nillable="true" type="tns:VersionGetResult" />
      <s:element name="GetFolderResult" nillable="true" type="tns:GetFolderResult" />
      <s:element name="GetFoldersResult" nillable="true" type="tns:GetFoldersResult" />
      <s:element name="CreateFolderResult" nillable="true" type="tns:CreateFolderResult" />
      <s:element name="FolderExtendedGetResult" nillable="true" type="tns:FolderExtendedGetResult" />
      <s:element name="SearchFolderResult" nillable="true" type="tns:SearchFolderResult" />
      <s:element name="FileDownloadResult" nillable="true" type="tns:FileDownloadResult" />
      <s:element name="GetSecretAuditResult" nillable="true" type="tns:GetSecretAuditResult" />
      <s:element name="GetDependenciesResult" nillable="true" type="tns:GetDependenciesResult" />
      <s:element name="GetSitesResult" nillable="true" type="tns:GetSitesResult" />
      <s:element name="GetTicketSystemsResult" nillable="true" type="tns:GetTicketSystemsResult" />
      <s:element name="UserInfoResult" nillable="true" type="tns:UserInfoResult" />
      <s:element name="GetAllGroupsResult" nillable="true" type="tns:GetAllGroupsResult" />
      <s:element name="SSHCredentialsResult" nillable="true" type="tns:SSHCredentialsResult" />
      <s:element name="GetUsersResult" nillable="true" type="tns:GetUsersResult" />
      <s:element name="GetUserResult" nillable="true" type="tns:GetUserResult" />
      <s:element name="SecretItemHistoryResult" nillable="true" type="tns:SecretItemHistoryResult" />
      <s:element name="SecretPolicyForSecretResult" nillable="true" type="tns:SecretPolicyForSecretResult" />
      <s:element name="SearchSecretPoliciesResult" nillable="true" type="tns:SearchSecretPoliciesResult" />
      <s:element name="SecretPolicyResult" nillable="true" type="tns:SecretPolicyResult" />
      <s:element name="GetSshCommandMenuResult" nillable="true" type="tns:GetSshCommandMenuResult" />
      <s:element name="GetUserScriptsResult" nillable="true" type="tns:GetUserScriptsResult" />
      <s:element name="GetUserScriptResult" nillable="true" type="tns:GetUserScriptResult" />
    </s:schema>
  </wsdl:types>
  <wsdl:message name="ApproveSecretAccessRequestSoapIn">
    <wsdl:part name="parameters" element="tns:ApproveSecretAccessRequest" />
  </wsdl:message>
  <wsdl:message name="ApproveSecretAccessRequestSoapOut">
    <wsdl:part name="parameters" element="tns:ApproveSecretAccessRequestResponse" />
  </wsdl:message>
  <wsdl:message name="DenySecretAccessRequestSoapIn">
    <wsdl:part name="parameters" element="tns:DenySecretAccessRequest" />
  </wsdl:message>
  <wsdl:message name="DenySecretAccessRequestSoapOut">
    <wsdl:part name="parameters" element="tns:DenySecretAccessRequestResponse" />
  </wsdl:message>
  <wsdl:message name="AuthenticateSoapIn">
    <wsdl:part name="parameters" element="tns:Authenticate" />
  </wsdl:message>
  <wsdl:message name="AuthenticateSoapOut">
    <wsdl:part name="parameters" element="tns:AuthenticateResponse" />
  </wsdl:message>
  <wsdl:message name="ImpersonateUserSoapIn">
    <wsdl:part name="parameters" element="tns:ImpersonateUser" />
  </wsdl:message>
  <wsdl:message name="ImpersonateUserSoapOut">
    <wsdl:part name="parameters" element="tns:ImpersonateUserResponse" />
  </wsdl:message>
  <wsdl:message name="AuthenticateRADIUSSoapIn">
    <wsdl:part name="parameters" element="tns:AuthenticateRADIUS" />
  </wsdl:message>
  <wsdl:message name="AuthenticateRADIUSSoapOut">
    <wsdl:part name="parameters" element="tns:AuthenticateRADIUSResponse" />
  </wsdl:message>
  <wsdl:message name="GetTokenIsValidSoapIn">
    <wsdl:part name="parameters" element="tns:GetTokenIsValid" />
  </wsdl:message>
  <wsdl:message name="GetTokenIsValidSoapOut">
    <wsdl:part name="parameters" element="tns:GetTokenIsValidResponse" />
  </wsdl:message>
  <wsdl:message name="GetSecretLegacySoapIn">
    <wsdl:part name="parameters" element="tns:GetSecretLegacy" />
  </wsdl:message>
  <wsdl:message name="GetSecretLegacySoapOut">
    <wsdl:part name="parameters" element="tns:GetSecretLegacyResponse" />
  </wsdl:message>
  <wsdl:message name="GetSecretSoapIn">
    <wsdl:part name="parameters" element="tns:GetSecret" />
  </wsdl:message>
  <wsdl:message name="GetSecretSoapOut">
    <wsdl:part name="parameters" element="tns:GetSecretResponse" />
  </wsdl:message>
  <wsdl:message name="GetCheckOutStatusSoapIn">
    <wsdl:part name="parameters" element="tns:GetCheckOutStatus" />
  </wsdl:message>
  <wsdl:message name="GetCheckOutStatusSoapOut">
    <wsdl:part name="parameters" element="tns:GetCheckOutStatusResponse" />
  </wsdl:message>
  <wsdl:message name="ChangePasswordSoapIn">
    <wsdl:part name="parameters" element="tns:ChangePassword" />
  </wsdl:message>
  <wsdl:message name="ChangePasswordSoapOut">
    <wsdl:part name="parameters" element="tns:ChangePasswordResponse" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByFieldValueSoapIn">
    <wsdl:part name="parameters" element="tns:GetSecretsByFieldValue" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByFieldValueSoapOut">
    <wsdl:part name="parameters" element="tns:GetSecretsByFieldValueResponse" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFieldValueSoapIn">
    <wsdl:part name="parameters" element="tns:SearchSecretsByFieldValue" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFieldValueSoapOut">
    <wsdl:part name="parameters" element="tns:SearchSecretsByFieldValueResponse" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByExposedFieldValueSoapIn">
    <wsdl:part name="parameters" element="tns:GetSecretsByExposedFieldValue" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByExposedFieldValueSoapOut">
    <wsdl:part name="parameters" element="tns:GetSecretsByExposedFieldValueResponse" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedFieldValueSoapIn">
    <wsdl:part name="parameters" element="tns:SearchSecretsByExposedFieldValue" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedFieldValueSoapOut">
    <wsdl:part name="parameters" element="tns:SearchSecretsByExposedFieldValueResponse" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedValuesSoapIn">
    <wsdl:part name="parameters" element="tns:SearchSecretsByExposedValues" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedValuesSoapOut">
    <wsdl:part name="parameters" element="tns:SearchSecretsByExposedValuesResponse" />
  </wsdl:message>
  <wsdl:message name="AddUserSoapIn">
    <wsdl:part name="parameters" element="tns:AddUser" />
  </wsdl:message>
  <wsdl:message name="AddUserSoapOut">
    <wsdl:part name="parameters" element="tns:AddUserResponse" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsSoapIn">
    <wsdl:part name="parameters" element="tns:SearchSecrets" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsSoapOut">
    <wsdl:part name="parameters" element="tns:SearchSecretsResponse" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsLegacySoapIn">
    <wsdl:part name="parameters" element="tns:SearchSecretsLegacy" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsLegacySoapOut">
    <wsdl:part name="parameters" element="tns:SearchSecretsLegacyResponse" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFolderSoapIn">
    <wsdl:part name="parameters" element="tns:SearchSecretsByFolder" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFolderSoapOut">
    <wsdl:part name="parameters" element="tns:SearchSecretsByFolderResponse" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFolderLegacySoapIn">
    <wsdl:part name="parameters" element="tns:SearchSecretsByFolderLegacy" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFolderLegacySoapOut">
    <wsdl:part name="parameters" element="tns:SearchSecretsByFolderLegacyResponse" />
  </wsdl:message>
  <wsdl:message name="GetFavoritesSoapIn">
    <wsdl:part name="parameters" element="tns:GetFavorites" />
  </wsdl:message>
  <wsdl:message name="GetFavoritesSoapOut">
    <wsdl:part name="parameters" element="tns:GetFavoritesResponse" />
  </wsdl:message>
  <wsdl:message name="UpdateIsFavoriteSoapIn">
    <wsdl:part name="parameters" element="tns:UpdateIsFavorite" />
  </wsdl:message>
  <wsdl:message name="UpdateIsFavoriteSoapOut">
    <wsdl:part name="parameters" element="tns:UpdateIsFavoriteResponse" />
  </wsdl:message>
  <wsdl:message name="AddSecretSoapIn">
    <wsdl:part name="parameters" element="tns:AddSecret" />
  </wsdl:message>
  <wsdl:message name="AddSecretSoapOut">
    <wsdl:part name="parameters" element="tns:AddSecretResponse" />
  </wsdl:message>
  <wsdl:message name="AddNewSecretSoapIn">
    <wsdl:part name="parameters" element="tns:AddNewSecret" />
  </wsdl:message>
  <wsdl:message name="AddNewSecretSoapOut">
    <wsdl:part name="parameters" element="tns:AddNewSecretResponse" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretSoapIn">
    <wsdl:part name="parameters" element="tns:GetNewSecret" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretSoapOut">
    <wsdl:part name="parameters" element="tns:GetNewSecretResponse" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplateFieldsSoapIn">
    <wsdl:part name="parameters" element="tns:GetSecretTemplateFields" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplateFieldsSoapOut">
    <wsdl:part name="parameters" element="tns:GetSecretTemplateFieldsResponse" />
  </wsdl:message>
  <wsdl:message name="UpdateSecretSoapIn">
    <wsdl:part name="parameters" element="tns:UpdateSecret" />
  </wsdl:message>
  <wsdl:message name="UpdateSecretSoapOut">
    <wsdl:part name="parameters" element="tns:UpdateSecretResponse" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplatesSoapIn">
    <wsdl:part name="parameters" element="tns:GetSecretTemplates" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplatesSoapOut">
    <wsdl:part name="parameters" element="tns:GetSecretTemplatesResponse" />
  </wsdl:message>
  <wsdl:message name="GeneratePasswordSoapIn">
    <wsdl:part name="parameters" element="tns:GeneratePassword" />
  </wsdl:message>
  <wsdl:message name="GeneratePasswordSoapOut">
    <wsdl:part name="parameters" element="tns:GeneratePasswordResponse" />
  </wsdl:message>
  <wsdl:message name="DeactivateSecretSoapIn">
    <wsdl:part name="parameters" element="tns:DeactivateSecret" />
  </wsdl:message>
  <wsdl:message name="DeactivateSecretSoapOut">
    <wsdl:part name="parameters" element="tns:DeactivateSecretResponse" />
  </wsdl:message>
  <wsdl:message name="VersionGetSoapIn">
    <wsdl:part name="parameters" element="tns:VersionGet" />
  </wsdl:message>
  <wsdl:message name="VersionGetSoapOut">
    <wsdl:part name="parameters" element="tns:VersionGetResponse" />
  </wsdl:message>
  <wsdl:message name="FolderGetSoapIn">
    <wsdl:part name="parameters" element="tns:FolderGet" />
  </wsdl:message>
  <wsdl:message name="FolderGetSoapOut">
    <wsdl:part name="parameters" element="tns:FolderGetResponse" />
  </wsdl:message>
  <wsdl:message name="FolderUpdateSoapIn">
    <wsdl:part name="parameters" element="tns:FolderUpdate" />
  </wsdl:message>
  <wsdl:message name="FolderUpdateSoapOut">
    <wsdl:part name="parameters" element="tns:FolderUpdateResponse" />
  </wsdl:message>
  <wsdl:message name="FolderGetAllChildrenSoapIn">
    <wsdl:part name="parameters" element="tns:FolderGetAllChildren" />
  </wsdl:message>
  <wsdl:message name="FolderGetAllChildrenSoapOut">
    <wsdl:part name="parameters" element="tns:FolderGetAllChildrenResponse" />
  </wsdl:message>
  <wsdl:message name="FolderCreateSoapIn">
    <wsdl:part name="parameters" element="tns:FolderCreate" />
  </wsdl:message>
  <wsdl:message name="FolderCreateSoapOut">
    <wsdl:part name="parameters" element="tns:FolderCreateResponse" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedCreateSoapIn">
    <wsdl:part name="parameters" element="tns:FolderExtendedCreate" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedCreateSoapOut">
    <wsdl:part name="parameters" element="tns:FolderExtendedCreateResponse" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedGetSoapIn">
    <wsdl:part name="parameters" element="tns:FolderExtendedGet" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedGetSoapOut">
    <wsdl:part name="parameters" element="tns:FolderExtendedGetResponse" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedUpdateSoapIn">
    <wsdl:part name="parameters" element="tns:FolderExtendedUpdate" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedUpdateSoapOut">
    <wsdl:part name="parameters" element="tns:FolderExtendedUpdateResponse" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedGetNewSoapIn">
    <wsdl:part name="parameters" element="tns:FolderExtendedGetNew" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedGetNewSoapOut">
    <wsdl:part name="parameters" element="tns:FolderExtendedGetNewResponse" />
  </wsdl:message>
  <wsdl:message name="SearchFoldersSoapIn">
    <wsdl:part name="parameters" element="tns:SearchFolders" />
  </wsdl:message>
  <wsdl:message name="SearchFoldersSoapOut">
    <wsdl:part name="parameters" element="tns:SearchFoldersResponse" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentSoapIn">
    <wsdl:part name="parameters" element="tns:DownloadFileAttachment" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentSoapOut">
    <wsdl:part name="parameters" element="tns:DownloadFileAttachmentResponse" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentByItemIdSoapIn">
    <wsdl:part name="parameters" element="tns:DownloadFileAttachmentByItemId" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentByItemIdSoapOut">
    <wsdl:part name="parameters" element="tns:DownloadFileAttachmentByItemIdResponse" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentSoapIn">
    <wsdl:part name="parameters" element="tns:UploadFileAttachment" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentSoapOut">
    <wsdl:part name="parameters" element="tns:UploadFileAttachmentResponse" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentByItemIdSoapIn">
    <wsdl:part name="parameters" element="tns:UploadFileAttachmentByItemId" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentByItemIdSoapOut">
    <wsdl:part name="parameters" element="tns:UploadFileAttachmentByItemIdResponse" />
  </wsdl:message>
  <wsdl:message name="ExpireSecretSoapIn">
    <wsdl:part name="parameters" element="tns:ExpireSecret" />
  </wsdl:message>
  <wsdl:message name="ExpireSecretSoapOut">
    <wsdl:part name="parameters" element="tns:ExpireSecretResponse" />
  </wsdl:message>
  <wsdl:message name="SetCheckOutEnabledSoapIn">
    <wsdl:part name="parameters" element="tns:SetCheckOutEnabled" />
  </wsdl:message>
  <wsdl:message name="SetCheckOutEnabledSoapOut">
    <wsdl:part name="parameters" element="tns:SetCheckOutEnabledResponse" />
  </wsdl:message>
  <wsdl:message name="ImportXMLSoapIn">
    <wsdl:part name="parameters" element="tns:ImportXML" />
  </wsdl:message>
  <wsdl:message name="ImportXMLSoapOut">
    <wsdl:part name="parameters" element="tns:ImportXMLResponse" />
  </wsdl:message>
  <wsdl:message name="GetSecretAuditSoapIn">
    <wsdl:part name="parameters" element="tns:GetSecretAudit" />
  </wsdl:message>
  <wsdl:message name="GetSecretAuditSoapOut">
    <wsdl:part name="parameters" element="tns:GetSecretAuditResponse" />
  </wsdl:message>
  <wsdl:message name="AddDependencySoapIn">
    <wsdl:part name="parameters" element="tns:AddDependency" />
  </wsdl:message>
  <wsdl:message name="AddDependencySoapOut">
    <wsdl:part name="parameters" element="tns:AddDependencyResponse" />
  </wsdl:message>
  <wsdl:message name="RemoveDependencySoapIn">
    <wsdl:part name="parameters" element="tns:RemoveDependency" />
  </wsdl:message>
  <wsdl:message name="RemoveDependencySoapOut">
    <wsdl:part name="parameters" element="tns:RemoveDependencyResponse" />
  </wsdl:message>
  <wsdl:message name="GetDependenciesSoapIn">
    <wsdl:part name="parameters" element="tns:GetDependencies" />
  </wsdl:message>
  <wsdl:message name="GetDependenciesSoapOut">
    <wsdl:part name="parameters" element="tns:GetDependenciesResponse" />
  </wsdl:message>
  <wsdl:message name="GetDistributedEnginesSoapIn">
    <wsdl:part name="parameters" element="tns:GetDistributedEngines" />
  </wsdl:message>
  <wsdl:message name="GetDistributedEnginesSoapOut">
    <wsdl:part name="parameters" element="tns:GetDistributedEnginesResponse" />
  </wsdl:message>
  <wsdl:message name="GetTicketSystemsSoapIn">
    <wsdl:part name="parameters" element="tns:GetTicketSystems" />
  </wsdl:message>
  <wsdl:message name="GetTicketSystemsSoapOut">
    <wsdl:part name="parameters" element="tns:GetTicketSystemsResponse" />
  </wsdl:message>
  <wsdl:message name="AssignSiteSoapIn">
    <wsdl:part name="parameters" element="tns:AssignSite" />
  </wsdl:message>
  <wsdl:message name="AssignSiteSoapOut">
    <wsdl:part name="parameters" element="tns:AssignSiteResponse" />
  </wsdl:message>
  <wsdl:message name="CheckInSoapIn">
    <wsdl:part name="parameters" element="tns:CheckIn" />
  </wsdl:message>
  <wsdl:message name="CheckInSoapOut">
    <wsdl:part name="parameters" element="tns:CheckInResponse" />
  </wsdl:message>
  <wsdl:message name="AddSecretCustomAuditSoapIn">
    <wsdl:part name="parameters" element="tns:AddSecretCustomAudit" />
  </wsdl:message>
  <wsdl:message name="AddSecretCustomAuditSoapOut">
    <wsdl:part name="parameters" element="tns:AddSecretCustomAuditResponse" />
  </wsdl:message>
  <wsdl:message name="UpdateSecretPermissionSoapIn">
    <wsdl:part name="parameters" element="tns:UpdateSecretPermission" />
  </wsdl:message>
  <wsdl:message name="UpdateSecretPermissionSoapOut">
    <wsdl:part name="parameters" element="tns:UpdateSecretPermissionResponse" />
  </wsdl:message>
  <wsdl:message name="CheckInByKeySoapIn">
    <wsdl:part name="parameters" element="tns:CheckInByKey" />
  </wsdl:message>
  <wsdl:message name="CheckInByKeySoapOut">
    <wsdl:part name="parameters" element="tns:CheckInByKeyResponse" />
  </wsdl:message>
  <wsdl:message name="WhoAmISoapIn">
    <wsdl:part name="parameters" element="tns:WhoAmI" />
  </wsdl:message>
  <wsdl:message name="WhoAmISoapOut">
    <wsdl:part name="parameters" element="tns:WhoAmIResponse" />
  </wsdl:message>
  <wsdl:message name="GetAllGroupsSoapIn">
    <wsdl:part name="parameters" element="tns:GetAllGroups" />
  </wsdl:message>
  <wsdl:message name="GetAllGroupsSoapOut">
    <wsdl:part name="parameters" element="tns:GetAllGroupsResponse" />
  </wsdl:message>
  <wsdl:message name="AssignUserToGroupSoapIn">
    <wsdl:part name="parameters" element="tns:AssignUserToGroup" />
  </wsdl:message>
  <wsdl:message name="AssignUserToGroupSoapOut">
    <wsdl:part name="parameters" element="tns:AssignUserToGroupResponse" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsSoapIn">
    <wsdl:part name="parameters" element="tns:GetSSHLoginCredentials" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsSoapOut">
    <wsdl:part name="parameters" element="tns:GetSSHLoginCredentialsResponse" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsWithMachineSoapIn">
    <wsdl:part name="parameters" element="tns:GetSSHLoginCredentialsWithMachine" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsWithMachineSoapOut">
    <wsdl:part name="parameters" element="tns:GetSSHLoginCredentialsWithMachineResponse" />
  </wsdl:message>
  <wsdl:message name="SearchUsersSoapIn">
    <wsdl:part name="parameters" element="tns:SearchUsers" />
  </wsdl:message>
  <wsdl:message name="SearchUsersSoapOut">
    <wsdl:part name="parameters" element="tns:SearchUsersResponse" />
  </wsdl:message>
  <wsdl:message name="GetUserSoapIn">
    <wsdl:part name="parameters" element="tns:GetUser" />
  </wsdl:message>
  <wsdl:message name="GetUserSoapOut">
    <wsdl:part name="parameters" element="tns:GetUserResponse" />
  </wsdl:message>
  <wsdl:message name="UpdateUserSoapIn">
    <wsdl:part name="parameters" element="tns:UpdateUser" />
  </wsdl:message>
  <wsdl:message name="UpdateUserSoapOut">
    <wsdl:part name="parameters" element="tns:UpdateUserResponse" />
  </wsdl:message>
  <wsdl:message name="GetSecretItemHistoryByFieldNameSoapIn">
    <wsdl:part name="parameters" element="tns:GetSecretItemHistoryByFieldName" />
  </wsdl:message>
  <wsdl:message name="GetSecretItemHistoryByFieldNameSoapOut">
    <wsdl:part name="parameters" element="tns:GetSecretItemHistoryByFieldNameResponse" />
  </wsdl:message>
  <wsdl:message name="GetSecretPolicyForSecretSoapIn">
    <wsdl:part name="parameters" element="tns:GetSecretPolicyForSecret" />
  </wsdl:message>
  <wsdl:message name="GetSecretPolicyForSecretSoapOut">
    <wsdl:part name="parameters" element="tns:GetSecretPolicyForSecretResponse" />
  </wsdl:message>
  <wsdl:message name="AssignSecretPolicyForSecretSoapIn">
    <wsdl:part name="parameters" element="tns:AssignSecretPolicyForSecret" />
  </wsdl:message>
  <wsdl:message name="AssignSecretPolicyForSecretSoapOut">
    <wsdl:part name="parameters" element="tns:AssignSecretPolicyForSecretResponse" />
  </wsdl:message>
  <wsdl:message name="SearchSecretPoliciesSoapIn">
    <wsdl:part name="parameters" element="tns:SearchSecretPolicies" />
  </wsdl:message>
  <wsdl:message name="SearchSecretPoliciesSoapOut">
    <wsdl:part name="parameters" element="tns:SearchSecretPoliciesResponse" />
  </wsdl:message>
  <wsdl:message name="RunActiveDirectorySynchronizationSoapIn">
    <wsdl:part name="parameters" element="tns:RunActiveDirectorySynchronization" />
  </wsdl:message>
  <wsdl:message name="RunActiveDirectorySynchronizationSoapOut">
    <wsdl:part name="parameters" element="tns:RunActiveDirectorySynchronizationResponse" />
  </wsdl:message>
  <wsdl:message name="AddGroupToActiveDirectorySynchronizationSoapIn">
    <wsdl:part name="parameters" element="tns:AddGroupToActiveDirectorySynchronization" />
  </wsdl:message>
  <wsdl:message name="AddGroupToActiveDirectorySynchronizationSoapOut">
    <wsdl:part name="parameters" element="tns:AddGroupToActiveDirectorySynchronizationResponse" />
  </wsdl:message>
  <wsdl:message name="AddSecretPolicySoapIn">
    <wsdl:part name="parameters" element="tns:AddSecretPolicy" />
  </wsdl:message>
  <wsdl:message name="AddSecretPolicySoapOut">
    <wsdl:part name="parameters" element="tns:AddSecretPolicyResponse" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretPolicySoapIn">
    <wsdl:part name="parameters" element="tns:GetNewSecretPolicy" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretPolicySoapOut">
    <wsdl:part name="parameters" element="tns:GetNewSecretPolicyResponse" />
  </wsdl:message>
  <wsdl:message name="GetSSHCommandMenuSoapIn">
    <wsdl:part name="parameters" element="tns:GetSSHCommandMenu" />
  </wsdl:message>
  <wsdl:message name="GetSSHCommandMenuSoapOut">
    <wsdl:part name="parameters" element="tns:GetSSHCommandMenuResponse" />
  </wsdl:message>
  <wsdl:message name="SaveSSHCommandMenuSoapIn">
    <wsdl:part name="parameters" element="tns:SaveSSHCommandMenu" />
  </wsdl:message>
  <wsdl:message name="SaveSSHCommandMenuSoapOut">
    <wsdl:part name="parameters" element="tns:SaveSSHCommandMenuResponse" />
  </wsdl:message>
  <wsdl:message name="GetAllSSHCommandMenusSoapIn">
    <wsdl:part name="parameters" element="tns:GetAllSSHCommandMenus" />
  </wsdl:message>
  <wsdl:message name="GetAllSSHCommandMenusSoapOut">
    <wsdl:part name="parameters" element="tns:GetAllSSHCommandMenusResponse" />
  </wsdl:message>
  <wsdl:message name="DeleteSSHCommandMenuSoapIn">
    <wsdl:part name="parameters" element="tns:DeleteSSHCommandMenu" />
  </wsdl:message>
  <wsdl:message name="DeleteSSHCommandMenuSoapOut">
    <wsdl:part name="parameters" element="tns:DeleteSSHCommandMenuResponse" />
  </wsdl:message>
  <wsdl:message name="RestoreSSHCommandMenuSoapIn">
    <wsdl:part name="parameters" element="tns:RestoreSSHCommandMenu" />
  </wsdl:message>
  <wsdl:message name="RestoreSSHCommandMenuSoapOut">
    <wsdl:part name="parameters" element="tns:RestoreSSHCommandMenuResponse" />
  </wsdl:message>
  <wsdl:message name="AddScriptSoapIn">
    <wsdl:part name="parameters" element="tns:AddScript" />
  </wsdl:message>
  <wsdl:message name="AddScriptSoapOut">
    <wsdl:part name="parameters" element="tns:AddScriptResponse" />
  </wsdl:message>
  <wsdl:message name="GetAllScriptsSoapIn">
    <wsdl:part name="parameters" element="tns:GetAllScripts" />
  </wsdl:message>
  <wsdl:message name="GetAllScriptsSoapOut">
    <wsdl:part name="parameters" element="tns:GetAllScriptsResponse" />
  </wsdl:message>
  <wsdl:message name="GetScriptSoapIn">
    <wsdl:part name="parameters" element="tns:GetScript" />
  </wsdl:message>
  <wsdl:message name="GetScriptSoapOut">
    <wsdl:part name="parameters" element="tns:GetScriptResponse" />
  </wsdl:message>
  <wsdl:message name="UpdateScriptSoapIn">
    <wsdl:part name="parameters" element="tns:UpdateScript" />
  </wsdl:message>
  <wsdl:message name="UpdateScriptSoapOut">
    <wsdl:part name="parameters" element="tns:UpdateScriptResponse" />
  </wsdl:message>
  <wsdl:message name="ApproveSecretAccessRequestHttpGetIn">
    <wsdl:part name="approvalId" type="s:string" />
    <wsdl:part name="hours" type="s:string" />
    <wsdl:part name="userOverride" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ApproveSecretAccessRequestHttpGetOut">
    <wsdl:part name="Body" element="tns:RequestApprovalResult" />
  </wsdl:message>
  <wsdl:message name="DenySecretAccessRequestHttpGetIn">
    <wsdl:part name="approvalId" type="s:string" />
    <wsdl:part name="userOverride" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DenySecretAccessRequestHttpGetOut">
    <wsdl:part name="Body" element="tns:RequestApprovalResult" />
  </wsdl:message>
  <wsdl:message name="AuthenticateHttpGetIn">
    <wsdl:part name="username" type="s:string" />
    <wsdl:part name="password" type="s:string" />
    <wsdl:part name="organization" type="s:string" />
    <wsdl:part name="domain" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AuthenticateHttpGetOut">
    <wsdl:part name="Body" element="tns:AuthenticateResult" />
  </wsdl:message>
  <wsdl:message name="ImpersonateUserHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="username" type="s:string" />
    <wsdl:part name="organization" type="s:string" />
    <wsdl:part name="domain" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ImpersonateUserHttpGetOut">
    <wsdl:part name="Body" element="tns:ImpersonateResult" />
  </wsdl:message>
  <wsdl:message name="AuthenticateRADIUSHttpGetIn">
    <wsdl:part name="username" type="s:string" />
    <wsdl:part name="password" type="s:string" />
    <wsdl:part name="organization" type="s:string" />
    <wsdl:part name="domain" type="s:string" />
    <wsdl:part name="radiusPassword" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AuthenticateRADIUSHttpGetOut">
    <wsdl:part name="Body" element="tns:AuthenticateResult" />
  </wsdl:message>
  <wsdl:message name="GetTokenIsValidHttpGetIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetTokenIsValidHttpGetOut">
    <wsdl:part name="Body" element="tns:TokenIsValidResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretLegacyHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretLegacyHttpGetOut">
    <wsdl:part name="Body" element="tns:GetSecretResult" />
  </wsdl:message>
  <wsdl:message name="GetCheckOutStatusHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetCheckOutStatusHttpGetOut">
    <wsdl:part name="Body" element="tns:GetCheckOutStatusResult" />
  </wsdl:message>
  <wsdl:message name="ChangePasswordHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="currentPassword" type="s:string" />
    <wsdl:part name="newPassword" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ChangePasswordHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByFieldValueHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="fieldName" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByFieldValueHttpGetOut">
    <wsdl:part name="Body" element="tns:GetSecretsByFieldValueResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFieldValueHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="fieldName" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
    <wsdl:part name="showRestricted" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFieldValueHttpGetOut">
    <wsdl:part name="Body" element="tns:SearchSecretsResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByExposedFieldValueHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="fieldName" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
    <wsdl:part name="showPartialMatches" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByExposedFieldValueHttpGetOut">
    <wsdl:part name="Body" element="tns:GetSecretsByFieldValueResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedFieldValueHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="fieldName" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
    <wsdl:part name="showRestricted" type="s:string" />
    <wsdl:part name="showPartialMatches" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedFieldValueHttpGetOut">
    <wsdl:part name="Body" element="tns:SearchSecretsResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedValuesHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
    <wsdl:part name="showRestricted" type="s:string" />
    <wsdl:part name="showPartialMatches" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedValuesHttpGetOut">
    <wsdl:part name="Body" element="tns:SearchSecretsResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsLegacyHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsLegacyHttpGetOut">
    <wsdl:part name="Body" element="tns:SearchSecretsResult" />
  </wsdl:message>
  <wsdl:message name="GetFavoritesHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="includeRestricted" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetFavoritesHttpGetOut">
    <wsdl:part name="Body" element="tns:GetFavoritesResult" />
  </wsdl:message>
  <wsdl:message name="UpdateIsFavoriteHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="isFavorite" type="s:string" />
  </wsdl:message>
  <wsdl:message name="UpdateIsFavoriteHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="AddSecretHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretTypeId" type="s:string" />
    <wsdl:part name="secretName" type="s:string" />
    <wsdl:part name="secretFieldIds" type="s1:StringArray" />
    <wsdl:part name="secretItemValues" type="s1:StringArray" />
    <wsdl:part name="folderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AddSecretHttpGetOut">
    <wsdl:part name="Body" element="tns:AddSecretResult" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretTypeId" type="s:string" />
    <wsdl:part name="folderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretHttpGetOut">
    <wsdl:part name="Body" element="tns:GetSecretResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplateFieldsHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretTypeId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplateFieldsHttpGetOut">
    <wsdl:part name="Body" element="tns:GetSecretTemplateFieldsResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplatesHttpGetIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplatesHttpGetOut">
    <wsdl:part name="Body" element="tns:GetSecretTemplatesResult" />
  </wsdl:message>
  <wsdl:message name="GeneratePasswordHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretFieldId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GeneratePasswordHttpGetOut">
    <wsdl:part name="Body" element="tns:GeneratePasswordResult" />
  </wsdl:message>
  <wsdl:message name="DeactivateSecretHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DeactivateSecretHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="VersionGetHttpGetIn" />
  <wsdl:message name="VersionGetHttpGetOut">
    <wsdl:part name="Body" element="tns:VersionGetResult" />
  </wsdl:message>
  <wsdl:message name="FolderGetHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="folderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="FolderGetHttpGetOut">
    <wsdl:part name="Body" element="tns:GetFolderResult" />
  </wsdl:message>
  <wsdl:message name="FolderGetAllChildrenHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="parentFolderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="FolderGetAllChildrenHttpGetOut">
    <wsdl:part name="Body" element="tns:GetFoldersResult" />
  </wsdl:message>
  <wsdl:message name="FolderCreateHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="folderName" type="s:string" />
    <wsdl:part name="parentFolderId" type="s:string" />
    <wsdl:part name="folderTypeId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="FolderCreateHttpGetOut">
    <wsdl:part name="Body" element="tns:CreateFolderResult" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedGetHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="folderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedGetHttpGetOut">
    <wsdl:part name="Body" element="tns:FolderExtendedGetResult" />
  </wsdl:message>
  <wsdl:message name="SearchFoldersHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="folderName" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchFoldersHttpGetOut">
    <wsdl:part name="Body" element="tns:SearchFolderResult" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentHttpGetOut">
    <wsdl:part name="Body" element="tns:FileDownloadResult" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentByItemIdHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="secretItemId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentByItemIdHttpGetOut">
    <wsdl:part name="Body" element="tns:FileDownloadResult" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="fileData" type="s1:StringArray" />
    <wsdl:part name="fileName" type="s:string" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentByItemIdHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="secretItemId" type="s:string" />
    <wsdl:part name="fileData" type="s1:StringArray" />
    <wsdl:part name="fileName" type="s:string" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentByItemIdHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="ExpireSecretHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ExpireSecretHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="ImportXMLHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="xml" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ImportXMLHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretAuditHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretAuditHttpGetOut">
    <wsdl:part name="Body" element="tns:GetSecretAuditResult" />
  </wsdl:message>
  <wsdl:message name="RemoveDependencyHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="dependencyId" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="RemoveDependencyHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetDependenciesHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetDependenciesHttpGetOut">
    <wsdl:part name="Body" element="tns:GetDependenciesResult" />
  </wsdl:message>
  <wsdl:message name="GetDistributedEnginesHttpGetIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetDistributedEnginesHttpGetOut">
    <wsdl:part name="Body" element="tns:GetSitesResult" />
  </wsdl:message>
  <wsdl:message name="GetTicketSystemsHttpGetIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetTicketSystemsHttpGetOut">
    <wsdl:part name="Body" element="tns:GetTicketSystemsResult" />
  </wsdl:message>
  <wsdl:message name="AssignSiteHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="siteId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AssignSiteHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="CheckInHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="CheckInHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="CheckInByKeyHttpGetIn">
    <wsdl:part name="sessionKey" type="s:string" />
  </wsdl:message>
  <wsdl:message name="CheckInByKeyHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="WhoAmIHttpGetIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="WhoAmIHttpGetOut">
    <wsdl:part name="Body" element="tns:UserInfoResult" />
  </wsdl:message>
  <wsdl:message name="GetAllGroupsHttpGetIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetAllGroupsHttpGetOut">
    <wsdl:part name="Body" element="tns:GetAllGroupsResult" />
  </wsdl:message>
  <wsdl:message name="AssignUserToGroupHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="userId" type="s:string" />
    <wsdl:part name="groupId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AssignUserToGroupHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsHttpGetOut">
    <wsdl:part name="Body" element="tns:SSHCredentialsResult" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsWithMachineHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="machine" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsWithMachineHttpGetOut">
    <wsdl:part name="Body" element="tns:SSHCredentialsResult" />
  </wsdl:message>
  <wsdl:message name="SearchUsersHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="includeInactiveUsers" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchUsersHttpGetOut">
    <wsdl:part name="Body" element="tns:GetUsersResult" />
  </wsdl:message>
  <wsdl:message name="GetUserHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="userId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetUserHttpGetOut">
    <wsdl:part name="Body" element="tns:GetUserResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretItemHistoryByFieldNameHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="fieldDisplayName" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretItemHistoryByFieldNameHttpGetOut">
    <wsdl:part name="Body" element="tns:SecretItemHistoryResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretPolicyForSecretHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretPolicyForSecretHttpGetOut">
    <wsdl:part name="Body" element="tns:SecretPolicyForSecretResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretPoliciesHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="term" type="s:string" />
    <wsdl:part name="includeInactive" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretPoliciesHttpGetOut">
    <wsdl:part name="Body" element="tns:SearchSecretPoliciesResult" />
  </wsdl:message>
  <wsdl:message name="RunActiveDirectorySynchronizationHttpGetIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="RunActiveDirectorySynchronizationHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretPolicyHttpGetIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretPolicyHttpGetOut">
    <wsdl:part name="Body" element="tns:SecretPolicyResult" />
  </wsdl:message>
  <wsdl:message name="GetSSHCommandMenuHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="sshCommandMenuId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSSHCommandMenuHttpGetOut">
    <wsdl:part name="Body" element="tns:GetSshCommandMenuResult" />
  </wsdl:message>
  <wsdl:message name="DeleteSSHCommandMenuHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="sshCommandMenuId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DeleteSSHCommandMenuHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="RestoreSSHCommandMenuHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="sshCommandMenuId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="RestoreSSHCommandMenuHttpGetOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetAllScriptsHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="includeInactiveUserScripts" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetAllScriptsHttpGetOut">
    <wsdl:part name="Body" element="tns:GetUserScriptsResult" />
  </wsdl:message>
  <wsdl:message name="GetScriptHttpGetIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="userScriptId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetScriptHttpGetOut">
    <wsdl:part name="Body" element="tns:GetUserScriptResult" />
  </wsdl:message>
  <wsdl:message name="ApproveSecretAccessRequestHttpPostIn">
    <wsdl:part name="approvalId" type="s:string" />
    <wsdl:part name="hours" type="s:string" />
    <wsdl:part name="userOverride" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ApproveSecretAccessRequestHttpPostOut">
    <wsdl:part name="Body" element="tns:RequestApprovalResult" />
  </wsdl:message>
  <wsdl:message name="DenySecretAccessRequestHttpPostIn">
    <wsdl:part name="approvalId" type="s:string" />
    <wsdl:part name="userOverride" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DenySecretAccessRequestHttpPostOut">
    <wsdl:part name="Body" element="tns:RequestApprovalResult" />
  </wsdl:message>
  <wsdl:message name="AuthenticateHttpPostIn">
    <wsdl:part name="username" type="s:string" />
    <wsdl:part name="password" type="s:string" />
    <wsdl:part name="organization" type="s:string" />
    <wsdl:part name="domain" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AuthenticateHttpPostOut">
    <wsdl:part name="Body" element="tns:AuthenticateResult" />
  </wsdl:message>
  <wsdl:message name="ImpersonateUserHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="username" type="s:string" />
    <wsdl:part name="organization" type="s:string" />
    <wsdl:part name="domain" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ImpersonateUserHttpPostOut">
    <wsdl:part name="Body" element="tns:ImpersonateResult" />
  </wsdl:message>
  <wsdl:message name="AuthenticateRADIUSHttpPostIn">
    <wsdl:part name="username" type="s:string" />
    <wsdl:part name="password" type="s:string" />
    <wsdl:part name="organization" type="s:string" />
    <wsdl:part name="domain" type="s:string" />
    <wsdl:part name="radiusPassword" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AuthenticateRADIUSHttpPostOut">
    <wsdl:part name="Body" element="tns:AuthenticateResult" />
  </wsdl:message>
  <wsdl:message name="GetTokenIsValidHttpPostIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetTokenIsValidHttpPostOut">
    <wsdl:part name="Body" element="tns:TokenIsValidResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretLegacyHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretLegacyHttpPostOut">
    <wsdl:part name="Body" element="tns:GetSecretResult" />
  </wsdl:message>
  <wsdl:message name="GetCheckOutStatusHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetCheckOutStatusHttpPostOut">
    <wsdl:part name="Body" element="tns:GetCheckOutStatusResult" />
  </wsdl:message>
  <wsdl:message name="ChangePasswordHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="currentPassword" type="s:string" />
    <wsdl:part name="newPassword" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ChangePasswordHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByFieldValueHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="fieldName" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByFieldValueHttpPostOut">
    <wsdl:part name="Body" element="tns:GetSecretsByFieldValueResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFieldValueHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="fieldName" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
    <wsdl:part name="showRestricted" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByFieldValueHttpPostOut">
    <wsdl:part name="Body" element="tns:SearchSecretsResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByExposedFieldValueHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="fieldName" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
    <wsdl:part name="showPartialMatches" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretsByExposedFieldValueHttpPostOut">
    <wsdl:part name="Body" element="tns:GetSecretsByFieldValueResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedFieldValueHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="fieldName" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
    <wsdl:part name="showRestricted" type="s:string" />
    <wsdl:part name="showPartialMatches" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedFieldValueHttpPostOut">
    <wsdl:part name="Body" element="tns:SearchSecretsResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedValuesHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="showDeleted" type="s:string" />
    <wsdl:part name="showRestricted" type="s:string" />
    <wsdl:part name="showPartialMatches" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsByExposedValuesHttpPostOut">
    <wsdl:part name="Body" element="tns:SearchSecretsResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsLegacyHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretsLegacyHttpPostOut">
    <wsdl:part name="Body" element="tns:SearchSecretsResult" />
  </wsdl:message>
  <wsdl:message name="GetFavoritesHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="includeRestricted" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetFavoritesHttpPostOut">
    <wsdl:part name="Body" element="tns:GetFavoritesResult" />
  </wsdl:message>
  <wsdl:message name="UpdateIsFavoriteHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="isFavorite" type="s:string" />
  </wsdl:message>
  <wsdl:message name="UpdateIsFavoriteHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="AddSecretHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretTypeId" type="s:string" />
    <wsdl:part name="secretName" type="s:string" />
    <wsdl:part name="secretFieldIds" type="s1:StringArray" />
    <wsdl:part name="secretItemValues" type="s1:StringArray" />
    <wsdl:part name="folderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AddSecretHttpPostOut">
    <wsdl:part name="Body" element="tns:AddSecretResult" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretTypeId" type="s:string" />
    <wsdl:part name="folderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretHttpPostOut">
    <wsdl:part name="Body" element="tns:GetSecretResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplateFieldsHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretTypeId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplateFieldsHttpPostOut">
    <wsdl:part name="Body" element="tns:GetSecretTemplateFieldsResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplatesHttpPostIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretTemplatesHttpPostOut">
    <wsdl:part name="Body" element="tns:GetSecretTemplatesResult" />
  </wsdl:message>
  <wsdl:message name="GeneratePasswordHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretFieldId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GeneratePasswordHttpPostOut">
    <wsdl:part name="Body" element="tns:GeneratePasswordResult" />
  </wsdl:message>
  <wsdl:message name="DeactivateSecretHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DeactivateSecretHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="VersionGetHttpPostIn" />
  <wsdl:message name="VersionGetHttpPostOut">
    <wsdl:part name="Body" element="tns:VersionGetResult" />
  </wsdl:message>
  <wsdl:message name="FolderGetHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="folderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="FolderGetHttpPostOut">
    <wsdl:part name="Body" element="tns:GetFolderResult" />
  </wsdl:message>
  <wsdl:message name="FolderGetAllChildrenHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="parentFolderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="FolderGetAllChildrenHttpPostOut">
    <wsdl:part name="Body" element="tns:GetFoldersResult" />
  </wsdl:message>
  <wsdl:message name="FolderCreateHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="folderName" type="s:string" />
    <wsdl:part name="parentFolderId" type="s:string" />
    <wsdl:part name="folderTypeId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="FolderCreateHttpPostOut">
    <wsdl:part name="Body" element="tns:CreateFolderResult" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedGetHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="folderId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="FolderExtendedGetHttpPostOut">
    <wsdl:part name="Body" element="tns:FolderExtendedGetResult" />
  </wsdl:message>
  <wsdl:message name="SearchFoldersHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="folderName" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchFoldersHttpPostOut">
    <wsdl:part name="Body" element="tns:SearchFolderResult" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentHttpPostOut">
    <wsdl:part name="Body" element="tns:FileDownloadResult" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentByItemIdHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="secretItemId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DownloadFileAttachmentByItemIdHttpPostOut">
    <wsdl:part name="Body" element="tns:FileDownloadResult" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="fileData" type="s1:StringArray" />
    <wsdl:part name="fileName" type="s:string" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentByItemIdHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="secretItemId" type="s:string" />
    <wsdl:part name="fileData" type="s1:StringArray" />
    <wsdl:part name="fileName" type="s:string" />
  </wsdl:message>
  <wsdl:message name="UploadFileAttachmentByItemIdHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="ExpireSecretHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ExpireSecretHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="ImportXMLHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="xml" type="s:string" />
  </wsdl:message>
  <wsdl:message name="ImportXMLHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretAuditHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretAuditHttpPostOut">
    <wsdl:part name="Body" element="tns:GetSecretAuditResult" />
  </wsdl:message>
  <wsdl:message name="RemoveDependencyHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="dependencyId" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="RemoveDependencyHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetDependenciesHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetDependenciesHttpPostOut">
    <wsdl:part name="Body" element="tns:GetDependenciesResult" />
  </wsdl:message>
  <wsdl:message name="GetDistributedEnginesHttpPostIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetDistributedEnginesHttpPostOut">
    <wsdl:part name="Body" element="tns:GetSitesResult" />
  </wsdl:message>
  <wsdl:message name="GetTicketSystemsHttpPostIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetTicketSystemsHttpPostOut">
    <wsdl:part name="Body" element="tns:GetTicketSystemsResult" />
  </wsdl:message>
  <wsdl:message name="AssignSiteHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="siteId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AssignSiteHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="CheckInHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="CheckInHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="CheckInByKeyHttpPostIn">
    <wsdl:part name="sessionKey" type="s:string" />
  </wsdl:message>
  <wsdl:message name="CheckInByKeyHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="WhoAmIHttpPostIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="WhoAmIHttpPostOut">
    <wsdl:part name="Body" element="tns:UserInfoResult" />
  </wsdl:message>
  <wsdl:message name="GetAllGroupsHttpPostIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetAllGroupsHttpPostOut">
    <wsdl:part name="Body" element="tns:GetAllGroupsResult" />
  </wsdl:message>
  <wsdl:message name="AssignUserToGroupHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="userId" type="s:string" />
    <wsdl:part name="groupId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="AssignUserToGroupHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsHttpPostOut">
    <wsdl:part name="Body" element="tns:SSHCredentialsResult" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsWithMachineHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="machine" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSSHLoginCredentialsWithMachineHttpPostOut">
    <wsdl:part name="Body" element="tns:SSHCredentialsResult" />
  </wsdl:message>
  <wsdl:message name="SearchUsersHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="searchTerm" type="s:string" />
    <wsdl:part name="includeInactiveUsers" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchUsersHttpPostOut">
    <wsdl:part name="Body" element="tns:GetUsersResult" />
  </wsdl:message>
  <wsdl:message name="GetUserHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="userId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetUserHttpPostOut">
    <wsdl:part name="Body" element="tns:GetUserResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretItemHistoryByFieldNameHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
    <wsdl:part name="fieldDisplayName" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretItemHistoryByFieldNameHttpPostOut">
    <wsdl:part name="Body" element="tns:SecretItemHistoryResult" />
  </wsdl:message>
  <wsdl:message name="GetSecretPolicyForSecretHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="secretId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSecretPolicyForSecretHttpPostOut">
    <wsdl:part name="Body" element="tns:SecretPolicyForSecretResult" />
  </wsdl:message>
  <wsdl:message name="SearchSecretPoliciesHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="term" type="s:string" />
    <wsdl:part name="includeInactive" type="s:string" />
  </wsdl:message>
  <wsdl:message name="SearchSecretPoliciesHttpPostOut">
    <wsdl:part name="Body" element="tns:SearchSecretPoliciesResult" />
  </wsdl:message>
  <wsdl:message name="RunActiveDirectorySynchronizationHttpPostIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="RunActiveDirectorySynchronizationHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretPolicyHttpPostIn">
    <wsdl:part name="token" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetNewSecretPolicyHttpPostOut">
    <wsdl:part name="Body" element="tns:SecretPolicyResult" />
  </wsdl:message>
  <wsdl:message name="GetSSHCommandMenuHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="sshCommandMenuId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetSSHCommandMenuHttpPostOut">
    <wsdl:part name="Body" element="tns:GetSshCommandMenuResult" />
  </wsdl:message>
  <wsdl:message name="DeleteSSHCommandMenuHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="sshCommandMenuId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="DeleteSSHCommandMenuHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="RestoreSSHCommandMenuHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="sshCommandMenuId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="RestoreSSHCommandMenuHttpPostOut">
    <wsdl:part name="Body" element="tns:WebServiceResult" />
  </wsdl:message>
  <wsdl:message name="GetAllScriptsHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="includeInactiveUserScripts" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetAllScriptsHttpPostOut">
    <wsdl:part name="Body" element="tns:GetUserScriptsResult" />
  </wsdl:message>
  <wsdl:message name="GetScriptHttpPostIn">
    <wsdl:part name="token" type="s:string" />
    <wsdl:part name="userScriptId" type="s:string" />
  </wsdl:message>
  <wsdl:message name="GetScriptHttpPostOut">
    <wsdl:part name="Body" element="tns:GetUserScriptResult" />
  </wsdl:message>
  <wsdl:portType name="SSWebServiceSoap">
    <wsdl:operation name="ApproveSecretAccessRequest">
      <wsdl:input message="tns:ApproveSecretAccessRequestSoapIn" />
      <wsdl:output message="tns:ApproveSecretAccessRequestSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="DenySecretAccessRequest">
      <wsdl:input message="tns:DenySecretAccessRequestSoapIn" />
      <wsdl:output message="tns:DenySecretAccessRequestSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="Authenticate">
      <wsdl:input message="tns:AuthenticateSoapIn" />
      <wsdl:output message="tns:AuthenticateSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="ImpersonateUser">
      <wsdl:input message="tns:ImpersonateUserSoapIn" />
      <wsdl:output message="tns:ImpersonateUserSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AuthenticateRADIUS">
      <wsdl:input message="tns:AuthenticateRADIUSSoapIn" />
      <wsdl:output message="tns:AuthenticateRADIUSSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetTokenIsValid">
      <wsdl:input message="tns:GetTokenIsValidSoapIn" />
      <wsdl:output message="tns:GetTokenIsValidSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretLegacy">
      <wsdl:input message="tns:GetSecretLegacySoapIn" />
      <wsdl:output message="tns:GetSecretLegacySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecret">
      <wsdl:input message="tns:GetSecretSoapIn" />
      <wsdl:output message="tns:GetSecretSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetCheckOutStatus">
      <wsdl:input message="tns:GetCheckOutStatusSoapIn" />
      <wsdl:output message="tns:GetCheckOutStatusSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="ChangePassword">
      <wsdl:input message="tns:ChangePasswordSoapIn" />
      <wsdl:output message="tns:ChangePasswordSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByFieldValue">
      <wsdl:input message="tns:GetSecretsByFieldValueSoapIn" />
      <wsdl:output message="tns:GetSecretsByFieldValueSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFieldValue">
      <wsdl:input message="tns:SearchSecretsByFieldValueSoapIn" />
      <wsdl:output message="tns:SearchSecretsByFieldValueSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByExposedFieldValue">
      <wsdl:input message="tns:GetSecretsByExposedFieldValueSoapIn" />
      <wsdl:output message="tns:GetSecretsByExposedFieldValueSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedFieldValue">
      <wsdl:input message="tns:SearchSecretsByExposedFieldValueSoapIn" />
      <wsdl:output message="tns:SearchSecretsByExposedFieldValueSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedValues">
      <wsdl:input message="tns:SearchSecretsByExposedValuesSoapIn" />
      <wsdl:output message="tns:SearchSecretsByExposedValuesSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AddUser">
      <wsdl:input message="tns:AddUserSoapIn" />
      <wsdl:output message="tns:AddUserSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecrets">
      <wsdl:input message="tns:SearchSecretsSoapIn" />
      <wsdl:output message="tns:SearchSecretsSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsLegacy">
      <wsdl:input message="tns:SearchSecretsLegacySoapIn" />
      <wsdl:output message="tns:SearchSecretsLegacySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFolder">
      <wsdl:input message="tns:SearchSecretsByFolderSoapIn" />
      <wsdl:output message="tns:SearchSecretsByFolderSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFolderLegacy">
      <wsdl:input message="tns:SearchSecretsByFolderLegacySoapIn" />
      <wsdl:output message="tns:SearchSecretsByFolderLegacySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetFavorites">
      <wsdl:input message="tns:GetFavoritesSoapIn" />
      <wsdl:output message="tns:GetFavoritesSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="UpdateIsFavorite">
      <wsdl:input message="tns:UpdateIsFavoriteSoapIn" />
      <wsdl:output message="tns:UpdateIsFavoriteSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AddSecret">
      <wsdl:input message="tns:AddSecretSoapIn" />
      <wsdl:output message="tns:AddSecretSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AddNewSecret">
      <wsdl:input message="tns:AddNewSecretSoapIn" />
      <wsdl:output message="tns:AddNewSecretSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetNewSecret">
      <wsdl:input message="tns:GetNewSecretSoapIn" />
      <wsdl:output message="tns:GetNewSecretSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplateFields">
      <wsdl:input message="tns:GetSecretTemplateFieldsSoapIn" />
      <wsdl:output message="tns:GetSecretTemplateFieldsSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="UpdateSecret">
      <wsdl:input message="tns:UpdateSecretSoapIn" />
      <wsdl:output message="tns:UpdateSecretSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplates">
      <wsdl:input message="tns:GetSecretTemplatesSoapIn" />
      <wsdl:output message="tns:GetSecretTemplatesSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GeneratePassword">
      <wsdl:input message="tns:GeneratePasswordSoapIn" />
      <wsdl:output message="tns:GeneratePasswordSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="DeactivateSecret">
      <wsdl:input message="tns:DeactivateSecretSoapIn" />
      <wsdl:output message="tns:DeactivateSecretSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="VersionGet">
      <wsdl:input message="tns:VersionGetSoapIn" />
      <wsdl:output message="tns:VersionGetSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderGet">
      <wsdl:input message="tns:FolderGetSoapIn" />
      <wsdl:output message="tns:FolderGetSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderUpdate">
      <wsdl:input message="tns:FolderUpdateSoapIn" />
      <wsdl:output message="tns:FolderUpdateSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderGetAllChildren">
      <wsdl:input message="tns:FolderGetAllChildrenSoapIn" />
      <wsdl:output message="tns:FolderGetAllChildrenSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderCreate">
      <wsdl:input message="tns:FolderCreateSoapIn" />
      <wsdl:output message="tns:FolderCreateSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedCreate">
      <wsdl:input message="tns:FolderExtendedCreateSoapIn" />
      <wsdl:output message="tns:FolderExtendedCreateSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGet">
      <wsdl:input message="tns:FolderExtendedGetSoapIn" />
      <wsdl:output message="tns:FolderExtendedGetSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedUpdate">
      <wsdl:input message="tns:FolderExtendedUpdateSoapIn" />
      <wsdl:output message="tns:FolderExtendedUpdateSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGetNew">
      <wsdl:input message="tns:FolderExtendedGetNewSoapIn" />
      <wsdl:output message="tns:FolderExtendedGetNewSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchFolders">
      <wsdl:input message="tns:SearchFoldersSoapIn" />
      <wsdl:output message="tns:SearchFoldersSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachment">
      <wsdl:input message="tns:DownloadFileAttachmentSoapIn" />
      <wsdl:output message="tns:DownloadFileAttachmentSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachmentByItemId">
      <wsdl:input message="tns:DownloadFileAttachmentByItemIdSoapIn" />
      <wsdl:output message="tns:DownloadFileAttachmentByItemIdSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachment">
      <wsdl:input message="tns:UploadFileAttachmentSoapIn" />
      <wsdl:output message="tns:UploadFileAttachmentSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachmentByItemId">
      <wsdl:input message="tns:UploadFileAttachmentByItemIdSoapIn" />
      <wsdl:output message="tns:UploadFileAttachmentByItemIdSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="ExpireSecret">
      <wsdl:input message="tns:ExpireSecretSoapIn" />
      <wsdl:output message="tns:ExpireSecretSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SetCheckOutEnabled">
      <wsdl:input message="tns:SetCheckOutEnabledSoapIn" />
      <wsdl:output message="tns:SetCheckOutEnabledSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="ImportXML">
      <wsdl:input message="tns:ImportXMLSoapIn" />
      <wsdl:output message="tns:ImportXMLSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretAudit">
      <wsdl:input message="tns:GetSecretAuditSoapIn" />
      <wsdl:output message="tns:GetSecretAuditSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AddDependency">
      <wsdl:input message="tns:AddDependencySoapIn" />
      <wsdl:output message="tns:AddDependencySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="RemoveDependency">
      <wsdl:input message="tns:RemoveDependencySoapIn" />
      <wsdl:output message="tns:RemoveDependencySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetDependencies">
      <wsdl:input message="tns:GetDependenciesSoapIn" />
      <wsdl:output message="tns:GetDependenciesSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetDistributedEngines">
      <wsdl:input message="tns:GetDistributedEnginesSoapIn" />
      <wsdl:output message="tns:GetDistributedEnginesSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetTicketSystems">
      <wsdl:input message="tns:GetTicketSystemsSoapIn" />
      <wsdl:output message="tns:GetTicketSystemsSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AssignSite">
      <wsdl:input message="tns:AssignSiteSoapIn" />
      <wsdl:output message="tns:AssignSiteSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="CheckIn">
      <wsdl:input message="tns:CheckInSoapIn" />
      <wsdl:output message="tns:CheckInSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AddSecretCustomAudit">
      <wsdl:input message="tns:AddSecretCustomAuditSoapIn" />
      <wsdl:output message="tns:AddSecretCustomAuditSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="UpdateSecretPermission">
      <wsdl:input message="tns:UpdateSecretPermissionSoapIn" />
      <wsdl:output message="tns:UpdateSecretPermissionSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="CheckInByKey">
      <wsdl:input message="tns:CheckInByKeySoapIn" />
      <wsdl:output message="tns:CheckInByKeySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="WhoAmI">
      <wsdl:input message="tns:WhoAmISoapIn" />
      <wsdl:output message="tns:WhoAmISoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetAllGroups">
      <wsdl:input message="tns:GetAllGroupsSoapIn" />
      <wsdl:output message="tns:GetAllGroupsSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AssignUserToGroup">
      <wsdl:input message="tns:AssignUserToGroupSoapIn" />
      <wsdl:output message="tns:AssignUserToGroupSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentials">
      <wsdl:input message="tns:GetSSHLoginCredentialsSoapIn" />
      <wsdl:output message="tns:GetSSHLoginCredentialsSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentialsWithMachine">
      <wsdl:input message="tns:GetSSHLoginCredentialsWithMachineSoapIn" />
      <wsdl:output message="tns:GetSSHLoginCredentialsWithMachineSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchUsers">
      <wsdl:input message="tns:SearchUsersSoapIn" />
      <wsdl:output message="tns:SearchUsersSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetUser">
      <wsdl:input message="tns:GetUserSoapIn" />
      <wsdl:output message="tns:GetUserSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="UpdateUser">
      <wsdl:input message="tns:UpdateUserSoapIn" />
      <wsdl:output message="tns:UpdateUserSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretItemHistoryByFieldName">
      <wsdl:input message="tns:GetSecretItemHistoryByFieldNameSoapIn" />
      <wsdl:output message="tns:GetSecretItemHistoryByFieldNameSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretPolicyForSecret">
      <wsdl:input message="tns:GetSecretPolicyForSecretSoapIn" />
      <wsdl:output message="tns:GetSecretPolicyForSecretSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AssignSecretPolicyForSecret">
      <wsdl:input message="tns:AssignSecretPolicyForSecretSoapIn" />
      <wsdl:output message="tns:AssignSecretPolicyForSecretSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretPolicies">
      <wsdl:input message="tns:SearchSecretPoliciesSoapIn" />
      <wsdl:output message="tns:SearchSecretPoliciesSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="RunActiveDirectorySynchronization">
      <wsdl:input message="tns:RunActiveDirectorySynchronizationSoapIn" />
      <wsdl:output message="tns:RunActiveDirectorySynchronizationSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AddGroupToActiveDirectorySynchronization">
      <wsdl:input message="tns:AddGroupToActiveDirectorySynchronizationSoapIn" />
      <wsdl:output message="tns:AddGroupToActiveDirectorySynchronizationSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AddSecretPolicy">
      <wsdl:input message="tns:AddSecretPolicySoapIn" />
      <wsdl:output message="tns:AddSecretPolicySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetNewSecretPolicy">
      <wsdl:input message="tns:GetNewSecretPolicySoapIn" />
      <wsdl:output message="tns:GetNewSecretPolicySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSSHCommandMenu">
      <wsdl:input message="tns:GetSSHCommandMenuSoapIn" />
      <wsdl:output message="tns:GetSSHCommandMenuSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="SaveSSHCommandMenu">
      <wsdl:input message="tns:SaveSSHCommandMenuSoapIn" />
      <wsdl:output message="tns:SaveSSHCommandMenuSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetAllSSHCommandMenus">
      <wsdl:input message="tns:GetAllSSHCommandMenusSoapIn" />
      <wsdl:output message="tns:GetAllSSHCommandMenusSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="DeleteSSHCommandMenu">
      <wsdl:input message="tns:DeleteSSHCommandMenuSoapIn" />
      <wsdl:output message="tns:DeleteSSHCommandMenuSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="RestoreSSHCommandMenu">
      <wsdl:input message="tns:RestoreSSHCommandMenuSoapIn" />
      <wsdl:output message="tns:RestoreSSHCommandMenuSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="AddScript">
      <wsdl:input message="tns:AddScriptSoapIn" />
      <wsdl:output message="tns:AddScriptSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetAllScripts">
      <wsdl:input message="tns:GetAllScriptsSoapIn" />
      <wsdl:output message="tns:GetAllScriptsSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="GetScript">
      <wsdl:input message="tns:GetScriptSoapIn" />
      <wsdl:output message="tns:GetScriptSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="UpdateScript">
      <wsdl:input message="tns:UpdateScriptSoapIn" />
      <wsdl:output message="tns:UpdateScriptSoapOut" />
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:portType name="SSWebServiceHttpGet">
    <wsdl:operation name="ApproveSecretAccessRequest">
      <wsdl:input message="tns:ApproveSecretAccessRequestHttpGetIn" />
      <wsdl:output message="tns:ApproveSecretAccessRequestHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="DenySecretAccessRequest">
      <wsdl:input message="tns:DenySecretAccessRequestHttpGetIn" />
      <wsdl:output message="tns:DenySecretAccessRequestHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="Authenticate">
      <wsdl:input message="tns:AuthenticateHttpGetIn" />
      <wsdl:output message="tns:AuthenticateHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="ImpersonateUser">
      <wsdl:input message="tns:ImpersonateUserHttpGetIn" />
      <wsdl:output message="tns:ImpersonateUserHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="AuthenticateRADIUS">
      <wsdl:input message="tns:AuthenticateRADIUSHttpGetIn" />
      <wsdl:output message="tns:AuthenticateRADIUSHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetTokenIsValid">
      <wsdl:input message="tns:GetTokenIsValidHttpGetIn" />
      <wsdl:output message="tns:GetTokenIsValidHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretLegacy">
      <wsdl:input message="tns:GetSecretLegacyHttpGetIn" />
      <wsdl:output message="tns:GetSecretLegacyHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetCheckOutStatus">
      <wsdl:input message="tns:GetCheckOutStatusHttpGetIn" />
      <wsdl:output message="tns:GetCheckOutStatusHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="ChangePassword">
      <wsdl:input message="tns:ChangePasswordHttpGetIn" />
      <wsdl:output message="tns:ChangePasswordHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByFieldValue">
      <wsdl:input message="tns:GetSecretsByFieldValueHttpGetIn" />
      <wsdl:output message="tns:GetSecretsByFieldValueHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFieldValue">
      <wsdl:input message="tns:SearchSecretsByFieldValueHttpGetIn" />
      <wsdl:output message="tns:SearchSecretsByFieldValueHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByExposedFieldValue">
      <wsdl:input message="tns:GetSecretsByExposedFieldValueHttpGetIn" />
      <wsdl:output message="tns:GetSecretsByExposedFieldValueHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedFieldValue">
      <wsdl:input message="tns:SearchSecretsByExposedFieldValueHttpGetIn" />
      <wsdl:output message="tns:SearchSecretsByExposedFieldValueHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedValues">
      <wsdl:input message="tns:SearchSecretsByExposedValuesHttpGetIn" />
      <wsdl:output message="tns:SearchSecretsByExposedValuesHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsLegacy">
      <wsdl:input message="tns:SearchSecretsLegacyHttpGetIn" />
      <wsdl:output message="tns:SearchSecretsLegacyHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetFavorites">
      <wsdl:input message="tns:GetFavoritesHttpGetIn" />
      <wsdl:output message="tns:GetFavoritesHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="UpdateIsFavorite">
      <wsdl:input message="tns:UpdateIsFavoriteHttpGetIn" />
      <wsdl:output message="tns:UpdateIsFavoriteHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="AddSecret">
      <wsdl:input message="tns:AddSecretHttpGetIn" />
      <wsdl:output message="tns:AddSecretHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetNewSecret">
      <wsdl:input message="tns:GetNewSecretHttpGetIn" />
      <wsdl:output message="tns:GetNewSecretHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplateFields">
      <wsdl:input message="tns:GetSecretTemplateFieldsHttpGetIn" />
      <wsdl:output message="tns:GetSecretTemplateFieldsHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplates">
      <wsdl:input message="tns:GetSecretTemplatesHttpGetIn" />
      <wsdl:output message="tns:GetSecretTemplatesHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GeneratePassword">
      <wsdl:input message="tns:GeneratePasswordHttpGetIn" />
      <wsdl:output message="tns:GeneratePasswordHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="DeactivateSecret">
      <wsdl:input message="tns:DeactivateSecretHttpGetIn" />
      <wsdl:output message="tns:DeactivateSecretHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="VersionGet">
      <wsdl:input message="tns:VersionGetHttpGetIn" />
      <wsdl:output message="tns:VersionGetHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderGet">
      <wsdl:input message="tns:FolderGetHttpGetIn" />
      <wsdl:output message="tns:FolderGetHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderGetAllChildren">
      <wsdl:input message="tns:FolderGetAllChildrenHttpGetIn" />
      <wsdl:output message="tns:FolderGetAllChildrenHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderCreate">
      <wsdl:input message="tns:FolderCreateHttpGetIn" />
      <wsdl:output message="tns:FolderCreateHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGet">
      <wsdl:input message="tns:FolderExtendedGetHttpGetIn" />
      <wsdl:output message="tns:FolderExtendedGetHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchFolders">
      <wsdl:input message="tns:SearchFoldersHttpGetIn" />
      <wsdl:output message="tns:SearchFoldersHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachment">
      <wsdl:input message="tns:DownloadFileAttachmentHttpGetIn" />
      <wsdl:output message="tns:DownloadFileAttachmentHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachmentByItemId">
      <wsdl:input message="tns:DownloadFileAttachmentByItemIdHttpGetIn" />
      <wsdl:output message="tns:DownloadFileAttachmentByItemIdHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachment">
      <wsdl:input message="tns:UploadFileAttachmentHttpGetIn" />
      <wsdl:output message="tns:UploadFileAttachmentHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachmentByItemId">
      <wsdl:input message="tns:UploadFileAttachmentByItemIdHttpGetIn" />
      <wsdl:output message="tns:UploadFileAttachmentByItemIdHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="ExpireSecret">
      <wsdl:input message="tns:ExpireSecretHttpGetIn" />
      <wsdl:output message="tns:ExpireSecretHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="ImportXML">
      <wsdl:input message="tns:ImportXMLHttpGetIn" />
      <wsdl:output message="tns:ImportXMLHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretAudit">
      <wsdl:input message="tns:GetSecretAuditHttpGetIn" />
      <wsdl:output message="tns:GetSecretAuditHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="RemoveDependency">
      <wsdl:input message="tns:RemoveDependencyHttpGetIn" />
      <wsdl:output message="tns:RemoveDependencyHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetDependencies">
      <wsdl:input message="tns:GetDependenciesHttpGetIn" />
      <wsdl:output message="tns:GetDependenciesHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetDistributedEngines">
      <wsdl:input message="tns:GetDistributedEnginesHttpGetIn" />
      <wsdl:output message="tns:GetDistributedEnginesHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetTicketSystems">
      <wsdl:input message="tns:GetTicketSystemsHttpGetIn" />
      <wsdl:output message="tns:GetTicketSystemsHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="AssignSite">
      <wsdl:input message="tns:AssignSiteHttpGetIn" />
      <wsdl:output message="tns:AssignSiteHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="CheckIn">
      <wsdl:input message="tns:CheckInHttpGetIn" />
      <wsdl:output message="tns:CheckInHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="CheckInByKey">
      <wsdl:input message="tns:CheckInByKeyHttpGetIn" />
      <wsdl:output message="tns:CheckInByKeyHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="WhoAmI">
      <wsdl:input message="tns:WhoAmIHttpGetIn" />
      <wsdl:output message="tns:WhoAmIHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetAllGroups">
      <wsdl:input message="tns:GetAllGroupsHttpGetIn" />
      <wsdl:output message="tns:GetAllGroupsHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="AssignUserToGroup">
      <wsdl:input message="tns:AssignUserToGroupHttpGetIn" />
      <wsdl:output message="tns:AssignUserToGroupHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentials">
      <wsdl:input message="tns:GetSSHLoginCredentialsHttpGetIn" />
      <wsdl:output message="tns:GetSSHLoginCredentialsHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentialsWithMachine">
      <wsdl:input message="tns:GetSSHLoginCredentialsWithMachineHttpGetIn" />
      <wsdl:output message="tns:GetSSHLoginCredentialsWithMachineHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchUsers">
      <wsdl:input message="tns:SearchUsersHttpGetIn" />
      <wsdl:output message="tns:SearchUsersHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetUser">
      <wsdl:input message="tns:GetUserHttpGetIn" />
      <wsdl:output message="tns:GetUserHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretItemHistoryByFieldName">
      <wsdl:input message="tns:GetSecretItemHistoryByFieldNameHttpGetIn" />
      <wsdl:output message="tns:GetSecretItemHistoryByFieldNameHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretPolicyForSecret">
      <wsdl:input message="tns:GetSecretPolicyForSecretHttpGetIn" />
      <wsdl:output message="tns:GetSecretPolicyForSecretHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretPolicies">
      <wsdl:input message="tns:SearchSecretPoliciesHttpGetIn" />
      <wsdl:output message="tns:SearchSecretPoliciesHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="RunActiveDirectorySynchronization">
      <wsdl:input message="tns:RunActiveDirectorySynchronizationHttpGetIn" />
      <wsdl:output message="tns:RunActiveDirectorySynchronizationHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetNewSecretPolicy">
      <wsdl:input message="tns:GetNewSecretPolicyHttpGetIn" />
      <wsdl:output message="tns:GetNewSecretPolicyHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSSHCommandMenu">
      <wsdl:input message="tns:GetSSHCommandMenuHttpGetIn" />
      <wsdl:output message="tns:GetSSHCommandMenuHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="DeleteSSHCommandMenu">
      <wsdl:input message="tns:DeleteSSHCommandMenuHttpGetIn" />
      <wsdl:output message="tns:DeleteSSHCommandMenuHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="RestoreSSHCommandMenu">
      <wsdl:input message="tns:RestoreSSHCommandMenuHttpGetIn" />
      <wsdl:output message="tns:RestoreSSHCommandMenuHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetAllScripts">
      <wsdl:input message="tns:GetAllScriptsHttpGetIn" />
      <wsdl:output message="tns:GetAllScriptsHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="GetScript">
      <wsdl:input message="tns:GetScriptHttpGetIn" />
      <wsdl:output message="tns:GetScriptHttpGetOut" />
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:portType name="SSWebServiceHttpPost">
    <wsdl:operation name="ApproveSecretAccessRequest">
      <wsdl:input message="tns:ApproveSecretAccessRequestHttpPostIn" />
      <wsdl:output message="tns:ApproveSecretAccessRequestHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="DenySecretAccessRequest">
      <wsdl:input message="tns:DenySecretAccessRequestHttpPostIn" />
      <wsdl:output message="tns:DenySecretAccessRequestHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="Authenticate">
      <wsdl:input message="tns:AuthenticateHttpPostIn" />
      <wsdl:output message="tns:AuthenticateHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="ImpersonateUser">
      <wsdl:input message="tns:ImpersonateUserHttpPostIn" />
      <wsdl:output message="tns:ImpersonateUserHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="AuthenticateRADIUS">
      <wsdl:input message="tns:AuthenticateRADIUSHttpPostIn" />
      <wsdl:output message="tns:AuthenticateRADIUSHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetTokenIsValid">
      <wsdl:input message="tns:GetTokenIsValidHttpPostIn" />
      <wsdl:output message="tns:GetTokenIsValidHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretLegacy">
      <wsdl:input message="tns:GetSecretLegacyHttpPostIn" />
      <wsdl:output message="tns:GetSecretLegacyHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetCheckOutStatus">
      <wsdl:input message="tns:GetCheckOutStatusHttpPostIn" />
      <wsdl:output message="tns:GetCheckOutStatusHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="ChangePassword">
      <wsdl:input message="tns:ChangePasswordHttpPostIn" />
      <wsdl:output message="tns:ChangePasswordHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByFieldValue">
      <wsdl:input message="tns:GetSecretsByFieldValueHttpPostIn" />
      <wsdl:output message="tns:GetSecretsByFieldValueHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFieldValue">
      <wsdl:input message="tns:SearchSecretsByFieldValueHttpPostIn" />
      <wsdl:output message="tns:SearchSecretsByFieldValueHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByExposedFieldValue">
      <wsdl:input message="tns:GetSecretsByExposedFieldValueHttpPostIn" />
      <wsdl:output message="tns:GetSecretsByExposedFieldValueHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedFieldValue">
      <wsdl:input message="tns:SearchSecretsByExposedFieldValueHttpPostIn" />
      <wsdl:output message="tns:SearchSecretsByExposedFieldValueHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedValues">
      <wsdl:input message="tns:SearchSecretsByExposedValuesHttpPostIn" />
      <wsdl:output message="tns:SearchSecretsByExposedValuesHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsLegacy">
      <wsdl:input message="tns:SearchSecretsLegacyHttpPostIn" />
      <wsdl:output message="tns:SearchSecretsLegacyHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetFavorites">
      <wsdl:input message="tns:GetFavoritesHttpPostIn" />
      <wsdl:output message="tns:GetFavoritesHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="UpdateIsFavorite">
      <wsdl:input message="tns:UpdateIsFavoriteHttpPostIn" />
      <wsdl:output message="tns:UpdateIsFavoriteHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="AddSecret">
      <wsdl:input message="tns:AddSecretHttpPostIn" />
      <wsdl:output message="tns:AddSecretHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetNewSecret">
      <wsdl:input message="tns:GetNewSecretHttpPostIn" />
      <wsdl:output message="tns:GetNewSecretHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplateFields">
      <wsdl:input message="tns:GetSecretTemplateFieldsHttpPostIn" />
      <wsdl:output message="tns:GetSecretTemplateFieldsHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplates">
      <wsdl:input message="tns:GetSecretTemplatesHttpPostIn" />
      <wsdl:output message="tns:GetSecretTemplatesHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GeneratePassword">
      <wsdl:input message="tns:GeneratePasswordHttpPostIn" />
      <wsdl:output message="tns:GeneratePasswordHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="DeactivateSecret">
      <wsdl:input message="tns:DeactivateSecretHttpPostIn" />
      <wsdl:output message="tns:DeactivateSecretHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="VersionGet">
      <wsdl:input message="tns:VersionGetHttpPostIn" />
      <wsdl:output message="tns:VersionGetHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderGet">
      <wsdl:input message="tns:FolderGetHttpPostIn" />
      <wsdl:output message="tns:FolderGetHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderGetAllChildren">
      <wsdl:input message="tns:FolderGetAllChildrenHttpPostIn" />
      <wsdl:output message="tns:FolderGetAllChildrenHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderCreate">
      <wsdl:input message="tns:FolderCreateHttpPostIn" />
      <wsdl:output message="tns:FolderCreateHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGet">
      <wsdl:input message="tns:FolderExtendedGetHttpPostIn" />
      <wsdl:output message="tns:FolderExtendedGetHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchFolders">
      <wsdl:input message="tns:SearchFoldersHttpPostIn" />
      <wsdl:output message="tns:SearchFoldersHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachment">
      <wsdl:input message="tns:DownloadFileAttachmentHttpPostIn" />
      <wsdl:output message="tns:DownloadFileAttachmentHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachmentByItemId">
      <wsdl:input message="tns:DownloadFileAttachmentByItemIdHttpPostIn" />
      <wsdl:output message="tns:DownloadFileAttachmentByItemIdHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachment">
      <wsdl:input message="tns:UploadFileAttachmentHttpPostIn" />
      <wsdl:output message="tns:UploadFileAttachmentHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachmentByItemId">
      <wsdl:input message="tns:UploadFileAttachmentByItemIdHttpPostIn" />
      <wsdl:output message="tns:UploadFileAttachmentByItemIdHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="ExpireSecret">
      <wsdl:input message="tns:ExpireSecretHttpPostIn" />
      <wsdl:output message="tns:ExpireSecretHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="ImportXML">
      <wsdl:input message="tns:ImportXMLHttpPostIn" />
      <wsdl:output message="tns:ImportXMLHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretAudit">
      <wsdl:input message="tns:GetSecretAuditHttpPostIn" />
      <wsdl:output message="tns:GetSecretAuditHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="RemoveDependency">
      <wsdl:input message="tns:RemoveDependencyHttpPostIn" />
      <wsdl:output message="tns:RemoveDependencyHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetDependencies">
      <wsdl:input message="tns:GetDependenciesHttpPostIn" />
      <wsdl:output message="tns:GetDependenciesHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetDistributedEngines">
      <wsdl:input message="tns:GetDistributedEnginesHttpPostIn" />
      <wsdl:output message="tns:GetDistributedEnginesHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetTicketSystems">
      <wsdl:input message="tns:GetTicketSystemsHttpPostIn" />
      <wsdl:output message="tns:GetTicketSystemsHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="AssignSite">
      <wsdl:input message="tns:AssignSiteHttpPostIn" />
      <wsdl:output message="tns:AssignSiteHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="CheckIn">
      <wsdl:input message="tns:CheckInHttpPostIn" />
      <wsdl:output message="tns:CheckInHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="CheckInByKey">
      <wsdl:input message="tns:CheckInByKeyHttpPostIn" />
      <wsdl:output message="tns:CheckInByKeyHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="WhoAmI">
      <wsdl:input message="tns:WhoAmIHttpPostIn" />
      <wsdl:output message="tns:WhoAmIHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetAllGroups">
      <wsdl:input message="tns:GetAllGroupsHttpPostIn" />
      <wsdl:output message="tns:GetAllGroupsHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="AssignUserToGroup">
      <wsdl:input message="tns:AssignUserToGroupHttpPostIn" />
      <wsdl:output message="tns:AssignUserToGroupHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentials">
      <wsdl:input message="tns:GetSSHLoginCredentialsHttpPostIn" />
      <wsdl:output message="tns:GetSSHLoginCredentialsHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentialsWithMachine">
      <wsdl:input message="tns:GetSSHLoginCredentialsWithMachineHttpPostIn" />
      <wsdl:output message="tns:GetSSHLoginCredentialsWithMachineHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchUsers">
      <wsdl:input message="tns:SearchUsersHttpPostIn" />
      <wsdl:output message="tns:SearchUsersHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetUser">
      <wsdl:input message="tns:GetUserHttpPostIn" />
      <wsdl:output message="tns:GetUserHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretItemHistoryByFieldName">
      <wsdl:input message="tns:GetSecretItemHistoryByFieldNameHttpPostIn" />
      <wsdl:output message="tns:GetSecretItemHistoryByFieldNameHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSecretPolicyForSecret">
      <wsdl:input message="tns:GetSecretPolicyForSecretHttpPostIn" />
      <wsdl:output message="tns:GetSecretPolicyForSecretHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="SearchSecretPolicies">
      <wsdl:input message="tns:SearchSecretPoliciesHttpPostIn" />
      <wsdl:output message="tns:SearchSecretPoliciesHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="RunActiveDirectorySynchronization">
      <wsdl:input message="tns:RunActiveDirectorySynchronizationHttpPostIn" />
      <wsdl:output message="tns:RunActiveDirectorySynchronizationHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetNewSecretPolicy">
      <wsdl:input message="tns:GetNewSecretPolicyHttpPostIn" />
      <wsdl:output message="tns:GetNewSecretPolicyHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetSSHCommandMenu">
      <wsdl:input message="tns:GetSSHCommandMenuHttpPostIn" />
      <wsdl:output message="tns:GetSSHCommandMenuHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="DeleteSSHCommandMenu">
      <wsdl:input message="tns:DeleteSSHCommandMenuHttpPostIn" />
      <wsdl:output message="tns:DeleteSSHCommandMenuHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="RestoreSSHCommandMenu">
      <wsdl:input message="tns:RestoreSSHCommandMenuHttpPostIn" />
      <wsdl:output message="tns:RestoreSSHCommandMenuHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetAllScripts">
      <wsdl:input message="tns:GetAllScriptsHttpPostIn" />
      <wsdl:output message="tns:GetAllScriptsHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="GetScript">
      <wsdl:input message="tns:GetScriptHttpPostIn" />
      <wsdl:output message="tns:GetScriptHttpPostOut" />
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:binding name="SSWebServiceSoap" type="tns:SSWebServiceSoap">
    <soap:binding transport="http://schemas.xmlsoap.org/soap/http" />
    <wsdl:operation name="ApproveSecretAccessRequest">
      <soap:operation soapAction="urn:thesecretserver.com/ApproveSecretAccessRequest" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DenySecretAccessRequest">
      <soap:operation soapAction="urn:thesecretserver.com/DenySecretAccessRequest" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="Authenticate">
      <soap:operation soapAction="urn:thesecretserver.com/Authenticate" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ImpersonateUser">
      <soap:operation soapAction="urn:thesecretserver.com/ImpersonateUser" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AuthenticateRADIUS">
      <soap:operation soapAction="urn:thesecretserver.com/AuthenticateRADIUS" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetTokenIsValid">
      <soap:operation soapAction="urn:thesecretserver.com/GetTokenIsValid" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretLegacy">
      <soap:operation soapAction="urn:thesecretserver.com/GetSecretLegacy" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecret">
      <soap:operation soapAction="urn:thesecretserver.com/GetSecret" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetCheckOutStatus">
      <soap:operation soapAction="urn:thesecretserver.com/GetCheckOutStatus" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ChangePassword">
      <soap:operation soapAction="urn:thesecretserver.com/ChangePassword" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByFieldValue">
      <soap:operation soapAction="urn:thesecretserver.com/GetSecretsByFieldValue" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFieldValue">
      <soap:operation soapAction="urn:thesecretserver.com/SearchSecretsByFieldValue" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByExposedFieldValue">
      <soap:operation soapAction="urn:thesecretserver.com/GetSecretsByExposedFieldValue" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedFieldValue">
      <soap:operation soapAction="urn:thesecretserver.com/SearchSecretsByExposedFieldValue" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedValues">
      <soap:operation soapAction="urn:thesecretserver.com/SearchSecretsByExposedValues" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddUser">
      <soap:operation soapAction="urn:thesecretserver.com/AddUser" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecrets">
      <soap:operation soapAction="urn:thesecretserver.com/SearchSecrets" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsLegacy">
      <soap:operation soapAction="urn:thesecretserver.com/SearchSecretsLegacy" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFolder">
      <soap:operation soapAction="urn:thesecretserver.com/SearchSecretsByFolder" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFolderLegacy">
      <soap:operation soapAction="urn:thesecretserver.com/SearchSecretsByFolderLegacy" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetFavorites">
      <soap:operation soapAction="urn:thesecretserver.com/GetFavorites" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateIsFavorite">
      <soap:operation soapAction="urn:thesecretserver.com/UpdateIsFavorite" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddSecret">
      <soap:operation soapAction="urn:thesecretserver.com/AddSecret" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddNewSecret">
      <soap:operation soapAction="urn:thesecretserver.com/AddNewSecret" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetNewSecret">
      <soap:operation soapAction="urn:thesecretserver.com/GetNewSecret" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplateFields">
      <soap:operation soapAction="urn:thesecretserver.com/GetSecretTemplateFields" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateSecret">
      <soap:operation soapAction="urn:thesecretserver.com/UpdateSecret" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplates">
      <soap:operation soapAction="urn:thesecretserver.com/GetSecretTemplates" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GeneratePassword">
      <soap:operation soapAction="urn:thesecretserver.com/GeneratePassword" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DeactivateSecret">
      <soap:operation soapAction="urn:thesecretserver.com/DeactivateSecret" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="VersionGet">
      <soap:operation soapAction="urn:thesecretserver.com/VersionGet" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderGet">
      <soap:operation soapAction="urn:thesecretserver.com/FolderGet" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderUpdate">
      <soap:operation soapAction="urn:thesecretserver.com/FolderUpdate" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderGetAllChildren">
      <soap:operation soapAction="urn:thesecretserver.com/FolderGetAllChildren" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderCreate">
      <soap:operation soapAction="urn:thesecretserver.com/FolderCreate" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedCreate">
      <soap:operation soapAction="urn:thesecretserver.com/FolderExtendedCreate" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGet">
      <soap:operation soapAction="urn:thesecretserver.com/FolderExtendedGet" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedUpdate">
      <soap:operation soapAction="urn:thesecretserver.com/FolderExtendedUpdate" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGetNew">
      <soap:operation soapAction="urn:thesecretserver.com/FolderExtendedGetNew" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchFolders">
      <soap:operation soapAction="urn:thesecretserver.com/SearchFolders" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachment">
      <soap:operation soapAction="urn:thesecretserver.com/DownloadFileAttachment" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachmentByItemId">
      <soap:operation soapAction="urn:thesecretserver.com/DownloadFileAttachmentByItemId" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachment">
      <soap:operation soapAction="urn:thesecretserver.com/UploadFileAttachment" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachmentByItemId">
      <soap:operation soapAction="urn:thesecretserver.com/UploadFileAttachmentByItemId" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ExpireSecret">
      <soap:operation soapAction="urn:thesecretserver.com/ExpireSecret" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SetCheckOutEnabled">
      <soap:operation soapAction="urn:thesecretserver.com/SetCheckOutEnabled" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ImportXML">
      <soap:operation soapAction="urn:thesecretserver.com/ImportXML" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretAudit">
      <soap:operation soapAction="urn:thesecretserver.com/GetSecretAudit" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddDependency">
      <soap:operation soapAction="urn:thesecretserver.com/AddDependency" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RemoveDependency">
      <soap:operation soapAction="urn:thesecretserver.com/RemoveDependency" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetDependencies">
      <soap:operation soapAction="urn:thesecretserver.com/GetDependencies" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetDistributedEngines">
      <soap:operation soapAction="urn:thesecretserver.com/GetDistributedEngines" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetTicketSystems">
      <soap:operation soapAction="urn:thesecretserver.com/GetTicketSystems" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignSite">
      <soap:operation soapAction="urn:thesecretserver.com/AssignSite" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="CheckIn">
      <soap:operation soapAction="urn:thesecretserver.com/CheckIn" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddSecretCustomAudit">
      <soap:operation soapAction="urn:thesecretserver.com/AddSecretCustomAudit" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateSecretPermission">
      <soap:operation soapAction="urn:thesecretserver.com/UpdateSecretPermission" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="CheckInByKey">
      <soap:operation soapAction="urn:thesecretserver.com/CheckInByKey" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="WhoAmI">
      <soap:operation soapAction="urn:thesecretserver.com/WhoAmI" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllGroups">
      <soap:operation soapAction="urn:thesecretserver.com/GetAllGroups" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignUserToGroup">
      <soap:operation soapAction="urn:thesecretserver.com/AssignUserToGroup" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentials">
      <soap:operation soapAction="urn:thesecretserver.com/GetSSHLoginCredentials" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentialsWithMachine">
      <soap:operation soapAction="urn:thesecretserver.com/GetSSHLoginCredentialsWithMachine" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchUsers">
      <soap:operation soapAction="urn:thesecretserver.com/SearchUsers" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetUser">
      <soap:operation soapAction="urn:thesecretserver.com/GetUser" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateUser">
      <soap:operation soapAction="urn:thesecretserver.com/UpdateUser" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretItemHistoryByFieldName">
      <soap:operation soapAction="urn:thesecretserver.com/GetSecretItemHistoryByFieldName" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretPolicyForSecret">
      <soap:operation soapAction="urn:thesecretserver.com/GetSecretPolicyForSecret" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignSecretPolicyForSecret">
      <soap:operation soapAction="urn:thesecretserver.com/AssignSecretPolicyForSecret" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretPolicies">
      <soap:operation soapAction="urn:thesecretserver.com/SearchSecretPolicies" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RunActiveDirectorySynchronization">
      <soap:operation soapAction="urn:thesecretserver.com/RunActiveDirectorySynchronization" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddGroupToActiveDirectorySynchronization">
      <soap:operation soapAction="urn:thesecretserver.com/AddGroupToActiveDirectorySynchronization" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddSecretPolicy">
      <soap:operation soapAction="urn:thesecretserver.com/AddSecretPolicy" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetNewSecretPolicy">
      <soap:operation soapAction="urn:thesecretserver.com/GetNewSecretPolicy" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHCommandMenu">
      <soap:operation soapAction="urn:thesecretserver.com/GetSSHCommandMenu" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SaveSSHCommandMenu">
      <soap:operation soapAction="urn:thesecretserver.com/SaveSSHCommandMenu" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllSSHCommandMenus">
      <soap:operation soapAction="urn:thesecretserver.com/GetAllSSHCommandMenus" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DeleteSSHCommandMenu">
      <soap:operation soapAction="urn:thesecretserver.com/DeleteSSHCommandMenu" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RestoreSSHCommandMenu">
      <soap:operation soapAction="urn:thesecretserver.com/RestoreSSHCommandMenu" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddScript">
      <soap:operation soapAction="urn:thesecretserver.com/AddScript" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllScripts">
      <soap:operation soapAction="urn:thesecretserver.com/GetAllScripts" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetScript">
      <soap:operation soapAction="urn:thesecretserver.com/GetScript" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateScript">
      <soap:operation soapAction="urn:thesecretserver.com/UpdateScript" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="SSWebServiceSoap12" type="tns:SSWebServiceSoap">
    <soap12:binding transport="http://schemas.xmlsoap.org/soap/http" />
    <wsdl:operation name="ApproveSecretAccessRequest">
      <soap12:operation soapAction="urn:thesecretserver.com/ApproveSecretAccessRequest" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DenySecretAccessRequest">
      <soap12:operation soapAction="urn:thesecretserver.com/DenySecretAccessRequest" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="Authenticate">
      <soap12:operation soapAction="urn:thesecretserver.com/Authenticate" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ImpersonateUser">
      <soap12:operation soapAction="urn:thesecretserver.com/ImpersonateUser" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AuthenticateRADIUS">
      <soap12:operation soapAction="urn:thesecretserver.com/AuthenticateRADIUS" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetTokenIsValid">
      <soap12:operation soapAction="urn:thesecretserver.com/GetTokenIsValid" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretLegacy">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSecretLegacy" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecret">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSecret" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetCheckOutStatus">
      <soap12:operation soapAction="urn:thesecretserver.com/GetCheckOutStatus" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ChangePassword">
      <soap12:operation soapAction="urn:thesecretserver.com/ChangePassword" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByFieldValue">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSecretsByFieldValue" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFieldValue">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchSecretsByFieldValue" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByExposedFieldValue">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSecretsByExposedFieldValue" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedFieldValue">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchSecretsByExposedFieldValue" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedValues">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchSecretsByExposedValues" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddUser">
      <soap12:operation soapAction="urn:thesecretserver.com/AddUser" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecrets">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchSecrets" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsLegacy">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchSecretsLegacy" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFolder">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchSecretsByFolder" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFolderLegacy">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchSecretsByFolderLegacy" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetFavorites">
      <soap12:operation soapAction="urn:thesecretserver.com/GetFavorites" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateIsFavorite">
      <soap12:operation soapAction="urn:thesecretserver.com/UpdateIsFavorite" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddSecret">
      <soap12:operation soapAction="urn:thesecretserver.com/AddSecret" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddNewSecret">
      <soap12:operation soapAction="urn:thesecretserver.com/AddNewSecret" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetNewSecret">
      <soap12:operation soapAction="urn:thesecretserver.com/GetNewSecret" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplateFields">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSecretTemplateFields" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateSecret">
      <soap12:operation soapAction="urn:thesecretserver.com/UpdateSecret" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplates">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSecretTemplates" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GeneratePassword">
      <soap12:operation soapAction="urn:thesecretserver.com/GeneratePassword" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DeactivateSecret">
      <soap12:operation soapAction="urn:thesecretserver.com/DeactivateSecret" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="VersionGet">
      <soap12:operation soapAction="urn:thesecretserver.com/VersionGet" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderGet">
      <soap12:operation soapAction="urn:thesecretserver.com/FolderGet" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderUpdate">
      <soap12:operation soapAction="urn:thesecretserver.com/FolderUpdate" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderGetAllChildren">
      <soap12:operation soapAction="urn:thesecretserver.com/FolderGetAllChildren" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderCreate">
      <soap12:operation soapAction="urn:thesecretserver.com/FolderCreate" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedCreate">
      <soap12:operation soapAction="urn:thesecretserver.com/FolderExtendedCreate" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGet">
      <soap12:operation soapAction="urn:thesecretserver.com/FolderExtendedGet" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedUpdate">
      <soap12:operation soapAction="urn:thesecretserver.com/FolderExtendedUpdate" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGetNew">
      <soap12:operation soapAction="urn:thesecretserver.com/FolderExtendedGetNew" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchFolders">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchFolders" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachment">
      <soap12:operation soapAction="urn:thesecretserver.com/DownloadFileAttachment" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachmentByItemId">
      <soap12:operation soapAction="urn:thesecretserver.com/DownloadFileAttachmentByItemId" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachment">
      <soap12:operation soapAction="urn:thesecretserver.com/UploadFileAttachment" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachmentByItemId">
      <soap12:operation soapAction="urn:thesecretserver.com/UploadFileAttachmentByItemId" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ExpireSecret">
      <soap12:operation soapAction="urn:thesecretserver.com/ExpireSecret" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SetCheckOutEnabled">
      <soap12:operation soapAction="urn:thesecretserver.com/SetCheckOutEnabled" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ImportXML">
      <soap12:operation soapAction="urn:thesecretserver.com/ImportXML" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretAudit">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSecretAudit" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddDependency">
      <soap12:operation soapAction="urn:thesecretserver.com/AddDependency" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RemoveDependency">
      <soap12:operation soapAction="urn:thesecretserver.com/RemoveDependency" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetDependencies">
      <soap12:operation soapAction="urn:thesecretserver.com/GetDependencies" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetDistributedEngines">
      <soap12:operation soapAction="urn:thesecretserver.com/GetDistributedEngines" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetTicketSystems">
      <soap12:operation soapAction="urn:thesecretserver.com/GetTicketSystems" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignSite">
      <soap12:operation soapAction="urn:thesecretserver.com/AssignSite" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="CheckIn">
      <soap12:operation soapAction="urn:thesecretserver.com/CheckIn" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddSecretCustomAudit">
      <soap12:operation soapAction="urn:thesecretserver.com/AddSecretCustomAudit" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateSecretPermission">
      <soap12:operation soapAction="urn:thesecretserver.com/UpdateSecretPermission" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="CheckInByKey">
      <soap12:operation soapAction="urn:thesecretserver.com/CheckInByKey" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="WhoAmI">
      <soap12:operation soapAction="urn:thesecretserver.com/WhoAmI" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllGroups">
      <soap12:operation soapAction="urn:thesecretserver.com/GetAllGroups" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignUserToGroup">
      <soap12:operation soapAction="urn:thesecretserver.com/AssignUserToGroup" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentials">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSSHLoginCredentials" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentialsWithMachine">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSSHLoginCredentialsWithMachine" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchUsers">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchUsers" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetUser">
      <soap12:operation soapAction="urn:thesecretserver.com/GetUser" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateUser">
      <soap12:operation soapAction="urn:thesecretserver.com/UpdateUser" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretItemHistoryByFieldName">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSecretItemHistoryByFieldName" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretPolicyForSecret">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSecretPolicyForSecret" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignSecretPolicyForSecret">
      <soap12:operation soapAction="urn:thesecretserver.com/AssignSecretPolicyForSecret" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretPolicies">
      <soap12:operation soapAction="urn:thesecretserver.com/SearchSecretPolicies" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RunActiveDirectorySynchronization">
      <soap12:operation soapAction="urn:thesecretserver.com/RunActiveDirectorySynchronization" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddGroupToActiveDirectorySynchronization">
      <soap12:operation soapAction="urn:thesecretserver.com/AddGroupToActiveDirectorySynchronization" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddSecretPolicy">
      <soap12:operation soapAction="urn:thesecretserver.com/AddSecretPolicy" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetNewSecretPolicy">
      <soap12:operation soapAction="urn:thesecretserver.com/GetNewSecretPolicy" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHCommandMenu">
      <soap12:operation soapAction="urn:thesecretserver.com/GetSSHCommandMenu" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SaveSSHCommandMenu">
      <soap12:operation soapAction="urn:thesecretserver.com/SaveSSHCommandMenu" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllSSHCommandMenus">
      <soap12:operation soapAction="urn:thesecretserver.com/GetAllSSHCommandMenus" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DeleteSSHCommandMenu">
      <soap12:operation soapAction="urn:thesecretserver.com/DeleteSSHCommandMenu" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RestoreSSHCommandMenu">
      <soap12:operation soapAction="urn:thesecretserver.com/RestoreSSHCommandMenu" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddScript">
      <soap12:operation soapAction="urn:thesecretserver.com/AddScript" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllScripts">
      <soap12:operation soapAction="urn:thesecretserver.com/GetAllScripts" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetScript">
      <soap12:operation soapAction="urn:thesecretserver.com/GetScript" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateScript">
      <soap12:operation soapAction="urn:thesecretserver.com/UpdateScript" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="SSWebServiceHttpGet" type="tns:SSWebServiceHttpGet">
    <http:binding verb="GET" />
    <wsdl:operation name="ApproveSecretAccessRequest">
      <http:operation location="/ApproveSecretAccessRequest" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DenySecretAccessRequest">
      <http:operation location="/DenySecretAccessRequest" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="Authenticate">
      <http:operation location="/Authenticate" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ImpersonateUser">
      <http:operation location="/ImpersonateUser" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AuthenticateRADIUS">
      <http:operation location="/AuthenticateRADIUS" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetTokenIsValid">
      <http:operation location="/GetTokenIsValid" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretLegacy">
      <http:operation location="/GetSecretLegacy" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetCheckOutStatus">
      <http:operation location="/GetCheckOutStatus" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ChangePassword">
      <http:operation location="/ChangePassword" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByFieldValue">
      <http:operation location="/GetSecretsByFieldValue" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFieldValue">
      <http:operation location="/SearchSecretsByFieldValue" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByExposedFieldValue">
      <http:operation location="/GetSecretsByExposedFieldValue" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedFieldValue">
      <http:operation location="/SearchSecretsByExposedFieldValue" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedValues">
      <http:operation location="/SearchSecretsByExposedValues" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsLegacy">
      <http:operation location="/SearchSecretsLegacy" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetFavorites">
      <http:operation location="/GetFavorites" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateIsFavorite">
      <http:operation location="/UpdateIsFavorite" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddSecret">
      <http:operation location="/AddSecret" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetNewSecret">
      <http:operation location="/GetNewSecret" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplateFields">
      <http:operation location="/GetSecretTemplateFields" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplates">
      <http:operation location="/GetSecretTemplates" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GeneratePassword">
      <http:operation location="/GeneratePassword" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DeactivateSecret">
      <http:operation location="/DeactivateSecret" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="VersionGet">
      <http:operation location="/VersionGet" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderGet">
      <http:operation location="/FolderGet" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderGetAllChildren">
      <http:operation location="/FolderGetAllChildren" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderCreate">
      <http:operation location="/FolderCreate" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGet">
      <http:operation location="/FolderExtendedGet" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchFolders">
      <http:operation location="/SearchFolders" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachment">
      <http:operation location="/DownloadFileAttachment" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachmentByItemId">
      <http:operation location="/DownloadFileAttachmentByItemId" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachment">
      <http:operation location="/UploadFileAttachment" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachmentByItemId">
      <http:operation location="/UploadFileAttachmentByItemId" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ExpireSecret">
      <http:operation location="/ExpireSecret" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ImportXML">
      <http:operation location="/ImportXML" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretAudit">
      <http:operation location="/GetSecretAudit" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RemoveDependency">
      <http:operation location="/RemoveDependency" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetDependencies">
      <http:operation location="/GetDependencies" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetDistributedEngines">
      <http:operation location="/GetDistributedEngines" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetTicketSystems">
      <http:operation location="/GetTicketSystems" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignSite">
      <http:operation location="/AssignSite" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="CheckIn">
      <http:operation location="/CheckIn" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="CheckInByKey">
      <http:operation location="/CheckInByKey" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="WhoAmI">
      <http:operation location="/WhoAmI" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllGroups">
      <http:operation location="/GetAllGroups" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignUserToGroup">
      <http:operation location="/AssignUserToGroup" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentials">
      <http:operation location="/GetSSHLoginCredentials" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentialsWithMachine">
      <http:operation location="/GetSSHLoginCredentialsWithMachine" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchUsers">
      <http:operation location="/SearchUsers" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetUser">
      <http:operation location="/GetUser" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretItemHistoryByFieldName">
      <http:operation location="/GetSecretItemHistoryByFieldName" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretPolicyForSecret">
      <http:operation location="/GetSecretPolicyForSecret" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretPolicies">
      <http:operation location="/SearchSecretPolicies" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RunActiveDirectorySynchronization">
      <http:operation location="/RunActiveDirectorySynchronization" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetNewSecretPolicy">
      <http:operation location="/GetNewSecretPolicy" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHCommandMenu">
      <http:operation location="/GetSSHCommandMenu" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DeleteSSHCommandMenu">
      <http:operation location="/DeleteSSHCommandMenu" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RestoreSSHCommandMenu">
      <http:operation location="/RestoreSSHCommandMenu" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllScripts">
      <http:operation location="/GetAllScripts" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetScript">
      <http:operation location="/GetScript" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="SSWebServiceHttpPost" type="tns:SSWebServiceHttpPost">
    <http:binding verb="POST" />
    <wsdl:operation name="ApproveSecretAccessRequest">
      <http:operation location="/ApproveSecretAccessRequest" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DenySecretAccessRequest">
      <http:operation location="/DenySecretAccessRequest" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="Authenticate">
      <http:operation location="/Authenticate" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ImpersonateUser">
      <http:operation location="/ImpersonateUser" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AuthenticateRADIUS">
      <http:operation location="/AuthenticateRADIUS" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetTokenIsValid">
      <http:operation location="/GetTokenIsValid" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretLegacy">
      <http:operation location="/GetSecretLegacy" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetCheckOutStatus">
      <http:operation location="/GetCheckOutStatus" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ChangePassword">
      <http:operation location="/ChangePassword" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByFieldValue">
      <http:operation location="/GetSecretsByFieldValue" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByFieldValue">
      <http:operation location="/SearchSecretsByFieldValue" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretsByExposedFieldValue">
      <http:operation location="/GetSecretsByExposedFieldValue" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedFieldValue">
      <http:operation location="/SearchSecretsByExposedFieldValue" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsByExposedValues">
      <http:operation location="/SearchSecretsByExposedValues" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretsLegacy">
      <http:operation location="/SearchSecretsLegacy" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetFavorites">
      <http:operation location="/GetFavorites" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UpdateIsFavorite">
      <http:operation location="/UpdateIsFavorite" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AddSecret">
      <http:operation location="/AddSecret" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetNewSecret">
      <http:operation location="/GetNewSecret" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplateFields">
      <http:operation location="/GetSecretTemplateFields" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretTemplates">
      <http:operation location="/GetSecretTemplates" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GeneratePassword">
      <http:operation location="/GeneratePassword" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DeactivateSecret">
      <http:operation location="/DeactivateSecret" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="VersionGet">
      <http:operation location="/VersionGet" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderGet">
      <http:operation location="/FolderGet" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderGetAllChildren">
      <http:operation location="/FolderGetAllChildren" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderCreate">
      <http:operation location="/FolderCreate" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="FolderExtendedGet">
      <http:operation location="/FolderExtendedGet" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchFolders">
      <http:operation location="/SearchFolders" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachment">
      <http:operation location="/DownloadFileAttachment" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DownloadFileAttachmentByItemId">
      <http:operation location="/DownloadFileAttachmentByItemId" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachment">
      <http:operation location="/UploadFileAttachment" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="UploadFileAttachmentByItemId">
      <http:operation location="/UploadFileAttachmentByItemId" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ExpireSecret">
      <http:operation location="/ExpireSecret" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="ImportXML">
      <http:operation location="/ImportXML" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretAudit">
      <http:operation location="/GetSecretAudit" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RemoveDependency">
      <http:operation location="/RemoveDependency" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetDependencies">
      <http:operation location="/GetDependencies" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetDistributedEngines">
      <http:operation location="/GetDistributedEngines" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetTicketSystems">
      <http:operation location="/GetTicketSystems" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignSite">
      <http:operation location="/AssignSite" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="CheckIn">
      <http:operation location="/CheckIn" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="CheckInByKey">
      <http:operation location="/CheckInByKey" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="WhoAmI">
      <http:operation location="/WhoAmI" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllGroups">
      <http:operation location="/GetAllGroups" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="AssignUserToGroup">
      <http:operation location="/AssignUserToGroup" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentials">
      <http:operation location="/GetSSHLoginCredentials" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHLoginCredentialsWithMachine">
      <http:operation location="/GetSSHLoginCredentialsWithMachine" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchUsers">
      <http:operation location="/SearchUsers" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetUser">
      <http:operation location="/GetUser" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretItemHistoryByFieldName">
      <http:operation location="/GetSecretItemHistoryByFieldName" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSecretPolicyForSecret">
      <http:operation location="/GetSecretPolicyForSecret" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="SearchSecretPolicies">
      <http:operation location="/SearchSecretPolicies" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RunActiveDirectorySynchronization">
      <http:operation location="/RunActiveDirectorySynchronization" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetNewSecretPolicy">
      <http:operation location="/GetNewSecretPolicy" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetSSHCommandMenu">
      <http:operation location="/GetSSHCommandMenu" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DeleteSSHCommandMenu">
      <http:operation location="/DeleteSSHCommandMenu" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="RestoreSSHCommandMenu">
      <http:operation location="/RestoreSSHCommandMenu" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetAllScripts">
      <http:operation location="/GetAllScripts" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="GetScript">
      <http:operation location="/GetScript" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:service name="SSWebService">
    <wsdl:documentation xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">Webservice for standard integration.</wsdl:documentation>
    <wsdl:port name="SSWebServiceSoap" binding="tns:SSWebServiceSoap">
      <soap:address location="https://blsps.ad.bl.uk/secretserver/webservices/sswebservice.asmx" />
    </wsdl:port>
    <wsdl:port name="SSWebServiceSoap12" binding="tns:SSWebServiceSoap12">
      <soap12:address location="https://blsps.ad.bl.uk/secretserver/webservices/sswebservice.asmx" />
    </wsdl:port>
    <wsdl:port name="SSWebServiceHttpGet" binding="tns:SSWebServiceHttpGet">
      <http:address location="https://blsps.ad.bl.uk/secretserver/webservices/sswebservice.asmx" />
    </wsdl:port>
    <wsdl:port name="SSWebServiceHttpPost" binding="tns:SSWebServiceHttpPost">
      <http:address location="https://blsps.ad.bl.uk/secretserver/webservices/sswebservice.asmx" />
    </wsdl:port>
  </wsdl:service>
</wsdl:definitions>
