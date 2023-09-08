import 'package:edge_library_app/entities/book/model/book.dart';
import 'package:edge_library_app/entities/book/widgets/book_list_view.dart';
import 'package:edge_library_app/entities/patron/model/patron.dart';
import 'package:edge_library_app/entities/patron/widgets/patron_floating_action_button.dart';
import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:edge_library_app/routing/router.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BooksListScreen extends ConsumerWidget {
  const BooksListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksListAsync = ref.watch(booksListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edge's Library"),
        actions: [
          TextButton(
            child: const Text('Sign Out'),
            onPressed: () async {
              await ref.read(identityFacadeProvider).signOut();
              ref.invalidate(currentUserProvider);
              if (context.mounted) context.go('/');
            },
          )
        ],
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
  const BooksListDataView(this.data, {super.key});

  final List<Book> data;

  @override
  Widget build(BuildContext context) {
    return BookListView(
      books: data,
    );
  }
}
