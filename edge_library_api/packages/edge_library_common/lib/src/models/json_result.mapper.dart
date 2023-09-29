// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'json_result.dart';

class JsonResultMapper extends ClassMapperBase<JsonResult> {
  JsonResultMapper._();

  static JsonResultMapper? _instance;
  static JsonResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JsonResultMapper._());
      JsonOkMapper.ensureInitialized();
      JsonErrMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'JsonResult';
  @override
  Function get typeFactory => <T, E>(f) => f<JsonResult<T, E>>();

  @override
  final Map<Symbol, Field<JsonResult, dynamic>> fields = const {};

  static JsonResult<T, E> _instantiate<T, E>(DecodingData data) {
    throw MapperException.missingSubclass(
        'JsonResult', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static JsonResult<T, E> fromMap<T, E>(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<JsonResult<T, E>>(map));
  }

  static JsonResult<T, E> fromJson<T, E>(String json) {
    return _guard((c) => c.fromJson<JsonResult<T, E>>(json));
  }
}

mixin JsonResultMappable<T, E> {
  String toJson();
  Map<String, dynamic> toMap();
  JsonResultCopyWith<JsonResult<T, E>, JsonResult<T, E>, JsonResult<T, E>, T, E>
      get copyWith;
}

abstract class JsonResultCopyWith<$R, $In extends JsonResult<T, E>, $Out, T, E>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  JsonResultCopyWith<$R2, $In, $Out2, T, E> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class JsonOkMapper extends SubClassMapperBase<JsonOk> {
  JsonOkMapper._();

  static JsonOkMapper? _instance;
  static JsonOkMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JsonOkMapper._());
      JsonResultMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'JsonOk';
  @override
  Function get typeFactory => <T, E>(f) => f<JsonOk<T, E>>();

  static dynamic _$data(JsonOk v) => v.data;
  static dynamic _arg$data<T, E>(f) => f<T>();
  static const Field<JsonOk, dynamic> _f$data =
      Field('data', _$data, arg: _arg$data);

  @override
  final Map<Symbol, Field<JsonOk, dynamic>> fields = const {
    #data: _f$data,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ok';
  @override
  late final ClassMapperBase superMapper = JsonResultMapper.ensureInitialized();

  static JsonOk<T, E> _instantiate<T, E>(DecodingData data) {
    return JsonOk(data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static JsonOk<T, E> fromMap<T, E>(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<JsonOk<T, E>>(map));
  }

  static JsonOk<T, E> fromJson<T, E>(String json) {
    return _guard((c) => c.fromJson<JsonOk<T, E>>(json));
  }
}

mixin JsonOkMappable<T, E> {
  String toJson() {
    return JsonOkMapper._guard((c) => c.toJson(this as JsonOk<T, E>));
  }

  Map<String, dynamic> toMap() {
    return JsonOkMapper._guard((c) => c.toMap(this as JsonOk<T, E>));
  }

  JsonOkCopyWith<JsonOk<T, E>, JsonOk<T, E>, JsonOk<T, E>, T, E> get copyWith =>
      _JsonOkCopyWithImpl(this as JsonOk<T, E>, $identity, $identity);
  @override
  String toString() {
    return JsonOkMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            JsonOkMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return JsonOkMapper._guard((c) => c.hash(this));
  }
}

extension JsonOkValueCopy<$R, $Out, T, E>
    on ObjectCopyWith<$R, JsonOk<T, E>, $Out> {
  JsonOkCopyWith<$R, JsonOk<T, E>, $Out, T, E> get $asJsonOk =>
      $base.as((v, t, t2) => _JsonOkCopyWithImpl(v, t, t2));
}

abstract class JsonOkCopyWith<$R, $In extends JsonOk<T, E>, $Out, T, E>
    implements JsonResultCopyWith<$R, $In, $Out, T, E> {
  @override
  $R call({T? data});
  JsonOkCopyWith<$R2, $In, $Out2, T, E> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _JsonOkCopyWithImpl<$R, $Out, T, E>
    extends ClassCopyWithBase<$R, JsonOk<T, E>, $Out>
    implements JsonOkCopyWith<$R, JsonOk<T, E>, $Out, T, E> {
  _JsonOkCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<JsonOk> $mapper = JsonOkMapper.ensureInitialized();
  @override
  $R call({T? data}) =>
      $apply(FieldCopyWithData({if (data != null) #data: data}));
  @override
  JsonOk<T, E> $make(CopyWithData data) =>
      JsonOk(data.get(#data, or: $value.data));

  @override
  JsonOkCopyWith<$R2, JsonOk<T, E>, $Out2, T, E> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _JsonOkCopyWithImpl($value, $cast, t);
}

class JsonErrMapper extends SubClassMapperBase<JsonErr> {
  JsonErrMapper._();

  static JsonErrMapper? _instance;
  static JsonErrMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JsonErrMapper._());
      JsonResultMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'JsonErr';
  @override
  Function get typeFactory => <T, E>(f) => f<JsonErr<T, E>>();

  static dynamic _$error(JsonErr v) => v.error;
  static dynamic _arg$error<T, E>(f) => f<E>();
  static const Field<JsonErr, dynamic> _f$error =
      Field('error', _$error, arg: _arg$error);

  @override
  final Map<Symbol, Field<JsonErr, dynamic>> fields = const {
    #error: _f$error,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'err';
  @override
  late final ClassMapperBase superMapper = JsonResultMapper.ensureInitialized();

  static JsonErr<T, E> _instantiate<T, E>(DecodingData data) {
    return JsonErr(data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static JsonErr<T, E> fromMap<T, E>(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<JsonErr<T, E>>(map));
  }

  static JsonErr<T, E> fromJson<T, E>(String json) {
    return _guard((c) => c.fromJson<JsonErr<T, E>>(json));
  }
}

mixin JsonErrMappable<T, E> {
  String toJson() {
    return JsonErrMapper._guard((c) => c.toJson(this as JsonErr<T, E>));
  }

  Map<String, dynamic> toMap() {
    return JsonErrMapper._guard((c) => c.toMap(this as JsonErr<T, E>));
  }

  JsonErrCopyWith<JsonErr<T, E>, JsonErr<T, E>, JsonErr<T, E>, T, E>
      get copyWith =>
          _JsonErrCopyWithImpl(this as JsonErr<T, E>, $identity, $identity);
  @override
  String toString() {
    return JsonErrMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            JsonErrMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return JsonErrMapper._guard((c) => c.hash(this));
  }
}

extension JsonErrValueCopy<$R, $Out, T, E>
    on ObjectCopyWith<$R, JsonErr<T, E>, $Out> {
  JsonErrCopyWith<$R, JsonErr<T, E>, $Out, T, E> get $asJsonErr =>
      $base.as((v, t, t2) => _JsonErrCopyWithImpl(v, t, t2));
}

abstract class JsonErrCopyWith<$R, $In extends JsonErr<T, E>, $Out, T, E>
    implements JsonResultCopyWith<$R, $In, $Out, T, E> {
  @override
  $R call({E? error});
  JsonErrCopyWith<$R2, $In, $Out2, T, E> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _JsonErrCopyWithImpl<$R, $Out, T, E>
    extends ClassCopyWithBase<$R, JsonErr<T, E>, $Out>
    implements JsonErrCopyWith<$R, JsonErr<T, E>, $Out, T, E> {
  _JsonErrCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<JsonErr> $mapper =
      JsonErrMapper.ensureInitialized();
  @override
  $R call({E? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  JsonErr<T, E> $make(CopyWithData data) =>
      JsonErr(data.get(#error, or: $value.error));

  @override
  JsonErrCopyWith<$R2, JsonErr<T, E>, $Out2, T, E> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _JsonErrCopyWithImpl($value, $cast, t);
}
