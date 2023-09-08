import 'package:dart_mappable/dart_mappable.dart';
import 'package:edge_library_common/src/models/base_model.dart';

part 'book.mapper.dart';

@MappableClass()
class Book extends BaseModel with BookMappable {
  const Book({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.publicationDate,
    required this.genre,
    required this.copies,
  });

  final int id;
  final String title;
  final String description;
  final String author;
  @MappableField(key: 'publication_date')
  final DateTime publicationDate;
  final String genre;
  final int copies;
}
