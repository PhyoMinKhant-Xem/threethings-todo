import 'package:flutter/material.dart';
import 'package:threethings/screens/home_screen.dart';
import 'package:threethings/screens/overview_screen.dart';
import 'package:threethings/widgets/app_bar.dart';
import 'package:threethings/widgets/bottom_nav.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    OverviewScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(userName: "userName", profileImage: "profileImage"),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
