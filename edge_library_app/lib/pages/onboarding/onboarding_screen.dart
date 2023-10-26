import 'package:edge_library_app/app/app_bar.dart';
import 'package:edge_library_app/entities/patron/model/patron.dart';
import 'package:edge_library_app/pages/onboarding/onboarding_notifier.dart';
import 'package:edge_library_app/providers.dart';
import 'package:edge_library_app/shared/extensions/build_context.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(onboardingNotifierProvider.select((value) => value.result),
        (previous, next) {
      if (next == null) return;

      if (next.isOk()) {
        ref.invalidate(currentUserProvider);
        ref.invalidate(patronProvider);
        if (context.mounted) context.go('/');
      }
    });

    return Scaffold(
      appBar: const LibraryAppBar(),
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
                constraints: const BoxConstraints(maxWidth: 600),
                child: child,
              ),
            ),
          ),
          children: [
            const Text(
              'Create Patron Account',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Gap(12),
            TextFormField(
              controller: ref.watch(textEditingControllerProvider('name')),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'John Doe',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'This field is required' : null,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofillHints: const [AutofillHints.name],
            ),
            const Gap(12),
            SizedBox(
              width: 400,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  final form = ref.read(_formKeyProvider);

                  if (form.currentState!.validate()) {
                    final notifier =
                        ref.read(onboardingNotifierProvider.notifier);
                    final name =
                        ref.read(textEditingControllerProvider('name')).text;

                    final result = await notifier.createPatron(name);

                    result.inspectErr((failure) {
                      context.showError(
                        'Unexpected issue',
                        'There was an unexpected issue with your request',
                      );
                    });
                  }
                },
                child: const Text('Create Account'),
              ),
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
