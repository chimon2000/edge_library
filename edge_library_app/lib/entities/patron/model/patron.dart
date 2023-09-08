import 'package:edge_library_app/shared/api/patron/patron_facade.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:option_result/option_result.dart';

import 'package:riverpod/riverpod.dart';

final patronProvider = FutureProvider<Patron?>((ref) async {
  return ref.watch(patronFacadeProvider).getPatron().then(
        (value) => switch (value) {
          Ok(:final value) => value.data,
          _ => null,
        },
      );
});
