import 'package:dart_mappable/dart_mappable.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:edge_library_common/src/models/internal_server_error.dart';

part 'get_books_response.mapper.dart';

typedef GetBooksResponse = JsonResult<List<Book>, GetBooksResponseError>;

@MappableClass()
class GetBooksResponseError extends InternalServerError
    with GetBooksResponseErrorMappable {}
