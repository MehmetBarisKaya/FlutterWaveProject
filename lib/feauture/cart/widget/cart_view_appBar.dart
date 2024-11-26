part of '../cart_view.dart';

class CartViewAppBar extends StatelessWidget {
  const CartViewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.onPrimary,
      elevation: 0,
      title: Text(
        LocaleKeys.cart_title.localize,
        style: TextStyle(
            color: context.colorScheme.surface, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
