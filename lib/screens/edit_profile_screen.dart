import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threethings/providers/theme_provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color inputBackgroundColor =
        isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        elevation: 0,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture with Edit Icon
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child:
                          const Icon(Icons.edit, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Full Name Field
            _buildLabel("Full Name"),
            _buildInputField(
                Icons.person, "Mukhlisin", inputBackgroundColor, textColor),

            // Email Field
            _buildLabel("Email"),
            _buildInputField(Icons.email, "Mukhlisin@gmail.com",
                inputBackgroundColor, textColor),

            const Spacer(),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Submit
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Label for input fields
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Input Field Widget
  Widget _buildInputField(
      IconData? icon, String hintText, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon, color: Colors.grey) : null,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: TextStyle(color: textColor),
      ),
    );
  }
}
