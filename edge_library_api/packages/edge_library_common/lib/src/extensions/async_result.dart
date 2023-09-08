import 'dart:async';

import 'package:result_dart/result_dart.dart';

AsyncResult<S, F> tryCatch<S extends Object, F extends Object>(
  FutureOr<S> Function() run,
  F Function(Object o, StackTrace s) onError,
) async {
  try {
    return Success(await run());
  } catch (e, s) {
    return Failure(onError.call(e, s));
  }
}
