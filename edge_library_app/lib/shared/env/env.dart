import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'PASSAGE_APP_ID')
  static const String passageAppId = _Env.passageAppId;
}
