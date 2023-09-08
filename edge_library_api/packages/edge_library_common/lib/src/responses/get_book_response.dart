import 'package:dart_mappable/dart_mappable.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:edge_library_common/src/responses/base_response.dart';

part 'get_book_response.mapper.dart';

@MappableClass()
class GetBookResponse extends BaseResponse<Book> with GetBookResponseMappable {
  const GetBookResponse(super.data);
}
