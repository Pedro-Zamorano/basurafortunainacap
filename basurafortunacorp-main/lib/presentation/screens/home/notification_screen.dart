import 'package:basura_fortuna_corp/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          NotificationsCard()
        ],
      ),
    );
  }
}
