import 'package:flutter/material.dart';

import 'package:basura_fortuna_corp/presentation/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF021024),
      ),
      title: 'Material App',
      home: const LoginScreen(),
    );
  }
}