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
  Generate an obfuscated Dart function from a string or file.
- `secret encrypt -s <path-file> -p <password>`  
  Encrypt a String with a specific password
- `secret decrypt -s <path-file> -p <password>`  
  Decrypt a String with a specific password
- `secret encryptFile -f <path-file> -p <password>`  
  Encrypt a file into `_enc.txt`.
- `secret decryptFile -f <path-file> -p <password>`  
  Decrypt an encrypted file back into `_dec.txt`.
---

# )* Note

> Password used length must be 32 character

> You can use any AESMode to do encrypt decrypt the string (eg: CBC, CFB-64, CTR, ECB, OFB-64/GCTR, OFB-64, SIC, GCM)

> Use single quote if you using some character that detect by action in shell (eg: !). Use secretkey generate -s 'Hello!' -f ......
