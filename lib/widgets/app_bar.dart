import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threethings/providers/theme_provider.dart';
import 'package:threethings/screens/profile_screen.dart'; // Import ProfileScreen

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String profileImage;

  const CustomAppBar({
    Key? key,
    required this.userName,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to ProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
              radius: 20,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Good Morning 👋",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
