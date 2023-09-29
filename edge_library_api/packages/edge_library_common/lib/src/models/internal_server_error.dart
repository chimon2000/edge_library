abstract class InternalServerError {
  const InternalServerError({this.message, this.code});

  final String? message;
  final String? code;

  String toJson();
}
