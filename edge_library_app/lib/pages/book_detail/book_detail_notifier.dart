// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';

import 'package:edge_library_app/entities/book/model/book.dart';
import 'package:edge_library_app/entities/patron/model/patron.dart';
import 'package:edge_library_app/shared/api/book/book_facade.dart';
import 'package:edge_library_common/edge_library_common.dart';

final bookDetailNotifierProvider =
    AsyncNotifierProviderFamily<BookDetailNotifier, BookDetailState, String>(
        BookDetailNotifier.new);

class BookDetailNotifier extends FamilyAsyncNotifier<BookDetailState, String> {
  @override
  FutureOr<BookDetailState> build(arg) async {
    final book = await ref.watch(bookByIdProvider(arg).future);
    final patron = await ref.watch(patronProvider.future);
    final isBorrowed =
        patron?.borrowed.any((borrowedBook) => borrowedBook.id == book.id);

    return BookDetailState(
      book: book,
      isBorrowed: isBorrowed ?? false,
    );
  }

  Future<void> borrowBook() async {
    final state = await future;
    await ref.read(bookFacadeProvider).borrowBook(state.book.id);

    ref.invalidate(patronProvider);
  }

  Future<void> returnBook() async {
    final state = await future;
    await ref.read(bookFacadeProvider).returnBook(state.book.id);
    ref.invalidate(patronProvider);
  }
}

class BookDetailState extends Equatable {
  const BookDetailState({
    required this.book,
    this.isBorrowed = false,
  });

  final Book book;
  final bool isBorrowed;

  @override
  List<Object?> get props => [book, isBorrowed];

  BookDetailState copyWith({
    Book? book,
    bool? isBorrowed,
  }) {
    return BookDetailState(
      book: book ?? this.book,
      isBorrowed: isBorrowed ?? this.isBorrowed,
    );
  }
}
