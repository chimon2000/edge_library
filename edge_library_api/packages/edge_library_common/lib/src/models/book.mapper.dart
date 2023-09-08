// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'book.dart';

class BookMapper extends ClassMapperBase<Book> {
  BookMapper._();

  static BookMapper? _instance;
  static BookMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Book';

  static int _$id(Book v) => v.id;
  static const Field<Book, int> _f$id = Field('id', _$id);
  static String _$title(Book v) => v.title;
  static const Field<Book, String> _f$title = Field('title', _$title);
  static String _$description(Book v) => v.description;
  static const Field<Book, String> _f$description =
      Field('description', _$description);
  static String _$author(Book v) => v.author;
  static const Field<Book, String> _f$author = Field('author', _$author);
  static DateTime _$publicationDate(Book v) => v.publicationDate;
  static const Field<Book, DateTime> _f$publicationDate =
      Field('publicationDate', _$publicationDate, key: 'publication_date');
  static String _$genre(Book v) => v.genre;
  static const Field<Book, String> _f$genre = Field('genre', _$genre);
  static int _$copies(Book v) => v.copies;
  static const Field<Book, int> _f$copies = Field('copies', _$copies);

  @override
  final Map<Symbol, Field<Book, dynamic>> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #author: _f$author,
    #publicationDate: _f$publicationDate,
    #genre: _f$genre,
    #copies: _f$copies,
  };

  static Book _instantiate(DecodingData data) {
    return Book(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        author: data.dec(_f$author),
        publicationDate: data.dec(_f$publicationDate),
        genre: data.dec(_f$genre),
        copies: data.dec(_f$copies));
  }

  @override
  final Function instantiate = _instantiate;

  static Book fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Book>(map));
  }

  static Book fromJson(String json) {
    return _guard((c) => c.fromJson<Book>(json));
  }
}

mixin BookMappable {
  String toJson() {
    return BookMapper._guard((c) => c.toJson(this as Book));
  }

  Map<String, dynamic> toMap() {
    return BookMapper._guard((c) => c.toMap(this as Book));
  }

  BookCopyWith<Book, Book, Book> get copyWith =>
      _BookCopyWithImpl(this as Book, $identity, $identity);
  @override
  String toString() {
    return BookMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BookMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return BookMapper._guard((c) => c.hash(this));
  }
}

extension BookValueCopy<$R, $Out> on ObjectCopyWith<$R, Book, $Out> {
  BookCopyWith<$R, Book, $Out> get $asBook =>
      $base.as((v, t, t2) => _BookCopyWithImpl(v, t, t2));
}

abstract class BookCopyWith<$R, $In extends Book, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? title,
      String? description,
      String? author,
      DateTime? publicationDate,
      String? genre,
      int? copies});
  BookCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Book, $Out>
    implements BookCopyWith<$R, Book, $Out> {
  _BookCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Book> $mapper = BookMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          String? title,
          String? description,
          String? author,
          DateTime? publicationDate,
          String? genre,
          int? copies}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (description != null) #description: description,
        if (author != null) #author: author,
        if (publicationDate != null) #publicationDate: publicationDate,
        if (genre != null) #genre: genre,
        if (copies != null) #copies: copies
      }));
  @override
  Book $make(CopyWithData data) => Book(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      author: data.get(#author, or: $value.author),
      publicationDate: data.get(#publicationDate, or: $value.publicationDate),
      genre: data.get(#genre, or: $value.genre),
      copies: data.get(#copies, or: $value.copies));

  @override
  BookCopyWith<$R2, Book, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BookCopyWithImpl($value, $cast, t);
}
