import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:edge_library_data/edge_library_data.dart';
import 'package:option_result/option_result.dart';

Handler middleware(Handler handler) {
  return handler.use(
    bearerAuthentication<User>(
      authenticator: (context, token) async {
        final userRepository = context.read<AuthenticatorFacade>();
        final tokenResult = await userRepository.verifyToken(token);

        return switch (tokenResult) {
          Some(:final value) => value,
          _ => null,
        };
      },
    ),
  );
}
