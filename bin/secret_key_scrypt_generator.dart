import 'dart:io';

import 'package:secret_key_scrypt_generator/encrypt_decrypt.dart';
import 'package:secret_key_scrypt_generator/obfuscator.dart';

/// A simple tool to generate obfuscated secret key functions and encrypt/decrypt files.
/// Usage:
///   secrect generate <PLAINTEXT_KEY|FILE_PATH> <functionName>
///   secrect encrypt <file-path> <password>
///   secrect decrypt <file-path> <password>
Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    printUsage();
    exit(1);
  }
  final command = args[0];

  switch (command) {
    case "generate":
      if (args.length < 3) {
        print("Usage: secret generate <PLAINTEXT_KEY|FILE_PATH> <functionName>");
        exit(1);
      }
      Obfuscator.generate(args);
      break;

    case "encrypt":
      if (args.length < 3) {
        print("Usage: secret encrypt <file-path> <password>");
        exit(1);
      }
      await EncryptDecrypt.encryptFile(args);
      break;

    case "decrypt":
      if (args.length < 3) {
        print("Usage: secret decrypt <file-path> <password>");
        exit(1);
      }
      await EncryptDecrypt.decryptFile(args);
      break;

    default:
      printUsage();
      exit(1);
  }
}

/// Log usage instructions.
void printUsage() {
  print("""
Usage:
  secret generate <PLAINTEXT_KEY|FILE_PATH> <functionName>
  secret encrypt <file-path> <password>
  secret decrypt <file-path> <password>
""");
}