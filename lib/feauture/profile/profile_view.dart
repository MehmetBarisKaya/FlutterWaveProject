import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/feauture/auth/login/login_view.dart';
import 'package:flutter_bootcamp_project/product/constants/enums/locales_enum.dart';
import 'package:flutter_bootcamp_project/product/cubit/theme_cubit.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/init/localization/app_localization.dart';
import 'package:flutter_bootcamp_project/product/service/user_setvice.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/context_extension.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';
import 'package:flutter_bootcamp_project/product/utility/widgets/language_bottom_sheet.dart';
import 'package:get_it/get_it.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          ListTile(
            onTap: () => LanguageBottomSheet.show(
              context,
              onTurkishTapped: () => ProductLocalization.updateLanguage(
                context,
                value: Locales.tr,
              ),
              onEnglishTapped: () async => ProductLocalization.updateLanguage(
                context,
                value: Locales.en,
              ),
            ),
            title: Text(LocaleKeys.profile_language.localize),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          SwitchListTile.adaptive(
            title: Text(LocaleKeys.profile_Theme.localize),
            value: context.isDarkMode,
            onChanged: (_) => GetIt.I<ThemeCubit>().changeThemeMode(),
          ),
          ListTile(
            title: Text(LocaleKeys.profile_Logout.localize),
            trailing: Icon(Icons.logout_outlined),
            onTap: () {
              GetIt.I<FirebaseAuthService>().signOut();

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ));
            },
          )
        ],
      )),
    );
  }
}
