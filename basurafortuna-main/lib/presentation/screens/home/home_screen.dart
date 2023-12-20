import 'package:flutter/material.dart';

import 'package:basura_fortuna/presentation/widgets/widgets.dart';
import 'package:basura_fortuna/presentation/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color color1 = const Color(0xFF021024);
    Color color2 = const Color(0xFF052659);
    // Color color3 = const Color(0xFF5483B3);
    Color color4 = const Color(0xFF7DA0CA);
    Color color5 = const Color(0xFFC1E8FF);

    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo_bf.png',
            width: 170,
            height: 130,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color4, color5],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          bottom: TabBar(
            dividerColor: color5,
            indicatorColor: color1,
            splashBorderRadius: BorderRadius.circular(50),
            tabs: [
              Tab(
                // text: 'Perfil',
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: color2,
                  size: 35,
                ),
              ),
              Tab(
                // text: 'Pymes',
                icon: Icon(
                  Icons.recycling,
                  color: color2,
                  size: 35,
                ),
              ),
              Tab(
                // text: 'Mapa',
                icon: Icon(
                  Icons.map_outlined,
                  color: color2,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
        body: const AppBackground(
          widget: TabBarView(
            children: [
              ProfileScreen(),
              PymesScreen(),
              MapScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
