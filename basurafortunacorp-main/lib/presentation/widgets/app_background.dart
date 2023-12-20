import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget widget;
  final Alignment? begin;
  final Alignment? end;
  const AppBackground({
    super.key,
    required this.widget,
    this.begin,
    this.end,
  });

  @override
  Widget build(BuildContext context) {
    Color color1 = const Color(0xFF021024);
    Color color2 = const Color(0xFF052659);
    Color color3 = const Color(0xFF5483B3);
    Color color4 = const Color(0xFF7DA0CA);
    Color color5 = const Color(0xFFC1E8FF);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2, color3, color4, color5],
          begin: begin ?? Alignment.bottomRight,
          end: end ?? Alignment.topLeft,
        ),
      ),
      child: widget,
    );
  }
}
