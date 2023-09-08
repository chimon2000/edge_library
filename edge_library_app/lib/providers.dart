import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:passage_flutter/passage_flutter_models/passage_user.dart';
import 'package:riverpod/riverpod.dart';

final currentUserProvider = FutureProvider<PassageUser?>((ref) async {
  return ref.watch(identityFacadeProvider).checkForAuthenticatedUser();
});

final currentUserAuthTokenProvider = FutureProvider<String?>((ref) async {
  return ref.watch(identityFacadeProvider).getAuthToken();
});
