// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'patron.dart';

class PatronMapper extends ClassMapperBase<Patron> {
  PatronMapper._();

  static PatronMapper? _instance;
  static PatronMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatronMapper._());
      BookMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Patron';

  static String _$id(Patron v) => v.id;
  static const Field<Patron, String> _f$id = Field('id', _$id);
  static String? _$name(Patron v) => v.name;
  static const Field<Patron, String> _f$name = Field('name', _$name);
  static String? _$email(Patron v) => v.email;
  static const Field<Patron, String> _f$email = Field('email', _$email);
  static String? _$address(Patron v) => v.address;
  static const Field<Patron, String> _f$address = Field('address', _$address);
  static String? _$phoneNumber(Patron v) => v.phoneNumber;
  static const Field<Patron, String> _f$phoneNumber =
      Field('phoneNumber', _$phoneNumber, key: 'phone_number');
  static List<Book> _$borrowed(Patron v) => v.borrowed;
  static const Field<Patron, List<Book>> _f$borrowed =
      Field('borrowed', _$borrowed, key: 'books', opt: true, def: const []);

  @override
  final Map<Symbol, Field<Patron, dynamic>> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #address: _f$address,
    #phoneNumber: _f$phoneNumber,
    #borrowed: _f$borrowed,
  };

  static Patron _instantiate(DecodingData data) {
    return Patron(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        email: data.dec(_f$email),
        address: data.dec(_f$address),
        phoneNumber: data.dec(_f$phoneNumber),
        borrowed: data.dec(_f$borrowed));
  }

  @override
  final Function instantiate = _instantiate;

  static Patron fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Patron>(map));
  }

  static Patron fromJson(String json) {
    return _guard((c) => c.fromJson<Patron>(json));
  }
}

mixin PatronMappable {
  String toJson() {
    return PatronMapper._guard((c) => c.toJson(this as Patron));
  }

  Map<String, dynamic> toMap() {
    return PatronMapper._guard((c) => c.toMap(this as Patron));
  }

  PatronCopyWith<Patron, Patron, Patron> get copyWith =>
      _PatronCopyWithImpl(this as Patron, $identity, $identity);
  @override
  String toString() {
    return PatronMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PatronMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return PatronMapper._guard((c) => c.hash(this));
  }
}

extension PatronValueCopy<$R, $Out> on ObjectCopyWith<$R, Patron, $Out> {
  PatronCopyWith<$R, Patron, $Out> get $asPatron =>
      $base.as((v, t, t2) => _PatronCopyWithImpl(v, t, t2));
}

abstract class PatronCopyWith<$R, $In extends Patron, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Book, BookCopyWith<$R, Book, Book>> get borrowed;
  $R call(
      {String? id,
      String? name,
      String? email,
      String? address,
      String? phoneNumber,
      List<Book>? borrowed});
  PatronCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PatronCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Patron, $Out>
    implements PatronCopyWith<$R, Patron, $Out> {
  _PatronCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Patron> $mapper = PatronMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Book, BookCopyWith<$R, Book, Book>> get borrowed =>
      ListCopyWith($value.borrowed, (v, t) => v.copyWith.$chain(t),
          (v) => call(borrowed: v));
  @override
  $R call(
          {String? id,
          Object? name = $none,
          Object? email = $none,
          Object? address = $none,
          Object? phoneNumber = $none,
          List<Book>? borrowed}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != $none) #name: name,
        if (email != $none) #email: email,
        if (address != $none) #address: address,
        if (phoneNumber != $none) #phoneNumber: phoneNumber,
        if (borrowed != null) #borrowed: borrowed
      }));
  @override
  Patron $make(CopyWithData data) => Patron(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      email: data.get(#email, or: $value.email),
      address: data.get(#address, or: $value.address),
      phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
      borrowed: data.get(#borrowed, or: $value.borrowed));

  @override
  PatronCopyWith<$R2, Patron, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatronCopyWithImpl($value, $cast, t);
}
