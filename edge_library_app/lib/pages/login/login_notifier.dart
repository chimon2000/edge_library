// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:passage_flutter/passage_flutter_models/passage_user.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod/riverpod.dart';

import 'package:edge_library_app/shared/api/identity/identity_facade.dart';

final loginNotifierProvider =
    NotifierProvider.autoDispose<LoginNotifier, LoginState>(LoginNotifier.new);

class LoginNotifier extends AutoDisposeNotifier<LoginState> {
  @override
  build() {
    return const LoginState();
  }

  toggleIsNewUser() {
    state = state.copyWith(isNewUser: !state.isNewUser);
  }

  AsyncResult<PassageUser, AuthException> login(String identifier) async {
    final result = await ref.read(identityFacadeProvider).login(identifier);

    final isOtpRequired = result.fold(
      (success) => false,
      (failure) => switch (failure) {
        PassageOtpRequiredException() => true,
        _ => false
      },
    );

    if (isOtpRequired) {
      final otpResult =
          await ref.read(identityFacadeProvider).fallbackLogin(identifier);

      state = state.copyWith(
        result: result,
        isOtpRequired: isOtpRequired,
        fallbackIdentifier: otpResult.getOrNull(),
      );

      return result;
    }

    state = state.copyWith(
      result: result,
      isOtpRequired: isOtpRequired,
    );

    return result;
  }

  AsyncResult<PassageUser, AuthException> register(String identifier) async {
    final result = await ref.read(identityFacadeProvider).register(identifier);

    final isOtpRequired = result.fold(
      (success) => false,
      (failure) => switch (failure) {
        PassageOtpRequiredException() => true,
        _ => false
      },
    );

    if (isOtpRequired) {
      final otpResult =
          await ref.read(identityFacadeProvider).fallbackRegister(identifier);

      state = state.copyWith(
        result: result,
        isOtpRequired: isOtpRequired,
        fallbackIdentifier: otpResult.getOrNull(),
      );

      return result;
    }

    return result;
  }

  AsyncResult<PassageUser, AuthException> activateOtp(
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
  List<Object?> get props =>
      [isNewUser, result, isOtpRequired, fallbackIdentifier];

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
