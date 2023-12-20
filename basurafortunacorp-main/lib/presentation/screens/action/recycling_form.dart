import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:basura_fortuna_corp/presentation/widgets/widgets.dart';

class RecyclingForm extends StatefulWidget {
  const RecyclingForm({super.key, required this.data});
  final String data;

  @override
  State<RecyclingForm> createState() => _RecyclingFormState();
}

class _RecyclingFormState extends State<RecyclingForm> {
  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  // Color color3 = const Color(0xFF5483B3);
  Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController recyclingTypeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  // decode data
  late String username;
  late String email;
  late String address;
  late int phone;

  @override
  void initState() {
    super.initState();
    // Decode data and assign values to variables
    Map<String, dynamic> parseData = jsonDecode(widget.data);
    username = parseData['username'];
    email = parseData['email'];
    phone = parseData['phone'];
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Datos de la orden',
                    style: TextStyle(
                      color: color5,
                      fontFamily: 'Assistant',
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 15),

                  Text(
                    'Complete los datos faltantes para finalizar la orden de reciclaje',
                    style: TextStyle(
                      color: color4,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  // // username
                  // TextInput(
                  //   labelTitle: username,
                  //   hintText: 'Nombre Usuario',
                  //   obscureText: false,
                  //   labelIcon: Icons.account_circle_outlined,
                  //   controller: usernameController,
                  //   status: false,
                  // ),

                  // const SizedBox(height: 10),

                  // // email
                  // TextInput(
                  //   labelTitle: email,
                  //   hintText: 'Email',
                  //   obscureText: false,
                  //   labelIcon: Icons.alternate_email_rounded,
                  //   controller: emailController,
                  //   status: false,
                  // ),

                  // const SizedBox(height: 10),

                  // // phone
                  // TextInput(
                  //   labelTitle: phone.toString(),
                  //   hintText: 'Celular',
                  //   obscureText: false,
                  //   labelIcon: Icons.phone_android_outlined,
                  //   controller: phoneController,
                  //   status: false,
                  // ),

                  // const SizedBox(height: 10),

                  // // recycling types
                  // TextInput(
                  //   labelTitle: 'Tipo reciclaje',
                  //   hintText: 'Tipo reciclaje',
                  //   obscureText: false,
                  //   labelIcon: Icons.recycling_rounded,
                  //   controller: recyclingTypeController,
                  //   textColor: color2,
                  //   hintColor: color2,
                  // ),

                  // const SizedBox(height: 10),

                  // // weight input
                  // TextInput(
                  //   labelTitle: 'Peso reciclaje',
                  //   hintText: 'Peso reciclaje',
                  //   obscureText: false,
                  //   labelIcon: Icons.balance_rounded,
                  //   controller: weightController,
                  //   textColor: color2,
                  //   hintColor: color2,
                  // ),

                  const SizedBox(height: 20),

                  Text(
                    'Tome una foto del peso visto en la balanza',
                    style: TextStyle(color: color2, fontSize: 14),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // photo
                        // ! poner "HERO"
                        Container(
                          color: Colors.white,
                          width: 60,
                          height: 60,
                        ),

                        // camera button
                        const SizedBox(width: 50),

                        Button(
                          backgroundColor: color5,
                          textColor: color1,
                          buttonText: 'Abrir camara',
                          onPress: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ok button
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: SizedBox(
                      width: double.infinity,
                      child: Button(
                        buttonText: 'Aceptar',
                        onPress: () {
                          // ! guardar datos en BD y volver al menu principal
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
