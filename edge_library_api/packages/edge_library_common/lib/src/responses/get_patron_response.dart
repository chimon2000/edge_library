import 'package:dart_mappable/dart_mappable.dart';
import 'package:edge_library_common/src/models/patron.dart';
import 'package:edge_library_common/src/responses/base_response.dart';

part 'get_patron_response.mapper.dart';

@MappableClass()
class GetPatronResponse extends BaseResponse<Patron>
    with GetPatronResponseMappable {
  const GetPatronResponse(super.data);
}
