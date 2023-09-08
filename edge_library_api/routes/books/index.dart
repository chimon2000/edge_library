import 'package:dart_frog/dart_frog.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:edge_library_data/edge_library_data.dart';

Future<Response> onRequest(RequestContext context) async {
  final repository = context.read<BookRepository>();
  final search = context.request.uri.queryParameters['search'];

  final books = await repository.getBooks(search);

  return Response(
    body: GetBooksResponse(books.toList()).toJson(),
  );
}
