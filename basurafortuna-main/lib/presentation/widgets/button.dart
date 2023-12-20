import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonText;
  const Button({
    super.key,
    required this.buttonText,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF052659),
        ),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFFC1E8FF),
            ),
          ),
        ),
      ),
    );
  }
}
