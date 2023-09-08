import 'package:edge_library_common/edge_library_common.dart';
import 'package:flutter/material.dart';

class BookListTile extends StatelessWidget {
  const BookListTile({
    super.key,
    required this.book,
    this.onTap,
  });

  final Book book;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.author),
      onTap: onTap,
    );
  }
}
