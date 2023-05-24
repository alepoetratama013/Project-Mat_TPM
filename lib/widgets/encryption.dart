import 'package:encrypt/encrypt.dart' as encrypt_packages;

class CustomEncryption {
  static final key = encrypt_packages.Key.fromLength(32);
  static final iv = encrypt_packages.IV.fromLength(16);
  static final encrypter =
      encrypt_packages.Encrypter(encrypt_packages.AES(key));

  static enrcyptAES(input) {
    final encrypted = encrypter.encrypt(input, iv: iv);

    return encrypted.base64;
  }

  static decryptAES(input) {
    final decrypted = encrypter.decrypt(input, iv: iv);

    return decrypted;
  }
}
