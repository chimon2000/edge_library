import 'package:edge_library_app/app/app_bar.dart';
import 'package:edge_library_app/entities/book/model/book.dart';
import 'package:edge_library_app/entities/book/widgets/book_list_view.dart';
import 'package:edge_library_app/entities/patron/widgets/patron_floating_action_button.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksListScreen extends ConsumerWidget {
  const BooksListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksListAsync = ref.watch(booksListProvider);

    return Scaffold(
      appBar: const LibraryAppBar(
        title: Text("Edge's Library"),
      ),
      floatingActionButton: const PatronFloatingActionButton(),
      body: booksListAsync.when(
        data: BooksListDataView.new,
        error: BooksListErrorView.new,
        loading: BooksListLoadingView.new,
      ),
    );
  }
}

class BooksListLoadingView extends StatelessWidget {
  @visibleForTesting
  const BooksListLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BooksListErrorView extends StatelessWidget {
  @visibleForTesting
  const BooksListErrorView(this.error, this.stackTrace, {super.key});

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class BooksListDataView extends StatelessWidget {
  @visibleForTesting
  const BooksListDataView(this.data, {super.key});

  final List<Book> data;

  @override
  Widget build(BuildContext context) {
    return BookListView(books: data);
  }
}
