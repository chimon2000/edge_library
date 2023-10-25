import 'package:edge_library_app/providers.dart';
import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      child: const Text('Sign Out'),
      onPressed: () async {
        await ref.read(identityFacadeProvider).signOut();
        ref.invalidate(currentUserProvider);
        if (context.mounted) context.go('/');
      },
    );
  }
}
