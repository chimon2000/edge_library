import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:edge_library_data/edge_library_data.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:supabase/supabase.dart';

Handler middleware(Handler handler) {
  final env = DotEnv(includePlatformEnvironment: true)
    ..load(File('.env').existsSync() ? const ['.env'] : const []);

  final client = SupabaseClient(
    env['SUPABASE_URL']!,
    env['SUPABASE_KEY']!,
  );

  return handler
      .use(fromShelfMiddleware(corsHeaders()))
      .use(requestLogger())
      .use(provider<BookRepository>((context) => BookRepository(client)))
      .use(provider<PatronRepository>((context) => PatronRepository(client)))
      .use(
        provider<AuthenticatorFacade>(
          (context) => AuthenticatorFacade(env['PUBLIC_AUTH_KEY']!),
        ),
      );
}
