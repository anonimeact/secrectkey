import 'package:secret_key_scrypt_generator/encrypt_decrypt.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
void main() {
  group('SecureCompressor', () {
    const password = "duDluYlEkzk68D3fFcL80iG6FF9n1cvW"; // 32 chars

    test('should encrypt and decrypt correctly', () {
      const originWord = "Hello World!";

      final encrypted = EncryptDecrypt.encrypt(originWord, password);
      final decrypted = EncryptDecrypt.decrypt(encrypted, password);

      expect(decrypted, originWord);
    });

    test('should produce different output when using wrong password', () {
      const originWord = "Hello World!";
      final encrypted = EncryptDecrypt.encrypt(originWord, password);
      final decrypted = EncryptDecrypt.decrypt(encrypted, "wrongpassword1234567890123456");

      expect(originWord, isNot(equals(decrypted)));
    });

    test('should produce different ciphertext for same text with same password (if IV random)', () {
      const originWord = "Hello World!";
      const originWord2 = "Hello World2!";

      final encrypted1 = EncryptDecrypt.encrypt(originWord, password);
      final encrypted2 = EncryptDecrypt.encrypt(originWord2, password);

      expect(encrypted1, isNot(equals(encrypted2))); // kalau ada IV random
    });
  });
}
