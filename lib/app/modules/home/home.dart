import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:walikelas_ummar/app/modules/page1/profile/profile.dart';

import '../../color/app_color.dart';
import '../page1/dashboard/dashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          SafeArea(child: Dashboard()),
          const SafeArea(child: Profile()),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: GNav(
              gap: 15,
              activeColor: Colors.white,
              tabBackgroundColor: AppColor.secondPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
              tabs: const [
                GButton(
                  icon: CupertinoIcons.home,
                  text: 'Home',
                  iconColor: Colors.black,
                ),
                GButton(
                  icon: CupertinoIcons.person,
                  text: 'Profile Ortu',
                  iconColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
