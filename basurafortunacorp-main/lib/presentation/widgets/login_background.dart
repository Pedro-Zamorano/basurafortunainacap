import 'package:flutter/material.dart';

class BackgroundColor extends StatelessWidget {
  final Widget widget;
  const BackgroundColor({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    Color color1 = const Color(0xFF021024);
    Color color2 = const Color(0xFF052659);
    Color color3 = const Color(0xFF5483B3);
    // Color color4 = const Color(0xFF7DA0CA);
    // Color color5 = const Color(0xFFC1E8FF);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2, color3],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: widget,
    );
  }
}
