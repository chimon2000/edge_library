import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:edge_library_app/shared/env/env.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:option_result/option_result.dart';

import 'package:riverpod/riverpod.dart';
import 'package:uno/uno.dart';

final patronFacadeProvider = Provider<PatronFacade>((ref) {
  final uno = Uno(baseURL: Env.baseUrl);

  uno.interceptors.request.use((request) async {
    final token = await ref.read(identityFacadeProvider).getAuthToken();

    request.headers['Authorization'] = 'Bearer $token';
    return request;
  });

  return PatronFacade(uno);
});

class PatronFacade {
  const PatronFacade(this.uno);

  final Uno uno;

  Future<Result<GetPatronResponse, Exception>> getPatron() async {
    Future<Result<GetPatronResponse, Exception>> result =
        catchResultAsync(() async {
      try {
        final result =
            await uno.get('/patron', responseType: ResponseType.plain);

        if (result.status == HttpStatus.notFound) return Err(Exception());

        return switch (result) {
          Response(:final status) when status != HttpStatus.ok =>
            Err(Exception()),
          _ => Ok(GetPatronResponseMapper.fromJson(json.decode(result.data))),
        };
      } on UnoError catch (e) {
        return Err(e);
      }
    });

    if (result case Err(:final value)) {
      print(value);
    }

    return result;
  }

  Future<Result<GetPatronResponse, Exception>> createPatron(
      String name, String email) async {
    Future<Result<GetPatronResponse, Exception>> result =
        catchResultAsync(() async {
      try {
        final result = await uno.post(
          '/patron',
          data: CreatePatronRequest(name, email).toJson(),
        );

        if (result.status == HttpStatus.notFound) return Err(Exception());

        return switch (result) {
          Response(:final status) when status != HttpStatus.ok =>
            Err(Exception()),
          _ => Ok(GetPatronResponseMapper.fromJson(result.data)),
        };
      } on UnoError catch (e) {
        return Err(e);
      }
    });

    if (result case Err(:final value)) {
      print(value);
    }

    return result;
  }
}
