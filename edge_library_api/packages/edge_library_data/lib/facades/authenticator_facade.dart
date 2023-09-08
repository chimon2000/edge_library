// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:result_dart/result_dart.dart';

import 'package:edge_library_common/edge_library_common.dart';

class AuthenticatorFacade {
  const AuthenticatorFacade(this.publicAuthKey);

  final String publicAuthKey;

  AsyncResult<User, Unit> verifyToken(String token) {
    return tryCatch(() async {
      final payload = JWT.verify(
        token,
        RSAPublicKey(String.fromCharCodes(base64Decode(publicAuthKey))),
      );

      return User(
        id: payload.subject!,
      );
    }, (error, stackTrace) {
      print(stackTrace);
      print(error);

      return unit;
    });
  }
}

class User {
  const User({
    required this.id,
  });

  final String id;
}
