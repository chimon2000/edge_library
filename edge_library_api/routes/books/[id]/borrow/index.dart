import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:edge_library_data/edge_library_data.dart';
import 'package:option_result/option_result.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String idArg,
) async {
  return switch (context.request.method) {
    HttpMethod.put => _handlePut(context, idArg),
    HttpMethod.post => _handlePost(context, idArg),
    _ => Future.value(Response.json(statusCode: HttpStatus.notAcceptable)),
  };
}

Future<Response> _handlePut(
  RequestContext context,
  String idArg,
) async {
  final id = int.tryParse(idArg);

  if (id == null) return Response.json(statusCode: HttpStatus.badRequest);

  final user = context.read<User>();
  final bookRepository = context.read<BookRepository>();
  final patron = await context.read<PatronRepository>().getPatronById(user.id);

  if (patron == null) return Response.json(statusCode: HttpStatus.badRequest);

  await bookRepository.returnBook(id, patron.id);

  return Response.json();
}

Future<Response> _handlePost(
  RequestContext context,
  String idArg,
) async {
  final id = int.tryParse(idArg);

  if (id == null) return Response.json(statusCode: HttpStatus.badRequest);

  final user = context.read<User>();
  final bookRepository = context.read<BookRepository>();
  final patron = await context.read<PatronRepository>().getPatronById(user.id);

  if (patron == null) return Response.json(statusCode: HttpStatus.badRequest);

  final result = await bookRepository.borrowBook(id, patron.id);

  return switch (result) {
    Ok() => Response.json(),
    _ => Response.json(statusCode: HttpStatus.internalServerError),
  };
}
