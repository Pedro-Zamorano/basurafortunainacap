import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color5 = const Color(0xFFC1E8FF);
    return CircularProgressIndicator(color: color5);
  }
}
