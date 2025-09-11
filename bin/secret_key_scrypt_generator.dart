import 'dart:io';

import 'package:args/args.dart';
import 'package:secret_key_scrypt_generator/encrypt_decrypt.dart';
import 'package:secret_key_scrypt_generator/obfuscator.dart';

/// A simple tool to generate obfuscated secret key functions and encrypt/decrypt files.
/// Usage:
/*
   secrect generate <PLAINTEXT_KEY|FILE_PATH> <functionName>
   secrect encrypt <PLAITEXT> <password>
   secrect decrypt <ENCTYPTED_STRING> <password>
   secrect encryptFile <file-path> <password>
   secrect decryptFile <file-path> <password>
*/
Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show help information');

  parser.addCommand('generate')
    ..addOption('key', abbr: 's', help: 'Obfuscate a secret key')
    ..addOption('function', abbr: 'f', help: 'Function name to generate');
  parser.addCommand('encrypt')
    ..addOption('key', abbr: 's', help: 'String to encrypt')
    ..addOption('password', abbr: 'p', help: 'Encryption password')
    ..addOption('mode', abbr: 'm', help: 'AESMode option');
  parser.addCommand('decrypt')
    ..addOption('key', abbr: 's', help: 'Encrypted string to decrypt')
    ..addOption('password', abbr: 'p', help: 'Decryption password')
    ..addOption('mode', abbr: 'm', help: 'AESMode option');
  parser.addCommand('encryptFile')
    ..addOption('file', abbr: 'f', help: 'File to encrypt')
    ..addOption('password', abbr: 'p', help: 'Encryption password')
    ..addOption('mode', abbr: 'm', help: 'AESMode option');
  parser.addCommand('decryptFile')
    ..addOption('file', abbr: 'f', help: 'File to decrypt')
    ..addOption('password', abbr: 'p', help: 'Decryption password')
    ..addOption('mode', abbr: 'm', help: 'AESMode option');

  final results = parser.parse(args);

  /// Global help
  if (results['help'] == true || results.command == null) {
    printUsage(parser);
    exit(0);
  }

  switch (results.command!.name) {
    case "generate":
      final key = results.command!['key'];
      final function = results.command!['function'];

      if (key == null || function == null) {
        printSubcommandUsage(parser, 'generate');
        exit(1);
      }

      Obfuscator.generate(key, function);
      break;

    case "encrypt":
      final pathFile = results.command!['key'];
      final password = results.command!['password'];
      final aesMode = EncryptDecrypt.parseAESMode(results.command!['mode']);
      if (pathFile == null || password == null) {
        printSubcommandUsage(parser, 'encrypt');
        exit(1);
      }
      final encryptedString = EncryptDecrypt.encrypt(pathFile, password, mode: aesMode);
      print("✅ Encrypted String -> $encryptedString");
      break;

    case "decrypt":
      final pathFile = results.command!['key'];
      final password = results.command!['password'];
      final aesMode = EncryptDecrypt.parseAESMode(results.command!['mode']);
      if (pathFile == null || password == null) {
        printSubcommandUsage(parser, 'decrypt');
        exit(1);
      }
      final decryptedString = EncryptDecrypt.decrypt(pathFile, password, mode: aesMode);
      print("✅ Encrypted String -> $decryptedString");
      break;

    case "encryptFile":
      final pathFile = results.command!['file'];
      final password = results.command!['password'];
      final aesMode = EncryptDecrypt.parseAESMode(results.command!['mode']);
      if (pathFile == null || password == null) {
        printSubcommandUsage(parser, 'encryptFile');
        exit(1);
      }
      EncryptDecrypt.encryptFile(pathFile, password, mode: aesMode);
      break;

    case "decryptFile":
      final pathFile = results.command!['file'];
      final password = results.command!['password'];
      final aesMode = EncryptDecrypt.parseAESMode(results.command!['mode']);
      if (pathFile == null || password == null) {
        printSubcommandUsage(parser, 'decryptFile');
        exit(1);
      }
      EncryptDecrypt.decryptFile(pathFile, password, mode: aesMode);
      break;

    default:
      printUsage(parser);
      exit(1);
  }
}

/// Global usage istruction
void printUsage(ArgParser parser) {
  print('''
Usage: secret <command> [options]

Commands:
  generate     Generate obfuscated secret key clas and function
  encrypt      Encrypt a string
  decrypt      Decrypt a string
  encryptFile  Encrypt a file
  decryptFile  Decrypt a file

Common options:
  -s, --string     String input (plaintext/encrypted)
  -p, --password   Password for encryption/decryption
  -f, --file       File path to encrypt/decrypt
  -m, --aesmode    AES mode (${EncryptDecrypt.modes.values.join(", ")}) [default: SIC]

Global options:
${parser.usage}

Run "secret <command> -h" for more information about a command.
''');
}

/// Per-command usage
void printSubcommandUsage(ArgParser parser, String command) {
  print('''
Usage: secret $command [options]

Options:
${parser.commands[command]!.usage}
''');
}