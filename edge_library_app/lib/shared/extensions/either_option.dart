import 'package:option_result/option_result.dart';

extension EnhancedResult<T, E extends Object> on Result<T, E> {
  T getOrThrow() => switch (this) {
        Ok(:final v) => v,
        Err(value: E err) => throw err,
      };
}
