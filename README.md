# 🔐 Secret Key Script Generator X Secure Compressor

A simple CLI tool to **generate obfuscated secret key functions** and **encrypt/decrypt files** using [secure_compressor](https://pub.dev/packages/secure_compressor).  
Designed to prevent plain-text secrets from being exposed when the app is decompiled.

---

## ✨ Features
- `secret generate <input> <functionName>`  
  Generate an obfuscated Dart function from a string or file.
- `secret encrypt <path-file> <password>`  
  Encrypt a file into `_enc.txt`.
- `secret decrypt <path-file> <password>`  
  Decrypt an encrypted file back into `_dec.txt`.

---

## 🚀 Installation
### Activate globally
```bash
dart pub global activate secret
