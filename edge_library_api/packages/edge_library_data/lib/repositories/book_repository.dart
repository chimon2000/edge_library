import 'package:edge_library_common/edge_library_common.dart';
import 'package:option_result/option_result.dart';
import 'package:supabase/supabase.dart';

class BookRepository {
  const BookRepository(this.client);

  final SupabaseClient client;

  Future<Result<None, Exception>> borrowBook(
    final int bookId,
    final String patronId,
  ) async {
    try {
      print('borrowing book');
      final bookResult = await getBookById(bookId);

      final book = bookResult.unwrap();

      if (book == null) throw Exception();

      final borrowedCopiesResponse = await client
          .from('borrowed_books')
          .select<PostgrestResponse>(
              '*', FetchOptions(count: CountOption.exact))
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

      return Ok(None());
    } catch (e) {
      return Err(Exception());
    }
  }

  Future<Result<None, Exception>> returnBook(
    final int bookId,
    final String patronId,
  ) async {
    try {
      print('returning book');

      await client
          .from('borrowed_books')
          .update({'return_date': DateTime.now().toIso8601String()})
          .eq('book_id', bookId)
          .eq('patron_id', patronId);

      return Ok(None());
    } catch (e) {
      return Err(Exception());
    }
  }

  Future<Result<List<Book>, Exception>> getBooks(final String? search) async {
    try {
      final baseQuery = client.from('books').select<PostgrestList>();
      final books = search == null
          ? await baseQuery
              .order('title', ascending: true)
              .withConverter((data) => data.map(BookMapper.fromMap))
          : await baseQuery
              .textSearch('title', search)
              .withConverter((data) => data.map(BookMapper.fromMap));

      return Ok(books.toList());
    } catch (e) {
      return Err(Exception());
    }
  }

  Future<Result<Book?, Exception>> getBookById(int id) async {
    try {
      final book = await client
          .from('books')
          .select<PostgrestMap?>()
          .eq('id', id)
          .maybeSingle()
          .withConverter(
              (data) => data == null ? null : BookMapper.fromMap(data));

      return Ok(book);
    } catch (e) {
      print(e);
      return Err(Exception());
    }
  }
}
