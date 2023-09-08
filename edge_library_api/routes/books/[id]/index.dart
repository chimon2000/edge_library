import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:edge_library_data/edge_library_data.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String idArg,
) async {
  return switch (context.request.method) {
    HttpMethod.get => _handleGet(context, idArg),
    _ => Future.value(Response.json(statusCode: HttpStatus.notAcceptable)),
  };
}

Future<Response> _handleGet(
  RequestContext context,
  String idArg,
) async {
  final id = int.tryParse(idArg);

  if (id == null) return Response.json(statusCode: HttpStatus.badRequest);

  final repository = context.read<BookRepository>();
  final book = await repository.getBookById(id);

  if (book == null) return Response.json(statusCode: HttpStatus.notFound);

  return Response(
    body: GetBookResponse(book).toJson(),
  );
}
