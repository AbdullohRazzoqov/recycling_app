import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recycling_app/features/location/screen/location_screen.dart';

import '../../core/resources/app_icons.dart';
import '../faq/forum_screen.dart';
import '../info/info_screen.dart';
import '../scanner/scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    InfoScreen(),
    LocationScreen(),
    ScannerScreen(),
    ForumScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff8DD0DD),
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
