import 'package:edge_library_app/features/sign_out/sign_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const LibraryAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions = const [],
    this.includeLogoutButton = true,
  });

  final Widget? leading;
  final Widget? title;

  final List<Widget> actions;
  final bool includeLogoutButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: leading,
      title: title,
      actions: [
        ...actions,
        if (includeLogoutButton) const SignOutButton(),
      ],
    );
  }
}
