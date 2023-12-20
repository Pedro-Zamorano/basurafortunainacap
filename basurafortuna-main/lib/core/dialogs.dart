//==== EXITO EN CREAR CUENTA - OK
// ignore_for_file: non_constant_identifier_names

import 'package:basura_fortuna/presentation/screens/home/home_screen.dart';
import 'package:basura_fortuna/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

Color color1 = const Color(0xFF021024);
Color color2 = const Color(0xFF052659);
Color color3 = const Color(0xFF5483B3);
Color color4 = const Color(0xFF7DA0CA);
Color color5 = const Color(0xFFC1E8FF);

//==== EXITO AL CREAR CUENTA
void DialogExitoCrearCuenta(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: color2,
        title: Text(
          'Éxito',
          style: TextStyle(
            color: color5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text('Registro exitoso.'),
        contentTextStyle: TextStyle(
          color: color5,
          fontSize: 18,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: color3),
              child: Text(
                'Aceptar',
                style: TextStyle(
                  color: color1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Redirigir a LoginScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

//==== ERROR DEL CATCH
void DialogError(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: color2,
        title: Text(
          'Falla de registro',
          style: TextStyle(
            color: color5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text('No fue posible procesar la solicitud.'),
        contentTextStyle: TextStyle(
          color: color5,
          fontSize: 18,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              child: Text(
                'Volver',
                style: TextStyle(
                  color: color5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}

// EXITO AL ACTUALIZAR PERFIL
void DialogExitoActualizarPerfil(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: color2,
        title: Text(
          'Éxito',
          style: TextStyle(
            color: color5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text('Actualización exitosa.'),
        contentTextStyle: TextStyle(
          color: color5,
          fontSize: 18,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: color3),
              child: Text(
                'Aceptar',
                style: TextStyle(
                  color: color1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Redirigir a HomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

// EXITO AL ACTUALIZAR CONTRASEÑA
void DialogExitoActualizarContrasena(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: color2,
        title: Text(
          'Éxito',
          style: TextStyle(
            color: color5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text('Actualización exitosa.'),
        contentTextStyle: TextStyle(
          color: color5,
          fontSize: 18,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: color3),
              child: Text(
                'Aceptar',
                style: TextStyle(
                  color: color1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Redirigir a HomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

// ERROR AL ACTUALIZAR CONTRASEÑA
void DialogErrorActualizarContrasena(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: color2,
        title: Text(
          'No fue posible actualizar',
          style: TextStyle(
            color: color5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(height: 15),
            const Text('Verifique su email ó rut')
          ],
        ),
        contentTextStyle: TextStyle(
          color: color5,
          fontSize: 18,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: color3),
              child: Text(
                'Aceptar',
                style: TextStyle(
                  color: color1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}

//==== ERROR USUARIO NO EXISTE
void DialogUserNotFound(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: color2,
        title: Text(
          '¡Usuario no encontrado!',
          style: TextStyle(
            color: color5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'La cuenta ingresada no tiene registro en nuestro sistema.',
          textAlign: TextAlign.center,
        ),
        contentTextStyle: TextStyle(
          color: color5,
          fontSize: 18,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              child: Text(
                'Volver',
                style: TextStyle(
                  color: color5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
