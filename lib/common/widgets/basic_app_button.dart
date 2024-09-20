import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.name,
    this.backgroundColor,
  });

  final VoidCallback onPressed;
  final String name;
  final WidgetStateProperty<Color>? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: backgroundColor,
          elevation: WidgetStateProperty.all(0),
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
