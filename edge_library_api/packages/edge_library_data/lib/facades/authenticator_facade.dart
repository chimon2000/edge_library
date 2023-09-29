import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:option_result/option_result.dart';

class AuthenticatorFacade {
  const AuthenticatorFacade(this.publicAuthKey);

  final String publicAuthKey;

  Future<Option<User>> verifyToken(String token) async {
    try {
      final payload = JWT.verify(
        token,
        RSAPublicKey(String.fromCharCodes(base64Decode(publicAuthKey))),
      );

      return Some(User(
        id: payload.subject!,
      ));
    } catch (error, stackTrace) {
      print(stackTrace);
      print(error);

      return None();
    }
  }
}

class User {
  const User({
    required this.id,
  });

  final String id;
}
