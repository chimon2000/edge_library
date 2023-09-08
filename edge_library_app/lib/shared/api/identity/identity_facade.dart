import 'package:edge_library_app/shared/logger/logger.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:flutter/foundation.dart';
import 'package:passage_flutter/passage_flutter.dart';
import 'package:passage_flutter/passage_flutter_models/passage_app_info.dart';
import 'package:passage_flutter/passage_flutter_models/passage_error.dart';
import 'package:passage_flutter/passage_flutter_models/passage_error_code.dart';
import 'package:passage_flutter/passage_flutter_models/passage_user.dart';

import 'package:result_dart/result_dart.dart';
import 'package:riverpod/riverpod.dart';

final identityFacadeProvider = Provider<IdentityFacade>((ref) {
  return IdentityFacade(PassageFlutter());
});

class IdentityFacade with LoggerMixin {
  IdentityFacade(this.passage);

  PassageFlutter passage;

  Future<PassageUser?> checkForAuthenticatedUser() async {
    final user = await passage.getCurrentUser();

    if (user == null) {
      passage.signOut();
    }

    return user;
  }

  Future<String?> getAuthToken() async {
    return await passage.getAuthToken();
  }

  AsyncResult<PassageUser, AuthException> register(String identifier) async {
    return tryCatch(() async {
      await passage.register(identifier);
      final user = await passage.getCurrentUser();

      if (user == null) throw Exception();

      return user;
    }, (error, stackTrace) {
      logger.warning('issue registering', error, stackTrace);
      if (error is PassageError &&
          error.code == PassageErrorCode.userCancelled) {
        // User cancelled passkey prompt, do nothing.
      } else if (identifier.isNotEmpty) {
        logger.info('initiating fallback register', error, stackTrace);

        return PassageOtpRequiredException();
      }

      return _mapError(error);
    });
  }

  AsyncResult<PassageUser, AuthException> login(String identifier) async {
    final result = tryCatch(() async {
      if (kIsWeb) {
        await passage.loginWithIdentifier(identifier);
      } else {
        await passage.login();
      }
      final user = await passage.getCurrentUser();

      if (user == null) throw Exception();

      return user;
    }, (error, stackTrace) {
      logger.warning('issue logging in', error, stackTrace);

      if (error is PassageError &&
          error.code == PassageErrorCode.userCancelled) {
        // User cancelled passkey prompt, do nothing.
      } else if (identifier.isNotEmpty) {
        logger.info('initiating fallback login', error, stackTrace);

        debugPrint(error.toString());

        return PassageOtpRequiredException();
      }

      return _mapError(error);
    });

    return result;
  }

  AsyncResult<PassageUser, AuthException> activateOTP(
      String otp, authFallbackId) async {
    return tryCatch(() async {
      await passage.oneTimePasscodeActivate(otp, authFallbackId!);
      final user = await passage.getCurrentUser();

      if (user == null) throw Exception();

      return user;
    }, (error, stackTrace) {
      logger.severe('issue activating OTP', error, stackTrace);
      return _mapError(error);
    });
  }

  AsyncResult<String, void> resendOTP({
    required String userIdentifer,
    required bool isRegistering,
  }) async {
    return tryCatch(() async {
      final newOtpId = isRegistering
          ? await passage.newRegisterOneTimePasscode(userIdentifer)
          : await passage.newLoginOneTimePasscode(userIdentifer);

      return newOtpId;
    }, (error, stackTrace) {
      logger.severe('issue resending OTP', error, stackTrace);
      return unit;
    });
  }

  AsyncResult<PassageUser, AuthException> addPasskey() async {
    return tryCatch(() async {
      await passage.addPasskey();

      final user = await passage.getCurrentUser();

      if (user == null) throw Exception();

      return user;
    }, (error, stackTrace) {
      logger.severe('issue adding passkey', error, stackTrace);
      return _mapError(error);
    });
  }

  Future<void> signOut() async {
    await passage.signOut();
  }

  AsyncResult<String, void> fallbackRegister(String identifier) async {
    return tryCatch(() async {
      final appInfo = await passage.getAppInfo();
      if (appInfo?.authFallbackMethod == PassageAuthFallbackMethod.otp) {
        final otpId = await passage.newRegisterOneTimePasscode(identifier);
        return otpId;
      }

      return '';
    }, (error, stackTrace) {
      logger.severe('issue signing out', error, stackTrace);

      return unit;
    });
  }

  AsyncResult<String, void> fallbackLogin(String identifier) async {
    return tryCatch(() async {
      final appInfo = await passage.getAppInfo();
      if (appInfo?.authFallbackMethod == PassageAuthFallbackMethod.otp) {
        final otpId = await passage.newLoginOneTimePasscode(identifier);
        return otpId;
      }

      return '';
    }, (error, stackTrace) {
      logger.severe('issue with fallback login', error, stackTrace);

      return unit;
    });
  }

  AuthException _mapError(Object error) => switch (error) {
        PassageAuthException() => error,
        PassageError() => PassageAuthException(error),
        _ => UnknownException(error),
      };
}

sealed class AuthException implements Exception {
  const AuthException();
}

class PassageAuthException implements AuthException {
  PassageAuthException(this.original);

  final PassageError original;
}

class PassageOtpRequiredException implements AuthException {
  PassageOtpRequiredException();
}

class UnknownException implements AuthException {
  UnknownException(this.original);

  final Object original;
}
