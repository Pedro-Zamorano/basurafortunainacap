import 'package:flutter/material.dart';

class AppBarLogin extends StatelessWidget {
  final String title;
  const AppBarLogin({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Color color1 = const Color(0xFF021024);
    // Color color2 = const Color(0xFF052659);
    // Color color3 = const Color(0xFF5483B3);
    // Color color4 = const Color(0xFF7DA0CA);
    Color color5 = const Color(0xFFC1E8FF);

    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: color5,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color5,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          fontSize: 24,
          fontFamily: 'Assistant',
        ),
      ),
      backgroundColor: color1,
    );
  }
}
