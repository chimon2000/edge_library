import 'package:edge_library_app/entities/patron/model/patron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PatronFloatingActionButton extends ConsumerWidget {
  const PatronFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn =
        ref.watch(patronProvider.select((value) => value.valueOrNull != null));

    return isLoggedIn
        ? FloatingActionButton.small(
            child: const Icon(Icons.person_2_outlined),
            onPressed: () {
              context.go('/patron');
            },
          )
        : const SizedBox.shrink();
  }
}
