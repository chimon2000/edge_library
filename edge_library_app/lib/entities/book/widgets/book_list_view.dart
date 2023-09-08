import 'package:edge_library_app/entities/book/widgets/book_list_tile.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookListView extends StatelessWidget {
  const BookListView({
    super.key,
    this.books = const [],
  });

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final book = books[index];
        return BookListTile(
          book: book,
          onTap: () => context.go('/books/${book.id}'),
        );
      },
      itemCount: books.length,
    );
  }
}
