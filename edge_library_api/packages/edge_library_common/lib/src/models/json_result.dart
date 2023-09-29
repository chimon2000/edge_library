import 'package:dart_mappable/dart_mappable.dart';
import 'package:option_result/option_result.dart';

part 'json_result.mapper.dart';

@MappableClass(discriminatorKey: 'type')
sealed class JsonResult<T, E> with JsonResultMappable<T, E> {
  const JsonResult();

  const factory JsonResult.ok(T data) = JsonOk;
  const factory JsonResult.err(E error) = JsonErr;
}

@MappableClass(discriminatorValue: 'ok')
class JsonOk<T, E> extends JsonResult<T, E> with JsonOkMappable<T, E> {
  const JsonOk(this.data);

  final T data;
}

@MappableClass(discriminatorValue: 'err')
class JsonErr<T, E> extends JsonResult<T, E> with JsonErrMappable<T, E> {
  const JsonErr(this.error);

  final E error;
}

extension EnhancedJsonResult<T, E> on JsonResult<T, E> {
  Result<T, E> toResult() {
    return switch (this) {
      JsonOk(:final data) => Ok(data),
      JsonErr(:final error) => Err(error),
    };
  }
}
