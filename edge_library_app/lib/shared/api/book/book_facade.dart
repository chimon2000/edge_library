import 'dart:io';

import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:edge_library_app/shared/env/env.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:option_result/option_result.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uno/uno.dart';

final bookFacadeProvider = Provider<BookFacade>((ref) {
  final uno = Uno(baseURL: Env.baseUrl);

  uno.interceptors.request.use((request) async {
    final token = await ref.read(identityFacadeProvider).getAuthToken();

    request.headers['Authorization'] = 'Bearer ${token.unwrapOr(null)}';
    return request;
  });

  return BookFacade(uno);
});

class BookFacade {
  const BookFacade(this.uno);

  final Uno uno;

  Future<Result<List<Book>, GetBooksResponseError>> getBooks() async {
    try {
      final result = await uno.get('/books');

      final jsonResult =
          JsonResultMapper.fromMap<List<Book>, GetBooksResponseError>(
              result.data);

      return jsonResult.toResult();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return Err(GetBooksResponseError());
    }
  }

  Future<Result<Book, GetBookResponseError>> getBookById(String id) async {
    try {
      final result = await uno.get('/books/$id');

      if (result.status != HttpStatus.ok) {
        return const Err(GetBookResponseError());
      }

      final jsonResult =
          JsonResultMapper.fromMap<Book, GetBookResponseError>(result.data);
      return jsonResult.toResult();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);

      return const Err(GetBookResponseError());
    }
  }

  Future<Result<bool, Exception>> borrowBook(int id) async {
    try {
      final response = await uno.post('/books/$id/borrow');

      return Ok(response.status == HttpStatus.accepted);
    } catch (e) {
      return Err(Exception());
    }
  }

  Future<Result<bool, Exception>> returnBook(int id) async {
    try {
      final response = await uno.put('/books/$id/borrow');

      return Ok(response.status == HttpStatus.accepted);
    } catch (e) {
      return Err(Exception());
    }
  }
}
