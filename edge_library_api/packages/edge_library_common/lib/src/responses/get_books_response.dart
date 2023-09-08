import 'package:dart_mappable/dart_mappable.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:edge_library_common/src/responses/base_response.dart';

part 'get_books_response.mapper.dart';

@MappableClass()
class GetBooksResponse extends BaseListResponse<List<Book>>
    with GetBooksResponseMappable {
  const GetBooksResponse(super.data);
}
