import 'package:dart_mappable/dart_mappable.dart';

part 'create_patron_request.mapper.dart';

@MappableClass()
class CreatePatronRequest with CreatePatronRequestMappable {
  const CreatePatronRequest(
    this.name,
    this.email,
  );

  final String name;
  final String email;
}
