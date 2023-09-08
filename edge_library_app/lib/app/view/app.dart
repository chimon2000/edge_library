import 'package:edge_library_app/routing/router.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: FlexThemeData.dark(
        scheme: FlexScheme.amber,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        appBarOpacity: .2,
        subThemesData: const FlexSubThemesData(
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorBorderWidth: 1,
          inputDecoratorRadius: 12,
          inputDecoratorBorderSchemeColor: SchemeColor.primary,
        ),
      ),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
