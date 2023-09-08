// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'create_patron_request.dart';

class CreatePatronRequestMapper extends ClassMapperBase<CreatePatronRequest> {
  CreatePatronRequestMapper._();

  static CreatePatronRequestMapper? _instance;
  static CreatePatronRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CreatePatronRequestMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'CreatePatronRequest';

  static String _$name(CreatePatronRequest v) => v.name;
  static const Field<CreatePatronRequest, String> _f$name =
      Field('name', _$name);
  static String _$email(CreatePatronRequest v) => v.email;
  static const Field<CreatePatronRequest, String> _f$email =
      Field('email', _$email);

  @override
  final Map<Symbol, Field<CreatePatronRequest, dynamic>> fields = const {
    #name: _f$name,
    #email: _f$email,
  };

  static CreatePatronRequest _instantiate(DecodingData data) {
    return CreatePatronRequest(data.dec(_f$name), data.dec(_f$email));
  }

  @override
  final Function instantiate = _instantiate;

  static CreatePatronRequest fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<CreatePatronRequest>(map));
  }

  static CreatePatronRequest fromJson(String json) {
    return _guard((c) => c.fromJson<CreatePatronRequest>(json));
  }
}

mixin CreatePatronRequestMappable {
  String toJson() {
    return CreatePatronRequestMapper._guard(
        (c) => c.toJson(this as CreatePatronRequest));
  }

  Map<String, dynamic> toMap() {
    return CreatePatronRequestMapper._guard(
        (c) => c.toMap(this as CreatePatronRequest));
  }

  CreatePatronRequestCopyWith<CreatePatronRequest, CreatePatronRequest,
          CreatePatronRequest>
      get copyWith => _CreatePatronRequestCopyWithImpl(
          this as CreatePatronRequest, $identity, $identity);
  @override
  String toString() {
    return CreatePatronRequestMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            CreatePatronRequestMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return CreatePatronRequestMapper._guard((c) => c.hash(this));
  }
}

extension CreatePatronRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CreatePatronRequest, $Out> {
  CreatePatronRequestCopyWith<$R, CreatePatronRequest, $Out>
      get $asCreatePatronRequest =>
          $base.as((v, t, t2) => _CreatePatronRequestCopyWithImpl(v, t, t2));
}

abstract class CreatePatronRequestCopyWith<$R, $In extends CreatePatronRequest,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? email});
  CreatePatronRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CreatePatronRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CreatePatronRequest, $Out>
    implements CreatePatronRequestCopyWith<$R, CreatePatronRequest, $Out> {
  _CreatePatronRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CreatePatronRequest> $mapper =
      CreatePatronRequestMapper.ensureInitialized();
  @override
  $R call({String? name, String? email}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (email != null) #email: email}));
  @override
  CreatePatronRequest $make(CopyWithData data) => CreatePatronRequest(
      data.get(#name, or: $value.name), data.get(#email, or: $value.email));

  @override
  CreatePatronRequestCopyWith<$R2, CreatePatronRequest, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CreatePatronRequestCopyWithImpl($value, $cast, t);
}
