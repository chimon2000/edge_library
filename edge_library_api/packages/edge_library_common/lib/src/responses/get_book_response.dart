import 'package:dart_mappable/dart_mappable.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:edge_library_common/src/models/internal_server_error.dart';

part 'get_book_response.mapper.dart';

typedef GetBookResponse = JsonResult<Book, GetBookResponseError>;

@MappableClass()
class GetBookResponseError extends InternalServerError
    with GetBookResponseErrorMappable {
  const GetBookResponseError({super.code});
}
