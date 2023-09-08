import 'dart:io';

import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:edge_library_app/shared/env/env.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uno/uno.dart';

final bookFacadeProvider = Provider<BookFacade>((ref) {
  final uno = Uno(baseURL: Env.baseUrl);

  uno.interceptors.request.use((request) async {
    final token = await ref.read(identityFacadeProvider).getAuthToken();

    request.headers['Authorization'] = 'Bearer $token';
    return request;
  });

  return BookFacade(uno);
});

class BookFacade {
  const BookFacade(this.uno);

  final Uno uno;

  Future<GetBooksResponse> getBooks() async {
    final result = await uno.get('/books');

    return GetBooksResponseMapper.fromMap(result.data);
  }

  Future<GetBookResponse> getBookById(String id) async {
    final result = await uno.get('/books/$id');

    return GetBookResponseMapper.fromMap(result.data);
  }

  Future<bool> borrowBook(int id) async {
    final response = await uno.post('/books/$id/borrow');

    return response.status == HttpStatus.accepted;
  }

  Future<bool> returnBook(int id) async {
    final response = await uno.put('/books/$id/borrow');

    return response.status == HttpStatus.accepted;
  }
}
