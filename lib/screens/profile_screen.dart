import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threethings/providers/theme_provider.dart';
import 'package:threethings/screens/edit_profile_screen.dart';
import 'package:threethings/screens/auth/sign_in_screen.dart'; // Import Sign-In Page

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color sectionTitleColor =
        isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: textColor),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  const SizedBox(width: 12),
                  // Name and Phone Number
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mukhlisin",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          "0845-3243-2324",
                          style: TextStyle(color: sectionTitleColor),
                        ),
                      ],
                    ),
                  ),
                  // Edit Button
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Account Setting Section
            _buildSectionTitle("Account Setting", sectionTitleColor),
            _buildProfileOption(
                Icons.payment, "Payment Methods", () {}, textColor),

            // App Setting Section
            _buildSectionTitle("App Setting", sectionTitleColor),
            _buildProfileOption(
                Icons.notifications, "Notification", () {}, textColor),
            _buildProfileOption(Icons.security, "Security", () {}, textColor),

            // Support Section
            _buildSectionTitle("Support", sectionTitleColor),
            _buildProfileOption(
                Icons.help_outline, "Help Center", () {}, textColor),

            // Logout
            _buildSectionTitle("Log Out", sectionTitleColor),
            _buildProfileOption(
              Icons.logout,
              "Logout",
              () => _showLogoutDialog(context),
              textColor,
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // Profile Option Tile
  Widget _buildProfileOption(
      IconData icon, String title, VoidCallback onTap, Color textColor,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : textColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isLogout ? Colors.red : textColor,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  // Show Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog first
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (route) => false, // Remove all previous pages
                );
              },
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
