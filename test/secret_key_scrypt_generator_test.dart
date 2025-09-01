import 'package:secure_compressor/secure_compressor.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
void main() {
  group('SecureCompressor', () {
    const password = "duDluYlEkzk68D3fFcL80iG6FF9n1cvW"; // 32 chars

    test('should encrypt and decrypt correctly', () {
      const originWord = "Hello World!";

      final encrypted = SecureCompressor.encrypt(originWord, password);
      final decrypted = SecureCompressor.decrypt(encrypted, password);

      expect(decrypted, originWord);
    });

    // test('should produce different output when using wrong password', () {
    //   const originWord = "Hello World!";
    //   final encrypted = SecureCompressor.encrypt(originWord, password);

    //   // pakai password salah
    //   expect(
    //     () => SecureCompressor.decrypt(encrypted, "wrongpassword1234567890123456"),
    //     throwsA(isA<Exception>()), // sesuaikan dengan error yang dilempar
    //   );
    // });

    // test('should produce different ciphertext for same text with same password (if IV random)', () {
    //   const originWord = "Hello World!";

    //   final encrypted1 = SecureCompressor.encrypt(originWord, password);
    //   final encrypted2 = SecureCompressor.encrypt(originWord, password);

    //   expect(encrypted1, isNot(equals(encrypted2))); // kalau ada IV random
    // });
  });
}
