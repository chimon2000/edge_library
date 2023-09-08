import 'package:edge_library_app/entities/book/widgets/book_summary_view.dart';
import 'package:edge_library_app/pages/book_detail/book_detail_notifier.dart';
import 'package:edge_library_app/routing/router.dart';
import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailNotifierProvider(id));

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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: bookAsync.maybeWhen(
        data: (data) =>
            data.isBorrowed ? ReturnButton(id: id) : BorrowButton(id: id),
        orElse: () => null,
      ),
      body: bookAsync.when(
        skipLoadingOnReload: true,
        data: BookDetailDataView.new,
        error: BookDetailErrorView.new,
        loading: BookDetailLoadingView.new,
      ),
    );
  }
}

class BookDetailLoadingView extends StatelessWidget {
  @visibleForTesting
  const BookDetailLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BookDetailErrorView extends StatelessWidget {
  @visibleForTesting
  const BookDetailErrorView(this.error, this.stackTrace, {super.key});

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BookDetailDataView extends StatelessWidget {
  @visibleForTesting
  const BookDetailDataView(this.data, {super.key});

  final BookDetailState data;

  @override
  Widget build(BuildContext context) {
    return BookSummaryView(book: data.book);
  }
}

class BorrowButton extends ConsumerWidget {
  const BorrowButton({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () {
        ref.read(bookDetailNotifierProvider(id).notifier).borrowBook();
      },
      label: const Text('Borrow'),
    );
  }
}

class ReturnButton extends ConsumerWidget {
  const ReturnButton({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () {
        ref.read(bookDetailNotifierProvider(id).notifier).returnBook();
      },
      label: const Text('Return'),
    );
  }
}
