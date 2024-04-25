import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  Widget build(context) {
    return Row(
      children: [
        const SizedBox(width: 6),
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(
              color: Colors.white,
            ))
      ],
    );
  }
}
