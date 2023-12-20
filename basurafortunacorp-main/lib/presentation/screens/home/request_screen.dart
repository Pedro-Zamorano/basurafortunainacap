import 'package:basura_fortuna_corp/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen>
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
            fontSize: 18,
          ),
          unselectedLabelColor: color2,
          controller: _tabController,
          tabs: const [
            // Tab(text: 'Registrar Reciclaje'),
            Tab(text: 'Solicitudes'),
            Tab(text: 'Histórico'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              // RecyclingRegister(),
              RecyclingActive(),
              RecyclingHistory(),
            ],
          ),
        ),
      ],
    );
  }
}
