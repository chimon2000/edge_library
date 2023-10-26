import 'package:edge_library_app/app/app_bar.dart';
import 'package:edge_library_app/entities/book/widgets/book_summary_view.dart';
import 'package:edge_library_app/pages/book_detail/book_detail_notifier.dart';
import 'package:edge_library_app/widgets/error_retry_view.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: const LibraryAppBar(
        title: Text("Edge's Library"),
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
        error: (error, stackTrace) => BookDetailErrorView(
          error,
          stackTrace,
          id: id,
        ),
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

class BookDetailErrorView extends ConsumerWidget {
  @visibleForTesting
  const BookDetailErrorView(
    this.error,
    this.stackTrace, {
    super.key,
    required this.id,
  });

  final Object error;
  final StackTrace stackTrace;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: switch (error) {
        GetBookResponseError(:final code) when code == 'NOT_FOUND' =>
          const Text('This book does not exist'),
        _ => ErrorRetryView(
            message:
                'There was an error with your request, please try again later.',
            onRetry: () => ref.refresh(bookDetailNotifierProvider(id)),
          ),
      },
    );
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
