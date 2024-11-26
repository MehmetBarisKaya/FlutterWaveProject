import 'package:flutter/material.dart';

///Project locale enum  for operation  and configuration
enum Locales {
  ///turkish locale
  tr(Locale('tr', 'TR')),

  ///English locale
  en(Locale('en', 'US'));

  ///Locale value constructor
  const Locales(this.locale);

  ///Locale value
  final Locale locale;

  ///Project supported locales
  static final List<Locale> supportedLocales = [
    Locales.en.locale,
    Locales.tr.locale,
  ];
}
