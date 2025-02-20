import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 15.0,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center items
          mainAxisSize: MainAxisSize.min, // Prevent extra space
          children: [
            _buildNavItem(Icons.dashboard, "Home", 0),
            const SizedBox(width: 20), // Small gap between items
            _buildNavItem(Icons.analytics, "Overview", 1),
          ],
        ),
      ),
    );
  }

  // Custom Bottom Navigation Item
  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
            size: isSelected ? 28 : 24,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 4,
            width: isSelected ? 20 : 0,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
