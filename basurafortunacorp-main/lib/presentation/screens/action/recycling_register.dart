import 'package:flutter/material.dart';

import 'package:basura_fortuna_corp/presentation/screens/screens.dart';
import 'package:basura_fortuna_corp/presentation/widgets/button.dart';

class RecyclingRegister extends StatefulWidget {
  const RecyclingRegister({super.key});

  @override
  State<RecyclingRegister> createState() => _RecyclingRegisterState();
}

class _RecyclingRegisterState extends State<RecyclingRegister> {
  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  Color color3 = const Color(0xFF5483B3);
  Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Para registrar un reciclaje, debes leer el código QR del usuario. Presiona "Escanear QR" para iniciar el proceso de registro.',
              style: TextStyle(color: color2, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const Icon(
              Icons.qr_code_2,
              size: 300,
            ),
            const SizedBox(height: 30),
            Button(
              buttonText: 'Escanear QR',
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CameraReader(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
