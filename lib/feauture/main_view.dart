import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/feauture/cart/cart_view.dart';
import 'package:flutter_bootcamp_project/feauture/home/home_view.dart';
import 'package:flutter_bootcamp_project/feauture/profile/profile_view.dart';
import 'package:flutter_bootcamp_project/product/utility/widgets/app_bottom_navigation_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeView(),
    CartView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        physics:
            const NeverScrollableScrollPhysics(), // Sayfaları kaydırmayı engellemek için
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        onItemTapped: _onItemTapped,
        pageIndex: _currentIndex,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
