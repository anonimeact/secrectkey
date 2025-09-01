# 🔐 Secret Key Script Generator

A simple CLI tool to **generate obfuscated secret key functions** and **encrypt/decrypt files** 
Designed to prevent plain-text secrets from being exposed when the app is decompiled.

---

## ✨ Features
- `secret generate -k <key/secrect/plaintext> -f <functionName>`  
  Generate an obfuscated Dart function from a string or file.
- `secret encrypt -f <path-file> -p <password>`  
  Encrypt a file into `_enc.txt`.
- `secret decrypt -f <path-file> -p <password>`  
  Decrypt an encrypted file back into `_dec.txt`.

---

## 🚀 Installation
### Activate globally
```bash
dart pub global activate secret_key_scrypt_generator
