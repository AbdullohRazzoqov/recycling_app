import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_icons.dart';
import 'forum/forum_screen.dart';
import 'home/home_screen.dart';
import 'location/location_screen.dart';
import 'scanner/scanner_screen.dart';
import 'package:flutter_svg/svg.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const LocationScreen(),
    const ScannerScreen(),
    const ForumScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: _pages.elementAt(_selectedIndex)),
      //  IndexedStack(
      //   index: _selectedIndex,
      //   children: _pages,
      // ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.c_8DD0DD,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.info,
                  colorFilter: _selectedIndex == 0
                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                      : null,
                ),
                label: "Info"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.location,
                  colorFilter: _selectedIndex == 1
                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                      : null,
                ),
                label: "Location"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.scanner,
                  colorFilter: _selectedIndex == 2
                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                      : null,
                ),
                label: "Scanner"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.faq,
                  colorFilter: _selectedIndex == 3
                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                      : null,
                ),
                label: "Faq"),
          ]),
    );
  }
}
