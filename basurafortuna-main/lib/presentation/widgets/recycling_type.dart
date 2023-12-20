import 'package:flutter/material.dart';

class RecyclingType extends StatelessWidget {
  final String title;
  final Color? itColor;
  const RecyclingType({
    super.key,
    required this.title,
    required this.itColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.recycling_rounded,
        color: itColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: itColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
