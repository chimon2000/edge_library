// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'get_books_response.dart';

class GetBooksResponseErrorMapper
    extends ClassMapperBase<GetBooksResponseError> {
  GetBooksResponseErrorMapper._();

  static GetBooksResponseErrorMapper? _instance;
  static GetBooksResponseErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetBooksResponseErrorMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'GetBooksResponseError';

  static String? _$message(GetBooksResponseError v) => v.message;
  static const Field<GetBooksResponseError, String> _f$message =
      Field('message', _$message, mode: FieldMode.member);
  static String? _$code(GetBooksResponseError v) => v.code;
  static const Field<GetBooksResponseError, String> _f$code =
      Field('code', _$code, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<GetBooksResponseError, dynamic>> fields = const {
    #message: _f$message,
    #code: _f$code,
  };

  static GetBooksResponseError _instantiate(DecodingData data) {
    return GetBooksResponseError();
  }

  @override
  final Function instantiate = _instantiate;

  static GetBooksResponseError fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<GetBooksResponseError>(map));
  }

  static GetBooksResponseError fromJson(String json) {
    return _guard((c) => c.fromJson<GetBooksResponseError>(json));
  }
}

mixin GetBooksResponseErrorMappable {
  String toJson() {
    return GetBooksResponseErrorMapper._guard(
        (c) => c.toJson(this as GetBooksResponseError));
  }

  Map<String, dynamic> toMap() {
    return GetBooksResponseErrorMapper._guard(
        (c) => c.toMap(this as GetBooksResponseError));
  }

  GetBooksResponseErrorCopyWith<GetBooksResponseError, GetBooksResponseError,
          GetBooksResponseError>
      get copyWith => _GetBooksResponseErrorCopyWithImpl(
          this as GetBooksResponseError, $identity, $identity);
  @override
  String toString() {
    return GetBooksResponseErrorMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            GetBooksResponseErrorMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return GetBooksResponseErrorMapper._guard((c) => c.hash(this));
  }
}

extension GetBooksResponseErrorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetBooksResponseError, $Out> {
  GetBooksResponseErrorCopyWith<$R, GetBooksResponseError, $Out>
      get $asGetBooksResponseError =>
          $base.as((v, t, t2) => _GetBooksResponseErrorCopyWithImpl(v, t, t2));
}

abstract class GetBooksResponseErrorCopyWith<
    $R,
    $In extends GetBooksResponseError,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  GetBooksResponseErrorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GetBooksResponseErrorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetBooksResponseError, $Out>
    implements GetBooksResponseErrorCopyWith<$R, GetBooksResponseError, $Out> {
  _GetBooksResponseErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetBooksResponseError> $mapper =
      GetBooksResponseErrorMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  GetBooksResponseError $make(CopyWithData data) => GetBooksResponseError();

  @override
  GetBooksResponseErrorCopyWith<$R2, GetBooksResponseError, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GetBooksResponseErrorCopyWithImpl($value, $cast, t);
}
