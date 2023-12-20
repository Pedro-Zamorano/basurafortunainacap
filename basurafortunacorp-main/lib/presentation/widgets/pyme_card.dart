import 'package:flutter/material.dart';

class PymeCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final Function()? onTap;
  const PymeCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color color1 = const Color(0xFF021024);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: color1.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              image,
              width: 50,
              height: 50,
            ),
          ),
          title: Text(title),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
