import 'package:dart_mappable/dart_mappable.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:edge_library_common/src/models/base_model.dart';

part 'patron.mapper.dart';

@MappableClass()
class Patron extends BaseModel with PatronMappable {
  const Patron({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    this.borrowed = const [],
  });

  final String id;
  @MappableField(key: 'name')
  final String? name;

  final String? email;
  final String? address;
  @MappableField(key: 'phone_number')
  final String? phoneNumber;

  @MappableField(key: 'books')
  final List<Book> borrowed;
}
