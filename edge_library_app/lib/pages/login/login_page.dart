import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:edge_library_app/shared/extensions/build_context.dart';
import 'package:edge_library_app/pages/login/login_notifier.dart';
import 'package:edge_library_app/routing/router.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:passage_flutter/passage_flutter_models/passage_error_code.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginNotifierProvider.select((value) => value.result),
        (previous, next) {
      next?.onSuccess((success) {
        ref.invalidate(currentUserProvider);
        if (context.mounted) context.go('/');
      });
      next?.onFailure((failure) {
        final title = ref.read(loginNotifierProvider).isNewUser
            ? 'Registration issue'
            : 'Login issue';
        switch (failure) {
          case PassageAuthException(:final original)
              when original.code != PassageErrorCode.passkeyError:
            context.showError(title, original.message);

            break;
          default:
        }
      });
    });

    final label =
        ref.watch(loginNotifierProvider).isNewUser ? 'Register' : 'Login';
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
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: child,
              ),
            ),
          ),
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Gap(12),
            TextFormField(
              controller:
                  ref.watch(textEditingControllerProvider('identifier')),
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
            ],
            SizedBox(
              width: 400,
              height: 48,
              child: ElevatedButton(
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

                    if (notifier.isNewUser) {
                      await ref
                          .read(loginNotifierProvider.notifier)
                          .register(identifier);
                    } else {
                      await ref
                          .read(loginNotifierProvider.notifier)
                          .login(identifier);
                    }
                  }
                },
                child: Text(label),
              ),
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
