// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'get_patron_response.dart';

class GetPatronResponseMapper extends ClassMapperBase<GetPatronResponse> {
  GetPatronResponseMapper._();

  static GetPatronResponseMapper? _instance;
  static GetPatronResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetPatronResponseMapper._());
      PatronMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'GetPatronResponse';

  static Patron _$data(GetPatronResponse v) => v.data;
  static const Field<GetPatronResponse, Patron> _f$data = Field('data', _$data);

  @override
  final Map<Symbol, Field<GetPatronResponse, dynamic>> fields = const {
    #data: _f$data,
  };

  static GetPatronResponse _instantiate(DecodingData data) {
    return GetPatronResponse(data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static GetPatronResponse fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<GetPatronResponse>(map));
  }

  static GetPatronResponse fromJson(String json) {
    return _guard((c) => c.fromJson<GetPatronResponse>(json));
  }
}

mixin GetPatronResponseMappable {
  String toJson() {
    return GetPatronResponseMapper._guard(
        (c) => c.toJson(this as GetPatronResponse));
  }

  Map<String, dynamic> toMap() {
    return GetPatronResponseMapper._guard(
        (c) => c.toMap(this as GetPatronResponse));
  }

  GetPatronResponseCopyWith<GetPatronResponse, GetPatronResponse,
          GetPatronResponse>
      get copyWith => _GetPatronResponseCopyWithImpl(
          this as GetPatronResponse, $identity, $identity);
  @override
  String toString() {
    return GetPatronResponseMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            GetPatronResponseMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return GetPatronResponseMapper._guard((c) => c.hash(this));
  }
}

extension GetPatronResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetPatronResponse, $Out> {
  GetPatronResponseCopyWith<$R, GetPatronResponse, $Out>
      get $asGetPatronResponse =>
          $base.as((v, t, t2) => _GetPatronResponseCopyWithImpl(v, t, t2));
}

abstract class GetPatronResponseCopyWith<$R, $In extends GetPatronResponse,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  PatronCopyWith<$R, Patron, Patron> get data;
  $R call({Patron? data});
  GetPatronResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GetPatronResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetPatronResponse, $Out>
    implements GetPatronResponseCopyWith<$R, GetPatronResponse, $Out> {
  _GetPatronResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetPatronResponse> $mapper =
      GetPatronResponseMapper.ensureInitialized();
  @override
  PatronCopyWith<$R, Patron, Patron> get data =>
      ($value.data as Patron).copyWith.$chain((v) => call(data: v));
  @override
  $R call({Patron? data}) =>
      $apply(FieldCopyWithData({if (data != null) #data: data}));
  @override
  GetPatronResponse $make(CopyWithData data) =>
      GetPatronResponse(data.get(#data, or: $value.data));

  @override
  GetPatronResponseCopyWith<$R2, GetPatronResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GetPatronResponseCopyWithImpl($value, $cast, t);
}
