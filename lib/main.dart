import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/feauture/auth/login/login_view.dart';
import 'package:flutter_bootcamp_project/product/cubit/theme_cubit.dart';
import 'package:flutter_bootcamp_project/product/init/app_initialize.dart';
import 'package:flutter_bootcamp_project/product/init/localization/app_localization.dart';
import 'package:flutter_bootcamp_project/product/init/state_initalize.dart';
import 'package:flutter_bootcamp_project/product/init/theme/manager/dark_theme_manager.dart';
import 'package:flutter_bootcamp_project/product/init/theme/manager/light_theme_manager.dart';

Future<void> main() async {
  await init();
  runApp(ProductLocalization(child: StateInitialize(child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightThemeManager().themeData,
      darkTheme: DarkThemeManager().themeData,
      themeMode: context.watch<ThemeCubit>().state.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: LoginView(),
    );
  }
}

// lib/main.dart
