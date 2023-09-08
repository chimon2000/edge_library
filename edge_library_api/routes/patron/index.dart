import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:edge_library_data/edge_library_data.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _handlePost(context),
    HttpMethod.get => _handleGet(context),
    _ => Future.value(Response.json(statusCode: HttpStatus.notAcceptable)),
  };
}

Future<Response> _handleGet(RequestContext context) async {
  final user = context.read<User>();
  final repository = context.read<PatronRepository>();

  final result = await repository.getPatronById(user.id);

  if (result == null) return Response.json(statusCode: HttpStatus.notFound);

  return Response.json(
    body: GetPatronResponse(result).toJson(),
  );
}

Future<Response> _handlePost(RequestContext context) async {
  final user = context.read<User>();
  final repository = context.read<PatronRepository>();

  final input =
      CreatePatronRequestMapper.fromJson(await context.request.body());

  final result = await repository.createPatron(
    id: user.id,
    name: input.name,
    email: input.email,
  );

  if (result == null) return Response.json(statusCode: HttpStatus.badRequest);

  return Response.json(
    body: GetPatronResponse(result).toJson(),
  );
}
