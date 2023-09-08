import 'package:edge_library_common/edge_library_common.dart';
import 'package:supabase/supabase.dart';

class BookRepository {
  const BookRepository(this.client);

  final SupabaseClient client;

  Future<void> borrowBook(
    final int bookId,
    final String patronId,
  ) async {
    print('borrowing book');
    final book = await getBookById(bookId);

    if (book == null) throw Exception();

    final borrowedCopiesResponse = await client
        .from('borrowed_books')
        .select<PostgrestResponse>('*', FetchOptions(count: CountOption.exact))
        .eq('book_id', bookId)
        .filter('is_active', 'eq', true);

    final borrowedCopiesCount = borrowedCopiesResponse.count ?? 0;

    if (book.copies <= borrowedCopiesCount) throw Exception();

    await client.from('borrowed_books').upsert({
      'book_id': bookId,
      'patron_id': patronId,
      'borrow_date': DateTime.now().toIso8601String(),
      'return_date': null,
    });
  }

  Future<void> returnBook(
    final int bookId,
    final String patronId,
  ) async {
    print('returning book');

    await client
        .from('borrowed_books')
        .update({'return_date': DateTime.now().toIso8601String()})
        .eq('book_id', bookId)
        .eq('patron_id', patronId);
  }

  Future<List<Book>> getBooks(final String? search) async {
    final baseQuery = client.from('books').select<PostgrestList>();
    final books = search == null
        ? await baseQuery
            .order('title', ascending: true)
            .withConverter((data) => data.map(BookMapper.fromMap))
        : await baseQuery
            .textSearch('title', search)
            .withConverter((data) => data.map(BookMapper.fromMap));

    return books.toList();
  }

  Future<Book?> getBookById(int id) async {
    try {
      final book = await client
          .from('books')
          .select<PostgrestMap?>()
          .eq('id', id)
          .maybeSingle()
          .withConverter(
              (data) => data == null ? null : BookMapper.fromMap(data));

      return book;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
