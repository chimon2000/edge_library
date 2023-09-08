// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'get_books_response.dart';

class GetBooksResponseMapper extends ClassMapperBase<GetBooksResponse> {
  GetBooksResponseMapper._();

  static GetBooksResponseMapper? _instance;
  static GetBooksResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetBooksResponseMapper._());
      BookMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'GetBooksResponse';

  static List<Book> _$data(GetBooksResponse v) => v.data;
  static const Field<GetBooksResponse, List<Book>> _f$data =
      Field('data', _$data);

  @override
  final Map<Symbol, Field<GetBooksResponse, dynamic>> fields = const {
    #data: _f$data,
  };

  static GetBooksResponse _instantiate(DecodingData data) {
    return GetBooksResponse(data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static GetBooksResponse fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<GetBooksResponse>(map));
  }

  static GetBooksResponse fromJson(String json) {
    return _guard((c) => c.fromJson<GetBooksResponse>(json));
  }
}

mixin GetBooksResponseMappable {
  String toJson() {
    return GetBooksResponseMapper._guard(
        (c) => c.toJson(this as GetBooksResponse));
  }

  Map<String, dynamic> toMap() {
    return GetBooksResponseMapper._guard(
        (c) => c.toMap(this as GetBooksResponse));
  }

  GetBooksResponseCopyWith<GetBooksResponse, GetBooksResponse, GetBooksResponse>
      get copyWith => _GetBooksResponseCopyWithImpl(
          this as GetBooksResponse, $identity, $identity);
  @override
  String toString() {
    return GetBooksResponseMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            GetBooksResponseMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return GetBooksResponseMapper._guard((c) => c.hash(this));
  }
}

extension GetBooksResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetBooksResponse, $Out> {
  GetBooksResponseCopyWith<$R, GetBooksResponse, $Out>
      get $asGetBooksResponse =>
          $base.as((v, t, t2) => _GetBooksResponseCopyWithImpl(v, t, t2));
}

abstract class GetBooksResponseCopyWith<$R, $In extends GetBooksResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Book, BookCopyWith<$R, Book, Book>> get data;
  $R call({List<Book>? data});
  GetBooksResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GetBooksResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetBooksResponse, $Out>
    implements GetBooksResponseCopyWith<$R, GetBooksResponse, $Out> {
  _GetBooksResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetBooksResponse> $mapper =
      GetBooksResponseMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Book, BookCopyWith<$R, Book, Book>> get data => ListCopyWith(
      $value.data, (v, t) => v.copyWith.$chain(t), (v) => call(data: v));
  @override
  $R call({List<Book>? data}) =>
      $apply(FieldCopyWithData({if (data != null) #data: data}));
  @override
  GetBooksResponse $make(CopyWithData data) =>
      GetBooksResponse(data.get(#data, or: $value.data));

  @override
  GetBooksResponseCopyWith<$R2, GetBooksResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GetBooksResponseCopyWithImpl($value, $cast, t);
}
