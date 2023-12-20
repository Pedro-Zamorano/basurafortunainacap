import 'package:basura_fortuna_corp/core/constant.dart';
import 'package:basura_fortuna_corp/core/dialogs.dart';
import 'package:basura_fortuna_corp/core/validations/email_validation.dart';
import 'package:basura_fortuna_corp/infraestructure/models/user/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:basura_fortuna_corp/presentation/widgets/widgets.dart';
import 'package:logger/logger.dart';
import 'package:validate_rut/validate_rut.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  // Color color1 = const Color(0xFF021024);
  // Color color2 = const Color(0xFF052659);
  // Color color3 = const Color(0xFF5483B3);
  // Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);
  String required = '* Campo requerido';

  final GlobalKey<FormState> _recoverPasswordFormState = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  static final Logger _logger = Logger();

  ApiResponse? apiResponse;

  String? email;
  String? preDni;
  int? dni;
  String? password;
  String? repeatPassword;

  Future<void> recoverPassword() async {
    Map<String, dynamic> dataToRecover = {
      "dni": dni,
      "email": email,
      "password": password,
      "repeat_password": repeatPassword
    };

    try {
      final response =
          await Dio().post(pymeRecoverPasswordUrl, data: dataToRecover);

      apiResponse = ApiResponse.fromJson(response.data);

      if (apiResponse!.ok) {
        // ignore: use_build_context_synchronously
        DialogExitoActualizarContrasena(context);
      } else if (!apiResponse!.ok) {
        // ignore: use_build_context_synchronously
        DialogErrorActualizarContrasena(context, apiResponse!.message);
      }
    } catch (error) {
      if (error is DioException) {
        DioException dioException = error;
        switch (dioException.type) {
          case DioExceptionType.badResponse:
            _logger.i(dioException.response?.statusCode);
            _logger.i(dioException.response?.statusMessage);
            break;
          default:
            _logger.e(error.toString());
            _logger.d(error.toString());
        }
      } else {
        _logger.e(error.toString());
        _logger.d(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //==== formato RUT
    var rutMask = RutInputFormatter();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarLogin(title: 'Recuperar Contraseña'),
      ),
      body: BackgroundColor(
        widget: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _recoverPasswordFormState,
                child: Column(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      color: color5,
                      size: 120,
                    ),
                    const SizedBox(height: 30),

                    // title
                    Text(
                      'Ingresa tu email y rut para realizar el cambio de contraseña.',
                      style: TextStyle(
                        color: color5,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    // registered email
                    // email
                    TextInput(
                      labelTitle: 'Email',
                      hintText: 'Email',
                      obscureText: false,
                      labelIcon: Icons.alternate_email_rounded,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (emailController.text.isEmpty) {
                          return required;
                        } else if (!esFormatoEmailValido(value!)) {
                          return 'Formato de email no válido';
                        } else {
                          email = emailController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // dni
                    TextInput(
                      labelTitle: 'Rut',
                      hintText: 'Rut',
                      obscureText: false,
                      labelIcon: Icons.confirmation_number_outlined,
                      controller: dniController,
                      inputFormat: rutMask,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (dniController.text.isEmpty) {
                          return required;
                        } else {
                          preDni = dniController.text;
                          dni = int.tryParse(
                              preDni!.replaceAll(RegExp(r'[k.-]'), ''));
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // password
                    TextInput(
                      labelTitle: 'Contraseña',
                      hintText: 'Contraseña minimo 6 caracteres',
                      obscureText: true,
                      labelIcon: Icons.lock_outline_rounded,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (passwordController.text.isEmpty) {
                          return required;
                        } else if (passwordController.text.length < 6) {
                          return 'Minimo 6 caracteres';
                        } else {
                          password = passwordController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // repeat password
                    TextInput(
                      labelTitle: 'Repetir Contraseña',
                      hintText: 'Contraseña minimo 6 caracteres',
                      obscureText: true,
                      labelIcon: Icons.lock_outline_rounded,
                      controller: repeatPasswordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (repeatPasswordController.text.isEmpty) {
                          return required;
                        } else if (repeatPasswordController.text.length < 6) {
                          return 'Minimo 6 caracteres';
                        } else {
                          repeatPassword = repeatPasswordController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    // send email button
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Button(
                          buttonText: 'Enviar',
                          onPress: () {
                            if (_recoverPasswordFormState.currentState!
                                .validate()) {
                              recoverPassword();
                            }
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
      ),
    );
  }
}
