import 'package:edge_library_common/edge_library_common.dart';
import 'package:supabase/supabase.dart';

class PatronRepository {
  const PatronRepository(this.client);

  final SupabaseClient client;

  Future<Patron?> getPatronById(String id) async {
    try {
      final patron = await client
          .from('patrons')
          .select<PostgrestMap?>()
          .eq('external_id', id)
          .maybeSingle()
          .withConverter((data) {
        return data == null ? null : PatronMapper.fromMap(data);
      });
      final borrowedBooks = await client
          .from('books')
          .select<PostgrestList>('*, borrowed_books!inner(*)')
          .eq('borrowed_books.patron_id', patron?.id)
          .filter('borrowed_books.is_active', 'eq', true)
          .withConverter((data) => data.map(BookMapper.fromMap));

      return patron?.copyWith(borrowed: borrowedBooks.toList());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Patron?> createPatron({
    required String id,
    required String name,
    required String email,
  }) async {
    try {
      return await client
          .from('patrons')
          .insert({
            'name': name,
            'external_id': id,
            'email': email,
          })
          .select<PostgrestMap?>()
          .maybeSingle()
          .withConverter(
              (data) => data == null ? null : PatronMapper.fromMap(data));
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
