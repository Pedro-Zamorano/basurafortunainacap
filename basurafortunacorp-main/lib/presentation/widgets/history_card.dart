import 'package:flutter/material.dart';

class HostiryCard extends StatelessWidget {
  final String username;
  final String dateOfRecycling;
  final VoidCallback onTap;
  const HostiryCard({
    super.key,
    required this.username,
    required this.dateOfRecycling,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Color color1 = const Color(0xFF021024);
    Color color2 = const Color(0xFF052659);
    Color color3 = const Color(0xFF5483B3);
    // Color color4 = const Color(0xFF7DA0CA);
    // Color color5 = const Color(0xFFC1E8FF);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            dense: true,
            leading: Icon(
              Icons.pending_actions_outlined,
              size: 36,
              color: color2,
            ),
            title: Text(username),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: color2,
            ),
            subtitle: Text(dateOfRecycling),
            subtitleTextStyle: TextStyle(
              fontStyle: FontStyle.italic,
              color: color3,
            ),
            trailing: Icon(
              Icons.circle_outlined,
              color: color2,
            ),
            onTap: onTap,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
