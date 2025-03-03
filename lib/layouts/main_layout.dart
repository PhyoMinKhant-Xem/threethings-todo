import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/screens/home_screen.dart';
import 'package:threethings/screens/overview_screen.dart';
import 'package:threethings/utils/user_provider.dart';
import 'package:threethings/widgets/app_bar.dart';
import 'package:threethings/widgets/bottom_nav.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<UserProviders>(context, listen: false).refreshUser());
  }

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
    final AppUser? user = Provider.of<UserProviders>(context).getUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(userName: user.name, profileImage: user.profilePic),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}