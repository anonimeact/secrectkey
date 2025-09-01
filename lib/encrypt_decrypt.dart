import 'dart:io';

import 'package:encrypt/encrypt.dart' as encriptor;

class EncryptDecrypt {
  /// Encrypts the given [data] using AES encryption with the provided [keyString].
  ///
  /// The [keyString] must be 32 characters long. The optional [ivString] must be 32 characters long.
  /// If [ivString] is not provided, a part of [keyString] will be used as the initialization vector (IV).
  ///
  /// Returns a Base64 encoded string of the encrypted data.
  ///
  /// Throws an [ArgumentError] if [keyString] is not 32 characters long.
  static String encrypt(
    String data,
    String keyString, {
    String? ivString,
    encriptor.AESMode mode = encriptor.AESMode.sic,
  }) {
    if (data.isEmpty) {
      return '';
    } else if (keyString.length < 32) {
      return 'keyString length must be 32 characters.';
    }
    final key = encriptor.Key.fromUtf8(keyString.substring(0, 32));
    final iv = encriptor.IV.fromUtf8(ivString ?? keyString.substring(0, 16));
    final encrypter = encriptor.Encrypter(encriptor.AES(key, mode: mode));
    final encryptedData = encrypter.encrypt(data, iv: iv);
    return encryptedData.base64;
  }

  /// Decrypts the given [data] using AES encryption with the provided [keyString].
  ///
  /// The [keyString] must be 32 characters long. The optional [ivString] must be 32 characters long.
  /// If [ivString] is not provided, a part of [keyString] will be used as the initialization vector (IV).
  ///
  /// Returns the decrypted data as a string.
  ///
  /// Throws an [ArgumentError] if [keyString] is not 32 characters long.
  static String decrypt(
    String data,
    String keyString, {
    String? ivString,
    encriptor.AESMode mode = encriptor.AESMode.sic,
  }) {
    if (data.isEmpty) {
      return '';
    } else if (keyString.length < 32) {
      return 'keyString long must be 32 characters.';
    }
    final key = encriptor.Key.fromUtf8(keyString.substring(0, 32));
    final iv = encriptor.IV.fromUtf8(ivString ?? keyString.substring(0, 16));
    final encrypter = encriptor.Encrypter(encriptor.AES(key, mode: mode));
    try {
      return encrypter.decrypt64(data, iv: iv);
    } catch (_) {
      return '::: Error decrypting data';
    }
  }

  /// Encrypt the file at args[1] using the password at args[2].
  /// The encrypted content is saved to a new file with _enc suffix.
  /// The original file remains unchanged.
  /// The encryption uses SecureCompressor from secure_compressor package.
  /// The output file is named ORIGINAL_NAME_enc.txt in the current directory.
  static Future<void> encryptFile(String path, String password) async {
    final file = File(path);
    if (!file.existsSync()) {
      print("❌ File not found: $path");
      return;
    }

    final data = await file.readAsString();
    final encrypted = encrypt(data, password);
    final filename = path.split(Platform.pathSeparator).last;
    final extIndex = filename.lastIndexOf(".");
    final base = extIndex == -1 ? filename : filename.substring(0, extIndex);

    final outFile = File("${Directory.current.path}${Platform.pathSeparator}${base}_enc.txt");
    await outFile.writeAsString(encrypted);

    print("✅ Encrypted -> ${outFile.path}");
  }

  /// Decrypt the file at args[1] using the password at args[2].
  /// The decrypted content is saved to a new file with _dec suffix.
  /// The original file remains unchanged.
  /// The decryption uses SecureCompressor from secure_compressor package.
  /// The output file is named ORIGINAL_NAME_dec.txt in the current directory.

  static Future<void> decryptFile(String path, String password) async {
    final file = File(path);
    if (!file.existsSync()) {
      print("❌ File not found: $path");
      return;
    }

    final encrypted = await file.readAsString();
    try {
      final decrypted = decrypt(encrypted, password);
      // Ambil nama file tanpa ekstensi
      final filename = path.split(Platform.pathSeparator).last;
      final base = filename.contains(".") ? filename.substring(0, filename.lastIndexOf(".")) : filename;

      final outFile = File("${Directory.current.path}${Platform.pathSeparator}${base}_dec.txt");
      await outFile.writeAsString(decrypted);

      print("✅ Decrypted -> ${outFile.path}");
    } catch (e) {
      print("❌ Wrong password or corrupted file.");
    }
  }
}
