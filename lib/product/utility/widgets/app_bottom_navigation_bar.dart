import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/context_extension.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';

typedef OnItemTapped = void Function(int)?;

final class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.pageIndex,
    super.key,
    this.onItemTapped,
  });
  final OnItemTapped onItemTapped;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onItemTapped,
      currentIndex: pageIndex,
      selectedItemColor: context.colorScheme.onPrimary,
      items: [
        BottomNavigationBarItem(
          label: LocaleKeys.tabBar_products.localize,
          icon: const Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: LocaleKeys.tabBar_cart.localize,
          icon: const Icon(Icons.shopping_basket),
        ),
        BottomNavigationBarItem(
          label: LocaleKeys.tabBar_profile.localize,
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }
}
