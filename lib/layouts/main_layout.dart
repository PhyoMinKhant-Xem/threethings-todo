import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threethings/methods/database_methods/user_methods.dart';
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
  String? id;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    getId();
    if(id != null){
      userProvider.fetchUser(id!);
    }
  }

  void getId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        id = user.uid;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    if (id == null || user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }else{
      List<Widget> _screens = [
        HomeScreen(user: user),
        OverviewScreen()
      ];
      return Scaffold(
        appBar: CustomAppBar(
          userName: user.name,
          profileImage: user.profilePic,
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
    }


  }
}
