import 'dart:async';

import 'package:edge_library_app/entities/patron/model/patron.dart';
import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:edge_library_app/routing/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passage_flutter/passage_flutter_models/passage_user.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final guard = ref.watch(authenticationGuardProvider);

  final router = GoRouter(
    routes: routes,
    redirect: guard.redirect,
    refreshListenable: guard,
  );

  return router;
});

class AuthenticationGuard extends ValueNotifier<AuthenticationState> {
  AuthenticationGuard() : super(AuthenticationState.unauthenticated);

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final container = ProviderScope.containerOf(context);

    final currentAuthState = await container.read(
      currentUserProvider.selectAsync((data) => data != null
          ? AuthenticationState.authenticated
          : AuthenticationState.unauthenticated),
    );
    final patron = await container.read(patronProvider.future);

    final redirect = switch (currentAuthState) {
      AuthenticationState.unauthenticated
          when !currentAuthState.ignore.contains(state.matchedLocation) =>
        '/welcome',
      AuthenticationState.authenticated when patron == null =>
        '/welcome/onboarding',
      AuthenticationState.authenticated
          when currentAuthState.redirects.contains(state.matchedLocation) =>
        state.uri.queryParameters['redirect'] ?? '/books',
      AuthenticationState.authenticated =>
        state.uri.queryParameters['redirect'],
      _ => null,
    };

    return redirect;
  }
}

final currentUserProvider = FutureProvider<PassageUser?>((ref) async {
  return ref.watch(identityFacadeProvider).checkForAuthenticatedUser();
});

final authenticationGuardProvider =
    ChangeNotifierProvider<AuthenticationGuard>((ref) {
  final guard = AuthenticationGuard();

  return guard;
});

enum AuthenticationState {
  unauthenticated(ignore: [
    '/welcome',
    '/welcome/login',
    '/welcome/onboarding',
    '/landing'
  ]),
  authenticated(redirects: [
    '/welcome',
    '/welcome/login',
    '/welcome/onboarding',
    '/landing'
  ]);

  const AuthenticationState({
    this.ignore = const [],
    this.redirects = const [],
  });

  final List<String> ignore;
  final List<String> redirects;
}
