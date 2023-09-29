// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'get_book_response.dart';

class GetBookResponseErrorMapper extends ClassMapperBase<GetBookResponseError> {
  GetBookResponseErrorMapper._();

  static GetBookResponseErrorMapper? _instance;
  static GetBookResponseErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetBookResponseErrorMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'GetBookResponseError';

  static String? _$code(GetBookResponseError v) => v.code;
  static const Field<GetBookResponseError, String> _f$code =
      Field('code', _$code, opt: true);
  static String? _$message(GetBookResponseError v) => v.message;
  static const Field<GetBookResponseError, String> _f$message =
      Field('message', _$message, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<GetBookResponseError, dynamic>> fields = const {
    #code: _f$code,
    #message: _f$message,
  };

  static GetBookResponseError _instantiate(DecodingData data) {
    return GetBookResponseError(code: data.dec(_f$code));
  }

  @override
  final Function instantiate = _instantiate;

  static GetBookResponseError fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<GetBookResponseError>(map));
  }

  static GetBookResponseError fromJson(String json) {
    return _guard((c) => c.fromJson<GetBookResponseError>(json));
  }
}

mixin GetBookResponseErrorMappable {
  String toJson() {
    return GetBookResponseErrorMapper._guard(
        (c) => c.toJson(this as GetBookResponseError));
  }

  Map<String, dynamic> toMap() {
    return GetBookResponseErrorMapper._guard(
        (c) => c.toMap(this as GetBookResponseError));
  }

  GetBookResponseErrorCopyWith<GetBookResponseError, GetBookResponseError,
          GetBookResponseError>
      get copyWith => _GetBookResponseErrorCopyWithImpl(
          this as GetBookResponseError, $identity, $identity);
  @override
  String toString() {
    return GetBookResponseErrorMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            GetBookResponseErrorMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return GetBookResponseErrorMapper._guard((c) => c.hash(this));
  }
}

extension GetBookResponseErrorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetBookResponseError, $Out> {
  GetBookResponseErrorCopyWith<$R, GetBookResponseError, $Out>
      get $asGetBookResponseError =>
          $base.as((v, t, t2) => _GetBookResponseErrorCopyWithImpl(v, t, t2));
}

abstract class GetBookResponseErrorCopyWith<
    $R,
    $In extends GetBookResponseError,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? code});
  GetBookResponseErrorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GetBookResponseErrorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetBookResponseError, $Out>
    implements GetBookResponseErrorCopyWith<$R, GetBookResponseError, $Out> {
  _GetBookResponseErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetBookResponseError> $mapper =
      GetBookResponseErrorMapper.ensureInitialized();
  @override
  $R call({Object? code = $none}) =>
      $apply(FieldCopyWithData({if (code != $none) #code: code}));
  @override
  GetBookResponseError $make(CopyWithData data) =>
      GetBookResponseError(code: data.get(#code, or: $value.code));

  @override
  GetBookResponseErrorCopyWith<$R2, GetBookResponseError, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GetBookResponseErrorCopyWithImpl($value, $cast, t);
}
