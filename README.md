# 🔐 Secret Key Script Generator x Secure Compressor

A simple CLI tool to **generate obfuscated secret key functions** and **encrypt/decrypt files** (https://pub.dev/packages/secure_compressor)
Designed to prevent plain-text secrets from being exposed when the app is decompiled. So if you encrypt a string here, you can use decrypt function in secure_compressor to decrypt the strin.

## 🚀 Installation
### Activate globally
```bash
dart pub global activate secret_key_scrypt_generator
```
---

## ✨ Features
- `secret generate -s <string/key/secrect/plaintext> -f <functionName>`  
  Generate an obfuscated Dart function from a string or file. This action will generate a SecrectKey class with unix functionName functions.
- `secret encrypt -s <path-file> -p <password> -m <AESmode>`  
  Encrypt a String with a specific password
- `secret decrypt -s <path-file> -p <password> -m <AESmode>`  
  Decrypt a String with a specific password
- `secret encryptFile -f <path-file> -p <password> -m <AESmode>`  
  Encrypt a file into `_enc.txt`.
- `secret decryptFile -f <path-file> -p <password> -m <AESmode>`  
  Decrypt an encrypted file back into `_dec.txt`.
---

# )* Note

> Password used length must be 32 character

> You can use any AESMode to perform string/file encryption and decryption. (eg: CBC, CFB-64, CTR, ECB, OFB-64/GCTR, OFB-64, SIC, GCM)

> AESmode is Optional. The default AES mode is sic, and input is case sensitive in commands (eg: -m SIC, -m 'SIC', -m 'OFB-64/GCTR')

> Use single quote if you using some character that detect by action in shell (eg: !). Use secretkey generate -s 'Hello!' -f ......
