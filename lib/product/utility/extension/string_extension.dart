import 'package:easy_localization/easy_localization.dart';

extension LocalizationExtension on String {
  String get localize => this.tr();
  String localizeWithArgs(List<String> args) => this.tr(args: args);
}
