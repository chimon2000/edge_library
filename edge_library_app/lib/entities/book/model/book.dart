import 'package:edge_library_app/shared/api/book/book_facade.dart';
import 'package:edge_library_app/shared/extensions/either_option.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:riverpod/riverpod.dart';

final booksListProvider = FutureProvider<List<Book>>((ref) async {
  return ref
      .watch(bookFacadeProvider)
      .getBooks()
      .then((value) => value.getOrThrow());
});

final bookByIdProvider = FutureProvider.family<Book, String>((ref, id) async {
  final result = await ref.watch(bookFacadeProvider).getBookById(id);

  return result.getOrThrow();
});
