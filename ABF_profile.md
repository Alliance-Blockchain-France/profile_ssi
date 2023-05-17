# ABF SSI profile v 0.0.2
Date 18/04/2023

Status : Draft

This document is not a specification, but a profile. It outlines existing specifications required for implementations to interoperate among each other. It also clarifies mandatory to implement features for the optionalities mentioned in the referenced specifications.



## Editors and contributors
* Thierry Thevenet (Talao)
* Christophe Gervais (Agdatahub)
* Christine Hennebert (Nanoelec)
* Antoine Maisonneuve (Orange)

## Table of Contents

- [Use cases](#use-cases)  
        * [IOT](#iot)   
        * [Legal entity](#legal-entity)  
        * [Web3](#web3)  
- [Open Standard Requirements](#open-standards-requirements)  
- [Decentralized Identifiers](#decentralized-identifiers-did)  
        * [Natural Persons](#natural-persons)   
        * [Legal Entities](legal-entities)  
        * [Cryptographic Keys and Signatures](#cryptographic-keys-and-signatures)
- [Verifiable Credentials](#verifiable-credentials)
        * [General Topics](#general-topics)
        * [Bearer Credentials](#bearer-credentials)
        * [Credential Header](#credential-header)   
        * [Credential Payload](#credential-payload)
- [Protocols](#protocols)
- [Wallet](#wallet)
- [Verifiable Data Registries](#verifiable-data-registries)



## Use cases

### Legal Entity and Consent Management
The future European data regulation (Data Governance Act and Data Act) should make it possible to free up data for use, but with rules that are intended to be fair, practical and clear. These rules will simply determine who can access and use what data, for what purpose and for how long. This regulation therefore imposes the obligation of consent before any data exchange.
Like any economic sector, the agricultural community will be subject to these rules, which will help to re-create trust and control the use of agricultural data.

In order to enforce the obligation of consent before any data exchange, a Consent Management System (CMS) has been developed by the company Agdatahub. This principle of consent is based on the digital identity of the farm, user of the data, and the digital identity of the organizations consuming these data (the data recipients). It is indeed a question of guaranteeing the identity of the various actors in order to establish trust, and then to establish a contract, the consent, between these actors. The agricultural digital identity is issued from a regalian data source, in order to reinforce confidence in the uses of this identity: le Registre National des Entreprises (RNE). It consists of 3 verifiable credentials, built from the RNE data:
* The identity of the farm, an legal entity;
* The identity of a natural person, the farmer, manager or partner in the farm;
* The role of the natural person within the farm: this verifiable credential allows the definition of the rights of use of the legal person identity, such as whether or not to issue a consent on behalf of the farm.

In order to take into account the specific needs of the agricultural profession, functionalities for delegating the use of the legal entity identity have also been added for the management of this identity:
* Internal delegation: this involves delegating the use of the legal entity identity to an employee of the farm so that this employee can use the farm's identity to validate a request for consent to exchange data;
* External delegation: many farms, especially in the livestock sector, subcontract the administrative management of the farm to service companies. It is therefore a question of being able to delegate the use of the digital identity of the farm to an employee of an external company, who will be able to use the identity in order to validate requests for consent and manage them.

Regarding consents, they are also managed in the form of verifiable credentials:
1.	In order to be able to collect a type of data from a farm for a given use, the data recipient makes a request for consent, specifying the type of data, the use of this data and the period of validity of the requested consent ;
2.	This request is sent in the form of a QR code to a farmer, who with the help of his mobile Wallet (containing his identity as a physical person as well as his role within the farm) scans this QR code to visualize the request;
3.	If the request is validated, then the farmer, via his wallet, asks the farm's wallet to issue a consent to the requesting beneficiary;
4.	The consent is then issued as a verifiable credential and is stored in the beneficiary's wallet.

When the beneficiary initiates a data exchange to collect farm's data via a data exchange platform, the platform queries the beneficiary company's wallet to verify that it has consent to access that farm's data.

### IOT
The use of physical devices, such as IoT or edge, communicating directly and without intermediary with the blockchain via a smart contract, raises the issue of accountability for the issuing data.
In this use case, a legal entity is registered via a VC, which anchors its legal identity. Subsequently, this legal entity registers the devices it owns and frames their use by specifying the authorised smart contracts recipients. In production mode, the devices are autonomous in issuing transactions to the blockchain according to the specified usage, so that it is possible to verify who is responsible for the issuing object.

### Web3
A user of an ABF member goes to a service that offers the issuance of a loyalty card in the form of an NFT on the condition that this user is of French nationality and over 18 years old. The user presents the identity verifiable credentials he holds in his wallet which meet this requirement. Once identity checks are complete, the user will confirm that they are in control of a crypto account, then the company will issue a non-transferable, non-fungible token (NFT) to the user's crypto account. The NFT does not contain any user identity data; instead, the NFT symbolizes that the user has gone through the company's identity verification process and has a loyalty card. The user can then prove that he holds a loyalty card for all on-chain services of the issuing company and partners.

## Open Standards Requirements

VCs MUST adhere to the [VC Data Model v1.1](https://www.w3.org/TR/vc-data-model/) and be encoded as JSON and signed as JWT as defined in 6.3.1 of VC Data Model v1.1. VCs encoded as JSON-LD and signed using Linked Data Proofs are NOT supported.

For key management and authentication, Self-Issued OpenID Connect Provider v2, an extension to OpenID Connect, MUST be used as defined in [SIOPv2](https://openid.net/specs/openid-connect-self-issued-v2-1_0.html).

For transportation of VCs, First Implementer’s Draft of OpenID for Verifiable Presentations MUST be used as defined in [OpenID4VP](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html).

As the query language, (Presentation Exchange v1.0.0)[https://identity.foundation/presentation-exchange/spec/v1.0.0/] MUST be used and conform to the syntax defined in OpenID4VP ID1.

Decentralized Identifiers (DIDs), as defined in [DID Core](https://identity.foundation/jwt-vc-presentation-profile/#term:did-core), MUST be used as identifiers of the entities.

DID Documents MUST use [JsonWebKey2020](https://www.w3.org/community/reports/credentials/CG-FINAL-lds-jws2020-20220721/#json-web-key-2020) as the type for Verification Material intended for use in the profile. (DID Core section 5.2.1)

Verification Material intended for use in the profile MUST use [publicKeyJwk](https://www.w3.org/TR/did-core/#dfn-publickeyjwk) (DID Core section 5.2.1).

To bind an owner of a DID to a controller of a certain origin, a Well Known DID Configuration MUST be used as defined in [Well Known DID](https://identity.foundation/.well-known/resources/did-configuration/).

For Revocation of VCs, Status List 2021 as defined in [Status List 2021](https://w3c.github.io/vc-status-list-2021/) MUST be discovered using an HTTPS URL.


## Decentralized identifiers (DID)

### Natural Persons

Decentralized Identifiers (DIDs), as defined in [DID Core](https://identity.foundation/jwt-vc-presentation-profile/#term:did-core) , MUST be used as identifiers of natural person entities. Implementations MUST support 'did:key', and 'did:ebsi'  as mandatory DID methods.

#### `did:key`for natural persons

The `did:key` method is used to express public keys in a way that doesn't
require a DID Registry of any kind. Its general format is:

```
did:key:<multibase encoded, multicodec identified, public key>
```

So, for example, the following DID would be derived from a base-58 encoded
ed25519 public key:

```
did:key:z6MkpTHR8VNsBxYAAWHut2Geadd9jSwuBV8xRoAnwWsdvktH
```
A complete description of this method is available  [here](https://w3c-ccg.github.io/did-method-key/).

#### `did:key`for EBSI natural person

The 'did:key' method used by EBSI is based on a specific [multicodec](https://github.com/multiformats/multicodec/blob/master/table.csv#L514). A complete description of this method is available [here](https://api-pilot.ebsi.eu/docs/libraries/ebsi-did-resolver).

### Legal Entities
Decentralized Identifiers (DIDs), as defined in [DID Core](https://identity.foundation/jwt-vc-presentation-profile/#term:did-core) , MUST be used as identifiers of legal entities. Implementations MUST support 'did:ebsi', 'did:ala' and 'did:web'  as mandatory DID methods as defined in [did:web](https://w3c-ccg.github.io/did-method-web/),  [did:ala](https://github.com/alastria/alastria-identity/wiki/Alastria-DID-Method-Specification) and [did:ebsi](https://ec.europa.eu/digital-building-blocks/wikis/display/EBSIDOC/EBSI+DID+Method#EBSIDIDMethod-DIDDocumentforEBSIDIDLE).

Each memeber is responsible for its own registration with EBSI or ALASTRIA ecosystem.

For companies that do not have their own decentralized identifiers, a quick and simple method is possible through the did:web method. The target system of the Web DID method is the domain name when the domain specified by the DID is resolved through the Domain Name System (DNS). Thanks to that method one can setup a comany DID with multiple cryptographic keys in less than one hour with just a text editor an a server access to the root of the domain. Here an example of a DID Document for [did:web:talao.co](https://dev.uniresolver.io/1.0/identifiers/did:web:talao.co).  

X509 certificates are NOT supported.

Implementers will find several libs to resolve those DIDs locally in issuer, verififers and wallets and the [Universal Resolver](https://dev.uniresolver.io/) maybe used as an simple but centralized almlternative solution.

### Orange proposal for legal entities
The goal will be to reuse eIDAS digital certificates for identity binding, it does not make sense to “invent” identifiers or to promote the usage of different DID methods that are not well integrated with eIDAS certificates and that generate identifiers which are not in general legally recognised in the EU for economic transactions (e.g., that can be used in electronic invoices across the EU).

In general, an ecosystem may accept one or more DID methods and their associated DID resolution mechanisms (e.g., did:web, did:peer, etc.). For Legal Persons, we propose that the main method used is did:elsi (ETSI Legal person Semantic Identifier Method Specification), which uses as identifiers the same identifiers that are already embedded in the eIDAS certificates that conform to the relevant ETSI standards. The main concepts of the did:elsi method is described below.

#### ETSI :
ETSI EN 319 412-3 V1.2.1 (2020-07) “Electronic Signatures and Infrastructures (ESI); Certificate Profiles; Part 3: Certificate profile for certificates issued to legal persons” states:
The subject field shall include at least the following attributes as specified in Recommendation ITU-T X.520: 
* countryName
* organizationName
* organizationIdentifier and
* commonName

And regarding the organizationIdentifier attribute it says:
"The organizationIdentifier attribute shall contain an identification of the subject organization different from the organization name. Certificates may include one or more semantics identifiers as specified in clause 5 of ETSI EN 319 412-1 [i.4]."

And the document referenced, ETSI EN 319 412-1 V1.4.2 (2020-07) “Electronic Signatures and Infrastructures (ESI); Certificate Profiles; Part 1: Overview and common data structures” states:

When the legal person semantics identifier is included, any present organizationIdentifier attribute in the subject field shall contain information using the following structure in the presented order: 
* 3 character legal person identity type reference
* 2 character ISO 3166 [2] country code 
* hyphen-minus "-" (0x2D (ASCII), U+002D (UTF-8)) and
* identifier (according to country and identity type reference)

The three initial characters shall have one of the following defined values: 
1.	"VAT" for identification based on a national value added tax identification number. 
2.	"NTR" for identification based on an identifier from a national trade register. 
3.	"PSD" for identification based on the national authorization number of a payment service provider under Payments Services Directive (EU) 2015/2366 [i.13]. This shall use the extended structure as defined in ETSI TS 119 495 [3], clause 5.2.1.

"LEI" for a global Legal Entity Identifier as specified in ISO 17442 [4]. The 2 character ISO 3166 [2] country code shall be set to 'XG'.
Two characters according to local definition within the specified country and name registration authority, identifying a national scheme that is considered appropriate for national and European level, followed by the character ":" (colon). 

Other initial character sequences are reserved for future amendments of the present document. In case "VAT" legal person identity type reference is used in combination with the "EU" transnational country code, the identifier value should comply with Council Directive 2006/112/EC [i.12], article 215.


#### Examples :
An"y eIDAS digital certificate issued by TSPs to legal persons compliant with the ETSI standards including an organizationIdentifier attribute can be used to trivially derive a DID from the ETSI standard identifier by applying the following rule:
* did:elsi:organizationIdentifier
* Some examples of DIDs are:
* Gaia-X: did:elsi:VATBE-0762747721
* International Data Spaces: did:elsi:VATDE-325984196
* Alastria: did:elsi:VATES-G87936159
* IN2: did:elsi:VATES-B60645900
* Digitel TS: did:elsi:VATES-B47447560
* FIWARE Foundation: did:elsi:VATDE-309937516
* TNO: did:elsi:LEIXG-724500AZSGBRY55MNS59

Where:
* “did” is the W3C did uri scheme.
* “elsi” stands for ETSI Legal Semantic Identifier, which is the acronym for the name for this type of identifier used in the ETSI documents.
* “organizationIdentifier” is the exact identifier specified in the ETSI standard, and that can evolve with the standard to support any future requirement.

Proving the control of an ELSI DID can be done using the associated digital certificate: including the certificate with any signature can do that. By the way, this means that any existing digital signature of any type of document (not only Verifiable Credentials) is already compliant with this DID method specification, just by making the corresponding translation
In other words: any legal person can have a standard eIDAS certificate with an automatically associated DID identifier complying with the ELSI did method specification. There is no need to invent new identifiers or have a central entity in a Data Space assign identifiers to participants.


### Cryptographic Keys and Signatures

Supported digital signature are JWS as defined in [RFC715](https://datatracker.ietf.org/doc/html/rfc7515). JSON Web Signature (JWS) represents content secured with digital signatures using JSON-based data structure (JWT).

ECDSA
* P-256 ES256 	Required
* P-384 ES384	Optional
* P-521 ES512     Optional
* secp256k1 ES256K        Optional

EdDSA
* Ed25519 OKP     Optional

RSA
* PKCS1-v1_5 RS256        Optional.

Implementations MUST support the P-256 curve with ES256 signature scheme as [RFC7518](https://www.rfc-editor.org/rfc/rfc7518).

### Delegation with DIDs

Delegation is a subject that comes up quite often that has several implementation solutions. Delegation using the DID document is one of them. On the other hand, it is without attenuation, which means that the party delegating cannot minimize the role of the party benefiting from the delegation.  

The implementation is simple: Alice wishes to delegate to Bob the use of one of her VCs to access a service :

* Alice adds a public key (verification method) given to her by Bob to her DID Document
* Alice gives to Bob the VC needed to access the service
* Bob presents a verifiable presentation in which he puts Alice's VC, with the "holder" attribute Alice's DID and signs with the key that was added to Alice's DID Document

Other implementations of delegation are possible through specific VCs.

## Verifiable Credentials

### General topics
VC Data Model v1.1 provides two options for how to encode properties defined in VC Data Model v1.1 as a JWT:  

* Use registered JWT claims instead of respective counterparts defined in a VC Data Model v1.1.
* Use JWT claims in addition to VC Data Model v1.1 counterparts

Registered JWT claims 'exp', 'iss', 'nbf', 'jti', 'sub' and 'aud' MUST be used in a JWT VC. If their counterpart in VC data model exist they will not be taken into account.

Verifiable Credentials included in a JWT-encoded Verifiable Presentation MUST be Base64url encoded.

Absolute DID URL are used as a kid, DID value in a kid without a DID fragment MUST exactly match a DID included in a 'iss' if it is a VC or a VP and 'sub' if it is an ID Token.

DID fragment in a 'kid' identifies which key material in a DID Document to use to validate the signature on a VC/VP/ID Token.

### Bearer credentials
Verifiable credentials that are bearer credentials are made possible by not specifying the subject identifier, expressed using the id property (and sub claim in the JWT format), which is nested in the credentialSubject property.

### Credential header

The header part has three mandatory fields:

* "typ" which is the type of the format (always "JWT")
* "alg" which is the signature scheme employed ('ES256K', 'RS256', 'secp256k1',... ). A list of defined "alg" values can be found in the [RFC7518](https://www.rfc-editor.org/rfc/rfc7518#page-6).
* "kid" which is the id of the public key. This parameter indicates which key was used to secure (digitally sign) the JWT. In Alastria, the value of the “kid” is the DID reference of the public key as it appears in the DID Document associated to the issuer of the Credential (or wallet holder for presentation). So it always should follow the pattern: did + "#" + key alias (DID absolute URL).  

Alastria compliance : only P-256 ES256K supported (To be verified???).  

### Credential Payload

cf https://www.rfc-editor.org/rfc/rfc7518#page-6 pour voir ce que l'on garde et la compliance EBSI


## Protocols

 ### To present verifiable credentials (and user authentication)  
   * SIOPv2


### To exchange verifiable credentials/presentations
   * OIDC4VP


### To issue credentials

The OIDC4VCI (OpenID for Verifiable Credential Issuance) protocol is the latest protocol that has been specified by the OpenID working group for SSI. It was modified many times in 2002 to now be stabilized. It brings many new features to the original openID specification. In particular, it offers new endpoints (credential offer, deferred, batch) and a new flow (pre eutheoriozed code flow) to the classic authorization code flow.

cf https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html  

In this flow the issuer plays the role of the Identity Provider and the holder(wallet) the client or RP.

#### Pre Authorized Code Flow vs Authorized Code Flow

Authorization code flow: this flow is used when the user is not already authenticated by the issuer. The first step of this flow is "front channel" which means it happens in the user's browser and is to authenticate the user. The issuer takes over to offer a means of authentication which can be traditional (login/password) or even through the wallet (see below the integration of a verifier in the authentication phase). When this authentication is carried out, a code transferred to the endpoint of the wallet redirect (possibly a deep link).

Pre Authorized Code Flow : The issuer can also skip the authentication and use pre-authorised flow in particular when the user was previously authenticated by a traditionnal means of authentication. This is intended for use cases where the issuer's website ultimately results in one or more credentials to be shared. 

Both flows will also use the same Initiate Issuance Request and endpoint but pre authorized code flow will add the mandatory pre-authorized_code and optional user_pin_required parameters into the request. User PIN code must be delivered through other channels (SMS, email, mobile notification, QR code,...) or request can be intercepted.  

#### Issuer becoming a verifier for user authentication

If the issuer wishes to obtain verifiable credentials from the user for his authentication, it is possible to integrate a presentation request issued by the issuer himself according to SIOPV2. The issuer then becomes a verifier. When authentication is over the issuer sends back the grant code to the hloder (wallet) as requested by the authorization code flow.

## Wallet
* key management -> import/export
Cf https://github.com/alastria/alastria-identity/wiki/Backup-and-recovery-standards qui semble avoir quelques bonnes idées.  
AUtre source DIF wg wallet security https://identity.foundation/working-groups/wallet-security.html  

* data(VC) management -> import/export
* No mobile wallet onboarding  
* user binding requirement -> authentication mode to be defined




## Verifiable data registries
* revocation VC  or issuer server ?
* trusted issuer/verifier registry (company details)
* accreditation  for registry updates -> gouvernance + paper




## Process  
* legal entity onboarding -> verification status ()
* user onboarding -> “ABF” VC ??
* conformance -> wallet, issuer, verifier


## APIs
* for registries
* vc attribute data on local ipfs node
* timestamping -> yes
* ledger  implementation on ethereum


## Implementations
* list of available libs
   * https://github.com/decentralized-identity
   * ?



## Privacy considerations
* minimization of schema/data model
* anonymization of VCs -> correlation, etc





## References :


Profile examples  :   
* https://identity.foundation/jwt-vc-presentation-profile/  
* https://api-pilot.ebsi.eu/docs  
* https://github.com/alastria/alastria-identity   

SSI eIDAS : https://joinup.ec.europa.eu/sites/default/files/document/2020-04/SSI_eIDAS_legal_report_final_0.pdf  
EU ARF : https://github.com/eu-digital-identity-wallet  
W3C DID core : https://www.w3.org/TR/did-core/  
W3C VC/VP : https://www.w3.org/TR/vc-data-model/  
Presentation Exchange  https://identity.foundation/presentation-exchange/   
Credential Manifest :  
DID registries  
RFC JOSE https://www.rfc-editor.org/rfc/rfc7515  
RFC algo https://www.rfc-editor.org/rfc/rfc7518   
RFC JWK  
Protocoles :    
* https://openid.net/specs/openid-connect-4-verifiable-presentations-1_0-07.html,  
* https://openid.net/specs/openid-connect-self-issued-v2-1_0.html,  
* https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html  
