import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget {
  const AppAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Color color1 = const Color(0xFF021024);
    Color color2 = const Color(0xFF052659);
    // Color color3 = const Color(0xFF5483B3);
    // Color color4 = const Color(0xFF7DA0CA);
    Color color5 = const Color(0xFFC1E8FF);

    return AppBar(
      title: Image.asset(
        'assets/images/logo_bf.png',
        width: 170,
        height: 130,
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.01, 0.99],
          ),
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: color5,
        ),
      ),
    );
  }
}
