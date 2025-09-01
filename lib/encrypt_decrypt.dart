import 'dart:io';

import 'package:secure_compressor/secure_compressor.dart';

class EncryptDecrypt {
  /// Encrypt the file at args[1] using the password at args[2].
  /// The encrypted content is saved to a new file with _enc suffix.
  /// The original file remains unchanged.
  /// The encryption uses SecureCompressor from secure_compressor package.
  /// The output file is named <original_name>_enc.txt in the current directory.
  static Future<void> encryptFile(List<String> args) async {
    final path = args[1];
    final key = args[2];

    final file = File(path);
    if (!file.existsSync()) {
      print("❌ File not found: $path");
      return;
    }

    final data = await file.readAsString();
    final encrypted = SecureCompressor.encrypt(data, key);
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
  /// The output file is named <original_name>_dec.txt in the current directory.

  static Future<void> decryptFile(List<String> args) async {
    final path = args[1];
    final key = args[2];

    final file = File(path);
    if (!file.existsSync()) {
      print("❌ File not found: $path");
      return;
    }

    final encrypted = await file.readAsString();
    try {
      final decrypted = SecureCompressor.decrypt(encrypted, key);
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
