// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:edge_library_app/shared/logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:option_result/option_result.dart';
import 'package:passage_flutter/passage_flutter_models/passage_user.dart';

import 'package:riverpod/riverpod.dart';

import 'package:edge_library_app/shared/api/identity/identity_facade.dart';

final loginNotifierProvider =
    NotifierProvider.autoDispose<LoginNotifier, LoginState>(LoginNotifier.new);

class LoginNotifier extends AutoDisposeNotifier<LoginState> with LoggerMixin {
  @override
  build() {
    return const LoginState();
  }

  toggleIsNewUser() {
    state = state.copyWith(isNewUser: !state.isNewUser);
  }

  resetCode() {
    state = state.resetCode();
  }

  Future<Result<PassageUser, Exception>> login(String identifier) async {
    final result = await ref.read(identityFacadeProvider).login(identifier);

    final isOtpRequired = result.isErrAnd(
      (failure) => switch (failure) {
        PassageOtpRequiredException() => true,
        _ => false
      },
    );

    print('wtf');

    if (isOtpRequired) {
      final otpResult =
          await ref.read(identityFacadeProvider).fallbackLogin(identifier);

      state = state.copyWith(
        result: result
            .mapErr((p0) => otpResult.isErr() ? otpResult.unwrapErr() : p0),
        isOtpRequired: otpResult.isErr() ? false : isOtpRequired,
        fallbackIdentifier: switch (otpResult) {
          Ok(:final value) => value,
          _ => null,
        },
      );

      return result
          .mapErr((p0) => otpResult.isErr() ? otpResult.unwrapErr() : p0);
    }

    state = state.copyWith(
      result: result,
      isOtpRequired: isOtpRequired,
    );

    return result;
  }

  Future<Result<PassageUser, AuthException>> register(String identifier) async {
    final result = await ref.read(identityFacadeProvider).register(identifier);

    final isOtpRequired = result.isErrAnd(
      (failure) => switch (failure) {
        PassageOtpRequiredException() => true,
        _ => false
      },
    );

    if (isOtpRequired) {
      final otpResult =
          await ref.read(identityFacadeProvider).fallbackRegister(identifier);

      state = state.copyWith(
        result: result
            .mapErr((p0) => otpResult.isErr() ? otpResult.unwrapErr() : p0),
        isOtpRequired: otpResult.isErr() ? false : isOtpRequired,
        fallbackIdentifier: switch (otpResult) {
          Ok(:final value) => value,
          _ => null,
        },
      );

      return result
          .mapErr((p0) => otpResult.isErr() ? otpResult.unwrapErr() : p0);
    }

    return result;
  }

  Future<Result<PassageUser, Exception>> activateOtp(
      String otp, String identifier) async {
    final result = await ref
        .read(identityFacadeProvider)
        .activateOTP(otp, state.fallbackIdentifier);

    state = state.copyWith(result: result);

    return result;
  }
}

class LoginState extends Equatable {
  const LoginState({
    this.isNewUser = true,
    this.result,
    this.isOtpRequired = false,
    this.fallbackIdentifier,
  });

  final bool isNewUser;
  final bool isOtpRequired;
  final String? fallbackIdentifier;
  final Result<PassageUser, AuthException>? result;

  @override
  List<Object?> get props => [
        isNewUser,
        result,
        isOtpRequired,
        fallbackIdentifier,
      ];

  LoginState resetCode() {
    return LoginState(
      isNewUser: isNewUser,
      isOtpRequired: false,
    );
  }

  LoginState copyWith({
    bool? isNewUser,
    bool? isOtpRequired,
    String? fallbackIdentifier,
    Result<PassageUser, AuthException>? result,
  }) {
    return LoginState(
      isNewUser: isNewUser ?? this.isNewUser,
      isOtpRequired: isOtpRequired ?? this.isOtpRequired,
      result: result ?? this.result,
      fallbackIdentifier: fallbackIdentifier ?? this.fallbackIdentifier,
    );
  }
}
