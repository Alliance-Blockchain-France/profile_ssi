# ABF SSI profile v 0.0.2
Date 18/04/2023

Status : Draft

This document is not a specification, but a profile. It outlines existing specifications required for implementations to interoperate among each other. It also clarifies mandatory to implement features for the optionalities mentioned in the referenced specifications.



## Editors and contributors
* Thierry Thevenet (Talao)
* Christophe Gervais (Agdatahub)
* Christine Hennebert (Nanoelec)
* ?

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

 ### to present verifiable credentials (and user authentication)  
   * SIOPv2


### to exchange verifiable credentials/presentations
   * OIDC4VP


### to issue credentials
   * OIDC4VCI




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
