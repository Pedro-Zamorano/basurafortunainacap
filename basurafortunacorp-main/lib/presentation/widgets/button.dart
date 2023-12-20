import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonText;
  final Color? backgroundColor;
  final Color? textColor;
  const Button({
    super.key,
    required this.buttonText,
    required this.onPress,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF052659),
        ),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20,
              color: textColor ?? const Color(0xFFC1E8FF),
            ),
          ),
        ),
      ),
    );
  }
}
