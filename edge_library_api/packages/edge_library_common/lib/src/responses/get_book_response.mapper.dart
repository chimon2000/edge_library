// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'get_book_response.dart';

class GetBookResponseMapper extends ClassMapperBase<GetBookResponse> {
  GetBookResponseMapper._();

  static GetBookResponseMapper? _instance;
  static GetBookResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetBookResponseMapper._());
      BookMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'GetBookResponse';

  static Book _$data(GetBookResponse v) => v.data;
  static const Field<GetBookResponse, Book> _f$data = Field('data', _$data);

  @override
  final Map<Symbol, Field<GetBookResponse, dynamic>> fields = const {
    #data: _f$data,
  };

  static GetBookResponse _instantiate(DecodingData data) {
    return GetBookResponse(data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static GetBookResponse fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<GetBookResponse>(map));
  }

  static GetBookResponse fromJson(String json) {
    return _guard((c) => c.fromJson<GetBookResponse>(json));
  }
}

mixin GetBookResponseMappable {
  String toJson() {
    return GetBookResponseMapper._guard(
        (c) => c.toJson(this as GetBookResponse));
  }

  Map<String, dynamic> toMap() {
    return GetBookResponseMapper._guard(
        (c) => c.toMap(this as GetBookResponse));
  }

  GetBookResponseCopyWith<GetBookResponse, GetBookResponse, GetBookResponse>
      get copyWith => _GetBookResponseCopyWithImpl(
          this as GetBookResponse, $identity, $identity);
  @override
  String toString() {
    return GetBookResponseMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            GetBookResponseMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return GetBookResponseMapper._guard((c) => c.hash(this));
  }
}

extension GetBookResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetBookResponse, $Out> {
  GetBookResponseCopyWith<$R, GetBookResponse, $Out> get $asGetBookResponse =>
      $base.as((v, t, t2) => _GetBookResponseCopyWithImpl(v, t, t2));
}

abstract class GetBookResponseCopyWith<$R, $In extends GetBookResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BookCopyWith<$R, Book, Book> get data;
  $R call({Book? data});
  GetBookResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GetBookResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetBookResponse, $Out>
    implements GetBookResponseCopyWith<$R, GetBookResponse, $Out> {
  _GetBookResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetBookResponse> $mapper =
      GetBookResponseMapper.ensureInitialized();
  @override
  BookCopyWith<$R, Book, Book> get data =>
      ($value.data as Book).copyWith.$chain((v) => call(data: v));
  @override
  $R call({Book? data}) =>
      $apply(FieldCopyWithData({if (data != null) #data: data}));
  @override
  GetBookResponse $make(CopyWithData data) =>
      GetBookResponse(data.get(#data, or: $value.data));

  @override
  GetBookResponseCopyWith<$R2, GetBookResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GetBookResponseCopyWithImpl($value, $cast, t);
}
