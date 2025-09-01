import 'dart:io';

import 'package:args/args.dart';
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
  final parser = ArgParser();
  parser.addCommand('generate')
    ..addOption('key', abbr: 'k', help: 'Obfuscate a secret key')
    ..addOption('function', abbr: 'f', help: 'Function name to generate');
  parser.addCommand('encrypt')
    ..addOption('file', abbr: 'f', help: 'File to encrypt')
    ..addOption('password', abbr: 'p', help: 'Encryption password');
  parser.addCommand('decrypt')
    ..addOption('file', abbr: 'f', help: 'File to decrypt')
    ..addOption('password', abbr: 'p', help: 'Decryption password');

  final results = parser.parse(args);
  if (results.command == null) {
    print('Usage: secretkey <generate|encrypt|decrypt> ...');
    exit(0);
  }

  switch (results.command!.name) {
    case "generate":
      final key = results.command!['key'];
      final function = results.command!['function'];

      if (key == null || function == null) {
        print("Usage: secret generate <PLAINTEXT_KEY|FILE_PATH> <functionName>");
        exit(1);
      }

      Obfuscator.generate(key, function);
      break;

    case "encrypt":
      final pathFile = results.command!['file'];
      final password = results.command!['password'];
      if (pathFile == null || password == null) {
        print("Usage: secret encrypt <file-path> <password>");
        exit(1);
      }
      await EncryptDecrypt.encryptFile(pathFile, password);
      break;

    case "decrypt":
      final pathFile = results.command!['file'];
      final password = results.command!['password'];
      if (pathFile == null || password == null) {
        print("Usage: secret encrypt <file-path> <password>");
        exit(1);
      }
      await EncryptDecrypt.decryptFile(pathFile, password);
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