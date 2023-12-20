import 'package:flutter/material.dart';

import 'package:basura_fortuna_corp/presentation/screens/screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  Color color3 = const Color(0xFF5483B3);
  Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar.secondary(
          dividerColor: color5,
          indicatorColor: color1,
          labelColor: color1,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
          unselectedLabelColor: color2,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Perfil'),
            Tab(text: 'Registrar Horas'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              EditProfile(),
              HoursRegister(),
            ],
          ),
        ),
      ],
    );
  }
}
