import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DailyStreakScreen extends StatelessWidget {
  final int streakCount;

  DailyStreakScreen({required this.streakCount}); // Default streak count

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/fire_animation.json',
            width: 125,
            height: 125,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 50),
          Text(
            '$streakCount Day Streak',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
