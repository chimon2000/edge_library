import 'package:edge_library_app/shared/logger/logger.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/foundation.dart';
import 'package:option_result/option_result.dart';
import 'package:passage_flutter/passage_flutter.dart';
import 'package:passage_flutter/passage_flutter_models/passage_app_info.dart';
import 'package:passage_flutter/passage_flutter_models/passage_error.dart';
import 'package:passage_flutter/passage_flutter_models/passage_error_code.dart';
import 'package:passage_flutter/passage_flutter_models/passage_user.dart';

import 'package:riverpod/riverpod.dart';

final identityFacadeProvider = Provider<IdentityFacade>((ref) {
  return IdentityFacade(PassageFlutter());
});

class IdentityFacade with LoggerMixin {
  IdentityFacade(this.passage);

  PassageFlutter passage;

  Future<Result<PassageUser?, Exception>> checkForAuthenticatedUser() async {
    try {
      final user = await passage.getCurrentUser();

      if (user == null) {
        passage.signOut();
      }

      return Ok(user);
    } catch (e, stackTrace) {
      logger.info('issue checking for authenticated user', e, stackTrace);

      return Err(Exception());
    }
  }

  Future<Result<String?, AuthException>> getAuthToken() async {
    try {
      return Ok(await passage.getAuthToken());
    } catch (e) {
      return Err(_mapError(e));
    }
  }

  Future<Result<PassageUser, AuthException>> register(String identifier) async {
    try {
      await passage.register(identifier);
      final user = await passage.getCurrentUser();

      if (user == null) throw Exception();

      return Ok(user);
    } on PassageError catch (error) {
      logger.warning('issue logging in', error);

      return switch (error.code) {
        'identifier_not_verified' => const Err(PassageOtpRequiredException()),
        PassageErrorCode.passkeyError when identifier.isNotEmpty =>
          const Err(PassageOtpRequiredException()),
        _ => Err(_mapError(error)),
      };
    } catch (error) {
      logger.warning('issue logging in', error);

      return Err(_mapError(error));
    }
  }

  Future<Result<PassageUser, AuthException>> login(String identifier) async {
    try {
      if (kIsWeb) {
        await passage.loginWithIdentifier(identifier);
      } else {
        await passage.login();
      }
      final user = await passage.getCurrentUser();

      if (user == null) throw Exception();

      return Ok(user);
    } on PassageError catch (error) {
      logger.warning('issue logging in', error);

      return switch (error.code) {
        'identifier_not_verified' => const Err(PassageOtpRequiredException()),
        PassageErrorCode.passkeyError when identifier.isNotEmpty =>
          const Err(PassageOtpRequiredException()),
        _ => Err(_mapError(error)),
      };
    } catch (error) {
      logger.warning('issue logging in', error);

      return Err(_mapError(error));
    }
  }

  Future<Result<PassageUser, AuthException>> activateOTP(
    String otp,
    authFallbackId,
  ) async {
    try {
      await passage.oneTimePasscodeActivate(otp, authFallbackId!);
      final user = await passage.getCurrentUser();

      if (user == null) throw Exception();

      return addPasskey();
    } catch (error) {
      logger.severe('issue activating OTP', error);
      return Err(_mapError(error));
    }
  }

  Future<Result<String, AuthException>> resendOTP({
    required String userIdentifer,
    required bool isRegistering,
  }) async {
    try {
      final newOtpId = isRegistering
          ? await passage.newRegisterOneTimePasscode(userIdentifer)
          : await passage.newLoginOneTimePasscode(userIdentifer);

      return Ok(newOtpId);
    } catch (error) {
      logger.severe('issue resending OTP', error);
      return Err(_mapError(error));
    }
  }

  Future<Result<PassageUser, AuthException>> addPasskey() async {
    try {
      await passage.addPasskey();

      final user = await passage.getCurrentUser();

      if (user == null) throw Exception();

      return Ok(user);
    } catch (error) {
      logger.severe('issue adding passkey', error);
      return Err(_mapError(error));
    }
  }

  Future<Result<None, AuthException>> signOut() async {
    try {
      await passage.signOut();
      return const Ok(None());
    } catch (e) {
      return Err(_mapError(e));
    }
  }

  Future<Result<String, dynamic>> fallbackRegister(String identifier) async {
    try {
      final appInfo = await passage.getAppInfo();

      if (appInfo?.authFallbackMethod == PassageAuthFallbackMethod.otp) {
        final otpId = await passage.newRegisterOneTimePasscode(identifier);
        return Ok(otpId);
      }

      return const Ok('');
    } catch (error) {
      logger.severe('issue signing out', error);
      return Err(_mapError(error));
    }
  }

  Future<Result<String, dynamic>> fallbackLogin(String identifier) async {
    try {
      final appInfo = await passage.getAppInfo();
      if (appInfo?.authFallbackMethod == PassageAuthFallbackMethod.otp) {
        final otpId = await passage.newLoginOneTimePasscode(identifier);
        return Ok(otpId);
      }

      return const Ok('');
    } catch (error) {
      logger.severe('issue with fallback login', error);
      return Err(_mapError(error));
    }
  }

  AuthException _mapError(Object error) => switch (error) {
        PassageOtpRequiredException() => error,
        PassageAuthException() => error,
        PassageError() => PassageAuthException(error),
        _ => UnknownException(error),
      };
}

sealed class AuthException extends Equatable implements Exception {
  const AuthException();

  @override
  List<Object?> get props => [];
}

class PassageAuthException implements AuthException {
  PassageAuthException(this.original);

  final PassageError original;

  @override
  List<Object?> get props => [original];

  @override
  bool? get stringify => true;
}

class PassageOtpRequiredException implements AuthException {
  const PassageOtpRequiredException();
  @override
  List<Object?> get props => [];
  @override
  bool? get stringify => true;
}

class UnknownException implements AuthException {
  const UnknownException(this.original);

  final Object original;

  @override
  List<Object?> get props => [original];
  @override
  bool? get stringify => true;
}
