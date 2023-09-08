import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

extension TextThemeBuildContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ShowErrorExtension on BuildContext {
  Future<T?> showError<T>(
    String title,
    String description,
  ) {
    return WoltModalSheet.show<T>(
      context: this,
      pageListBuilder: (context) => [
        WoltModalSheetPage.withSingleChild(
          hasSabGradient: false,
          pageTitle: Padding(
            padding:
                const EdgeInsets.only(left: 35, right: 35, top: 35, bottom: 16),
            child: Text(
              title,
              style: textTheme.titleMedium,
              textAlign: TextAlign.left,
            ),
          ),
          hasTopBarLayer: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  description,
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.left,
                ),
                const Gap(16),
                ButtonBar(
                  children: [
                    TextButton(
                      child: const Text('Okay'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
