// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:option_result/option_result.dart';
import 'package:riverpod/riverpod.dart';

import 'package:edge_library_app/routing/router.dart';
import 'package:edge_library_app/shared/api/patron/patron_facade.dart';
import 'package:edge_library_common/edge_library_common.dart';

final onboardingNotifierProvider =
    NotifierProvider.autoDispose<OnboardingNotifier, OnboardingState>(
        OnboardingNotifier.new);

class OnboardingNotifier extends AutoDisposeNotifier<OnboardingState> {
  @override
  OnboardingState build() {
    return const OnboardingState();
  }

  Future<Result<Patron, Exception>> createPatron(String name) async {
    final currentUser = await ref.read(currentUserProvider.future);
    final result = await ref
        .read(patronFacadeProvider)
        .createPatron(name, currentUser!.email!);

    state = state.copyWith(result: result.map((val) => val.data));

    return result.map((val) => val.data);
  }
}

class OnboardingState extends Equatable {
  const OnboardingState({this.result});

  final Result<Patron, Exception>? result;

  OnboardingState copyWith({
    Result<Patron, Exception>? result,
  }) {
    return OnboardingState(
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [result];
}
