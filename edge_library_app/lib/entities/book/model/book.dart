import 'package:edge_library_app/shared/api/book/book_facade.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:riverpod/riverpod.dart';

final booksListProvider = FutureProvider<List<Book>>((ref) async {
  return ref.watch(bookFacadeProvider).getBooks().then((value) => value.data);
});

final bookByIdProvider = FutureProvider.family<Book, String>((ref, id) async {
  return ref
      .watch(bookFacadeProvider)
      .getBookById(id)
      .then((value) => value.data);
});
