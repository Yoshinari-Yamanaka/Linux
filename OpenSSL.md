# OpenSSL
　公開鍵や秘密鍵、公開鍵を含む証明書は .DER or .PEMでエンコードされている。
両者は必ずしも互換があるというわけではないが、変換することはできる。OpenSSLは.pemをでデフォルトフォーマットに指定している。
　contentsにある拡張子はその内容を指す。.keyは秘密鍵、公開鍵そのものを指す。
.crt、.cerは公開鍵を含む証明書を指す。.crtは証明書、.cerはMicrosoft式。中身は同じ。

|  encoding              |  contents       |
| ---------------------- | --------------- |
|  .der(ASN.1 = binary)  |  .crt           |
|  .pem(ASN.1 -> base64) |  .cer (= .crt)  |
|                        |  .key           |



## Show every sub commands for OpenSSL
openssl help

```
Standard commands
asn1parse         ca                ciphers           cms               
crl               crl2pkcs7         dgst              dhparam           
dsa               dsaparam          ec                ecparam           
enc               engine            errstr            gendsa            
genpkey           genrsa            help              list              
nseq              ocsp              passwd            pkcs12            
pkcs7             pkcs8             pkey              pkeyparam         
pkeyutl           prime             rand              rehash            
req               rsa               rsautl            s_client          
s_server          s_time            sess_id           smime             
speed             spkac             srp               storeutl          
ts                verify            version           x509              

Message Digest commands (see the `dgst' command for more details)
blake2b512        blake2s256        gost              md4               
md5               rmd160            sha1              sha224            
sha256            sha3-224          sha3-256          sha3-384          
sha3-512          sha384            sha512            sha512-224        
sha512-256        shake128          shake256          sm3               

Cipher commands (see the `enc' command for more details)
aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb       
aes-256-cbc       aes-256-ecb       aria-128-cbc      aria-128-cfb      
aria-128-cfb1     aria-128-cfb8     aria-128-ctr      aria-128-ecb      
aria-128-ofb      aria-192-cbc      aria-192-cfb      aria-192-cfb1     
aria-192-cfb8     aria-192-ctr      aria-192-ecb      aria-192-ofb      
aria-256-cbc      aria-256-cfb      aria-256-cfb1     aria-256-cfb8     
aria-256-ctr      aria-256-ecb      aria-256-ofb      base64            
bf                bf-cbc            bf-cfb            bf-ecb            
bf-ofb            camellia-128-cbc  camellia-128-ecb  camellia-192-cbc  
camellia-192-ecb  camellia-256-cbc  camellia-256-ecb  cast              
cast-cbc          cast5-cbc         cast5-cfb         cast5-ecb         
cast5-ofb         des               des-cbc           des-cfb           
des-ecb           des-ede           des-ede-cbc       des-ede-cfb       
des-ede-ofb       des-ede3          des-ede3-cbc      des-ede3-cfb      
des-ede3-ofb      des-ofb           des3              desx              
rc2               rc2-40-cbc        rc2-64-cbc        rc2-cbc           
rc2-cfb           rc2-ecb           rc2-ofb           rc4               
rc4-40            seed              seed-cbc          seed-cfb          
seed-ecb          seed-ofb          sm4-cbc           sm4-cfb           
sm4-ctr           sm4-ecb           sm4-ofb           
```

## Ciphers

openssl ciphers -v

| Sweet | Protocol | Kx | Au | Enc | Mac | 
| --- | --- | --- | --- | --- | --- | 
| TLS_AES_256_GCM_SHA384 | TLSv1.3 | any | any | AESGCM(256) | AEAD | 
| TLS_CHACHA20_POLY1305_SHA256 | TLSv1.3 | any | any | CHACHA20/POLY1305(256) | AEAD | 
| TLS_AES_128_GCM_SHA256 | TLSv1.3 | any | any | AESGCM(128) | AEAD | 
| ECDHE-ECDSA-AES256-GCM-SHA384 | TLSv1.2 | ECDH | ECDSA | AESGCM(256) | AEAD | 
| ECDHE-RSA-AES256-GCM-SHA384 | TLSv1.2 | ECDH | RSA | AESGCM(256) | AEAD | 
| DHE-RSA-AES256-GCM-SHA384 | TLSv1.2 | DH | RSA | AESGCM(256) | AEAD | 
| ECDHE-ECDSA-CHACHA20-POLY1305 | TLSv1.2 | ECDH | ECDSA | CHACHA20/POLY1305(256) | AEAD | 
| ECDHE-RSA-CHACHA20-POLY1305 | TLSv1.2 | ECDH | RSA | CHACHA20/POLY1305(256) | AEAD | 
| DHE-RSA-CHACHA20-POLY1305 | TLSv1.2 | DH | RSA | CHACHA20/POLY1305(256) | AEAD | 
| ECDHE-ECDSA-AES128-GCM-SHA256 | TLSv1.2 | ECDH | ECDSA | AESGCM(128) | AEAD | 
| ECDHE-RSA-AES128-GCM-SHA256 | TLSv1.2 | ECDH | RSA | AESGCM(128) | AEAD | 
| DHE-RSA-AES128-GCM-SHA256 | TLSv1.2 | DH | RSA | AESGCM(128) | AEAD | 
| ECDHE-ECDSA-AES256-SHA384 | TLSv1.2 | ECDH | ECDSA | AES(256) | SHA384 | 
| ECDHE-RSA-AES256-SHA384 | TLSv1.2 | ECDH | RSA | AES(256) | SHA384 | 
| DHE-RSA-AES256-SHA256 | TLSv1.2 | DH | RSA | AES(256) | SHA256 | 
| ECDHE-ECDSA-AES128-SHA256 | TLSv1.2 | ECDH | ECDSA | AES(128) | SHA256 | 
| ECDHE-RSA-AES128-SHA256 | TLSv1.2 | ECDH | RSA | AES(128) | SHA256 | 
| DHE-RSA-AES128-SHA256 | TLSv1.2 | DH | RSA | AES(128) | SHA256 | 
| ECDHE-ECDSA-AES256-SHA | TLSv1 | ECDH | ECDSA | AES(256) | SHA1 | 
| ECDHE-RSA-AES256-SHA | TLSv1 | ECDH | RSA | AES(256) | SHA1 | 
| DHE-RSA-AES256-SHA | SSLv3 | DH | RSA | AES(256) | SHA1 | 
| ECDHE-ECDSA-AES128-SHA | TLSv1 | ECDH | ECDSA | AES(128) | SHA1 | 
| ECDHE-RSA-AES128-SHA | TLSv1 | ECDH | RSA | AES(128) | SHA1 | 
| DHE-RSA-AES128-SHA | SSLv3 | DH | RSA | AES(128) | SHA1 | 
| RSA-PSK-AES256-GCM-SHA384 | TLSv1.2 | RSAPSK | RSA | AESGCM(256) | AEAD | 
| DHE-PSK-AES256-GCM-SHA384 | TLSv1.2 | DHEPSK | PSK | AESGCM(256) | AEAD | 
| RSA-PSK-CHACHA20-POLY1305 | TLSv1.2 | RSAPSK | RSA | CHACHA20/POLY1305(256) | AEAD | 
| DHE-PSK-CHACHA20-POLY1305 | TLSv1.2 | DHEPSK | PSK | CHACHA20/POLY1305(256) | AEAD | 
| ECDHE-PSK-CHACHA20-POLY1305 | TLSv1.2 | ECDHEPSK | PSK | CHACHA20/POLY1305(256) | AEAD | 
| AES256-GCM-SHA384 | TLSv1.2 | RSA | RSA | AESGCM(256) | AEAD | 
| PSK-AES256-GCM-SHA384 | TLSv1.2 | PSK | PSK | AESGCM(256) | AEAD | 
| PSK-CHACHA20-POLY1305 | TLSv1.2 | PSK | PSK | CHACHA20/POLY1305(256) | AEAD | 
| RSA-PSK-AES128-GCM-SHA256 | TLSv1.2 | RSAPSK | RSA | AESGCM(128) | AEAD | 
| DHE-PSK-AES128-GCM-SHA256 | TLSv1.2 | DHEPSK | PSK | AESGCM(128) | AEAD | 
| AES128-GCM-SHA256 | TLSv1.2 | RSA | RSA | AESGCM(128) | AEAD | 
| PSK-AES128-GCM-SHA256 | TLSv1.2 | PSK | PSK | AESGCM(128) | AEAD | 
| AES256-SHA256 | TLSv1.2 | RSA | RSA | AES(256) | SHA256 | 
| AES128-SHA256 | TLSv1.2 | RSA | RSA | AES(128) | SHA256 | 
| ECDHE-PSK-AES256-CBC-SHA384 | TLSv1 | ECDHEPSK | PSK | AES(256) | SHA384 | 
| ECDHE-PSK-AES256-CBC-SHA | TLSv1 | ECDHEPSK | PSK | AES(256) | SHA1 | 
| SRP-RSA-AES-256-CBC-SHA | SSLv3 | SRP | RSA | AES(256) | SHA1 | 
| SRP-AES-256-CBC-SHA | SSLv3 | SRP | SRP | AES(256) | SHA1 | 
| RSA-PSK-AES256-CBC-SHA384 | TLSv1 | RSAPSK | RSA | AES(256) | SHA384 | 
| DHE-PSK-AES256-CBC-SHA384 | TLSv1 | DHEPSK | PSK | AES(256) | SHA384 | 
| RSA-PSK-AES256-CBC-SHA | SSLv3 | RSAPSK | RSA | AES(256) | SHA1 | 
| DHE-PSK-AES256-CBC-SHA | SSLv3 | DHEPSK | PSK | AES(256) | SHA1 | 
| AES256-SHA | SSLv3 | RSA | RSA | AES(256) | SHA1 | 
| PSK-AES256-CBC-SHA384 | TLSv1 | PSK | PSK | AES(256) | SHA384 | 
| PSK-AES256-CBC-SHA | SSLv3 | PSK | PSK | AES(256) | SHA1 | 
| ECDHE-PSK-AES128-CBC-SHA256 | TLSv1 | ECDHEPSK | PSK | AES(128) | SHA256 | 
| ECDHE-PSK-AES128-CBC-SHA | TLSv1 | ECDHEPSK | PSK | AES(128) | SHA1 | 
| SRP-RSA-AES-128-CBC-SHA | SSLv3 | SRP | RSA | AES(128) | SHA1 | 
| SRP-AES-128-CBC-SHA | SSLv3 | SRP | SRP | AES(128) | SHA1 | 
| RSA-PSK-AES128-CBC-SHA256 | TLSv1 | RSAPSK | RSA | AES(128) | SHA256 | 
| DHE-PSK-AES128-CBC-SHA256 | TLSv1 | DHEPSK | PSK | AES(128) | SHA256 | 
| RSA-PSK-AES128-CBC-SHA | SSLv3 | RSAPSK | RSA | AES(128) | SHA1 | 
| DHE-PSK-AES128-CBC-SHA | SSLv3 | DHEPSK | PSK | AES(128) | SHA1 | 
| AES128-SHA | SSLv3 | RSA | RSA | AES(128) | SHA1 | 
| PSK-AES128-CBC-SHA256 | TLSv1 | PSK | PSK | AES(128) | SHA256 | 
| PSK-AES128-CBC-SHA | SSLv3 | PSK | PSK | AES(128) | SHA1 | 
