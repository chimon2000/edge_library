import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:edge_library_data/edge_library_data.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

Handler middleware(Handler handler) {
  return handler
      .use(fromShelfMiddleware(corsHeaders()))
      .use(requestLogger())
      .use(
    bearerAuthentication<User>(
      authenticator: (context, token) async {
        final userRepository = context.read<AuthenticatorFacade>();
        final tokenResult = await userRepository.verifyToken(token);

        return tokenResult.getOrNull();
      },
    ),
  );
}
