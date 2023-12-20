import 'package:flutter/material.dart';

import 'package:basura_fortuna_corp/presentation/widgets/widgets.dart';

class HistoryDetails extends StatelessWidget {
  const HistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Color color1 = const Color(0xFF021024);
    // Color color2 = const Color(0xFF052659);
    // Color color3 = const Color(0xFF5483B3);
    // Color color4 = const Color(0xFF7DA0CA);
    Color color5 = const Color(0xFFC1E8FF);

    const String username = 'Pablo';
    const String dateOfRecycling = '10-10-20230';
    const String typeOfRecycling = 'Plastico';
    const double registeredWeight = 120;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppAppBar(),
      ),
      body: AppBackground(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        widget: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // icon
                  Icon(
                    Icons.account_circle_sharp,
                    color: color5,
                    size: 150,
                  ),

                  // username
                  const Text('Nombre: $username'),

                  // date of recycling
                  const Text('Fecha del reciclaje: $dateOfRecycling'),

                  // recycling type
                  const Text('Tipos de reciclaje: $typeOfRecycling'),

                  // picture
                  Image.asset('assets/images/android.png', width: 100),

                  // recycling weight
                  const Text('Peso registrado: ${registeredWeight}kg'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
