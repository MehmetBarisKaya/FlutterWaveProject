import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/product/constants/language_constant.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/context_extension.dart';

final class BottomSheetBase {
  const BottomSheetBase._();

  /// Show a general bottom sheet with
  /// [builder] for the bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
  }) async {
    return showModalBottomSheet<T>(
      context: context,
      builder: builder,
    );
  }
}

final class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({
    super.key,
    required this.onTurkishTapped,
    required this.onEnglishTapped,
  });

  final VoidCallback onTurkishTapped;
  final VoidCallback onEnglishTapped;

  /// Show the dialog for page info
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onTurkishTapped,
    required VoidCallback onEnglishTapped,
  }) async {
    await BottomSheetBase.show<void>(
      context: context,
      builder: (context) => LanguageBottomSheet(
        onTurkishTapped: onTurkishTapped,
        onEnglishTapped: onEnglishTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.2,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              onTurkishTapped();
              Navigator.of(context).pop();
            },
            title: const Text(LanguageConstants.turkish),
          ),
          ListTile(
            onTap: () {
              onEnglishTapped();
              Navigator.of(context).pop();
            },
            title: const Text(LanguageConstants.english),
          ),
        ],
      ),
    );
  }
}
