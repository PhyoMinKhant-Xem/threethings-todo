import 'package:flutter/material.dart';
import 'package:threethings/screens/auth/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6A11CB), // Purple
              Color(0xFF2575FC), // Blue
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create an Account",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(_nameController, "Name", Icons.person),
                  _buildTextField(_emailController, "Email", Icons.email),
                  _buildTextField(_passwordController, "Password", Icons.lock,
                      obscureText: true),
                  _buildTextField(_confirmPasswordController,
                      "Confirm Password", Icons.lock,
                      obscureText: true),
                  const SizedBox(height: 20),
                  _buildNextButton(),
                  const SizedBox(height: 20),
                  _buildSignInOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **Custom TextField**
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// **Sign Up Button**
  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement Sign-Up Logic
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        "Sign Up",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// **Already Have an Account? Sign In**
  Widget _buildSignInOption() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      },
      child: const Text(
        "Already have an account? Sign In",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
