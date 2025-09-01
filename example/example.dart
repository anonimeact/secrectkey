import 'package:secret_key_scrypt_generator/encrypt_decrypt.dart';
import 'package:secret_key_scrypt_generator/obfuscator.dart';

void main() {
  const key = 'r9ES5DP6KZOFKPJ4VAE8AI0YT0O5FRZx'; // Example 32 char keys
  /// Obfuxcating a key / password
  Obfuscator.generate(key, 'example');

  /// Enctypr / decrypt
  EncryptDecrypt.encryptFile('example/helo_word.txt', key);
}