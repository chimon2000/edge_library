import 'package:edge_library_app/entities/patron/model/patron.dart';
import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:edge_library_app/shared/extensions/build_context.dart';
import 'package:edge_library_app/pages/login/login_notifier.dart';
import 'package:edge_library_app/routing/router.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginNotifierProvider.select((value) => value.result),
        (previous, next) {
      next?.inspect((success) {
        ref.invalidate(currentUserProvider);
        ref.invalidate(patronProvider);
        if (context.mounted) context.go('/');
      });
    });

    final authActionLabel = ref.watch(loginNotifierProvider
        .select((value) => value.isNewUser ? 'Register' : 'Login'));

    final switchLabel = !ref.watch(loginNotifierProvider).isNewUser
        ? 'Don\'t have an account? Register'
        : 'Already have an account? Log in';
    final isOtpRequired =
        ref.watch(loginNotifierProvider.select((value) => value.isOtpRequired));

    return Scaffold(
      body: Form(
        key: ref.watch(_formKeyProvider),
        child: ExpandedScrollingColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          scrollViewBuilder: (direction, child) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: child,
              ),
            ),
          ),
          children: [
            Text(
              authActionLabel,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Gap(12),
            TextFormField(
              controller:
                  ref.watch(textEditingControllerProvider('identifier')),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'This field is required' : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'example@passage.id',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofillHints: const [AutofillHints.email],
              textCapitalization: TextCapitalization.none,
            ),
            const Gap(12),
            if (isOtpRequired) ...[
              TextFormField(
                obscureText: true,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'This field is required' : null,
                controller: ref.watch(textEditingControllerProvider('otp')),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Code',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
              ),
              const Gap(12),
              TextButton(
                onPressed: () =>
                    ref.read(loginNotifierProvider.notifier).resetCode(),
                child: const Text('Reset'),
              ),
              const Gap(12),
            ],
            ElevatedButton(
              onPressed: () async {
                final form = ref.read(_formKeyProvider);

                if (form.currentState!.validate()) {
                  final notifier = ref.read(loginNotifierProvider);
                  final identifier = ref
                      .read(textEditingControllerProvider('identifier'))
                      .text;
                  final otp =
                      ref.read(textEditingControllerProvider('otp')).text;

                  if (notifier.isOtpRequired) {
                    ref
                        .read(loginNotifierProvider.notifier)
                        .activateOtp(otp, identifier);

                    return;
                  }

                  final result = notifier.isNewUser
                      ? await ref
                          .read(loginNotifierProvider.notifier)
                          .register(identifier)
                      : await ref
                          .read(loginNotifierProvider.notifier)
                          .login(identifier);

                  result.inspectErr((failure) {
                    final title = ref.read(loginNotifierProvider).isNewUser
                        ? 'Registration issue'
                        : 'Login issue';

                    switch (failure) {
                      case PassageAuthException(:final original):
                        context.showError(title, original.message);

                        break;
                      default:
                    }
                  });
                }
              },
              child: Text(authActionLabel),
            ),
            const Gap(6),
            TextButton(
              onPressed: () =>
                  ref.read(loginNotifierProvider.notifier).toggleIsNewUser(),
              child: Text(switchLabel),
            ),
          ],
        ),
      ),
    );
  }
}

final textEditingControllerProvider =
    Provider.family.autoDispose<TextEditingController, String>((ref, id) {
  return TextEditingController();
});

final _formKeyProvider =
    Provider.autoDispose<GlobalKey<FormState>>((ref) => GlobalKey<FormState>());
