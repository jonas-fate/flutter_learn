import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pointycastle/asymmetric/api.dart';

class EncryptUtil {
  static RSAKeyParser parser = RSAKeyParser();

  // // 通过公钥加密
// Future<String> encodeString(String content) async {
//   final publicKeyStr =
//       await rootBundle.loadString('assets/rsa_data/rsa_public_key.pem');
//   final publicKey = RSAKeyParser().parse(publicKeyStr) as RSAPublicKey;
//   final encrypter = Encrypter(RSA(publicKey: publicKey));
//   return encrypter.encrypt(content).base64.toUpperCase();
// }

// // 通过私钥解密
// Future<String> decodeString(String content) async {
//   final privateKeyStr =
//       await rootBundle.loadString('assets/rsa_data/rsa_private_key.pem');
//   final privateKey = RSAKeyParser().parse(privateKeyStr) as RSAPrivateKey;
//   final encrypter = Encrypter(RSA(privateKey: privateKey));
//   return encrypter.decrypt(Encrypted.fromBase64(content));
// }

  // 当字符串长度超过117，这时候会报溢出，也就是说字符串长度超过117就需要做分段加密和分段解密。
  // 分段加密
  static Future<String> encodeString(String content) async {
    String publicKeyStr =
        await rootBundle.loadString('assets/rsa_data/rsa_public_key.pem');
    final publicKey = parser.parse(publicKeyStr) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey));

    List<int> sourceBytes = utf8.encode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 117;
    List<int> totalBytes = [];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      List<int> item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(encrypter.encryptBytes(item).bytes);
    }
    return base64.encode(totalBytes);
    //return await encrypter.encrypt(content).base64.toUpperCase();
  }

  //分段解密
  static Future<String> decodeString(String content) async {
    String privateKeyStr =
        await rootBundle.loadString('assets/rsa_data/rsa_private_key.pem');
    final privateKey = parser.parse(privateKeyStr) as RSAPrivateKey;
    final encrypter = Encrypter(RSA(privateKey: privateKey));

    Uint8List sourceBytes = base64.decode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 128;
    List<int> totalBytes = [];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      Uint8List item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      print("object----------------");
      totalBytes.addAll(encrypter.decryptBytes(Encrypted(item)));
      print("object----------------");
    }

    String result = utf8.decode(totalBytes);
    return result;
//        return await encrypter.decrypt(Encrypted.fromBase64(content));
  }
}
