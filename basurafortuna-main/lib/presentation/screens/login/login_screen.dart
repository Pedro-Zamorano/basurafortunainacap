import 'package:basura_fortuna/core/constant.dart';
import 'package:basura_fortuna/core/dialogs.dart';
import 'package:basura_fortuna/core/validations/email_validation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:basura_fortuna/presentation/screens/screens.dart';
import 'package:basura_fortuna/presentation/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // getCurrenPosition();
  }

// obteniendo la ubicacion del dispositivo
  Future<Position> getPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrenPosition() async {
    Position position = await getPosition();
    print('Latitud: ${position.latitude}');
    print('Longitud: ${position.longitude}');
  }

  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  Color color3 = const Color(0xFF5483B3);
  Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);
  String required = '* Campo requerido';

  final GlobalKey<FormState> _loginFormState = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  static final Logger _logger = Logger();

  Future<void> signIn() async {
    Map<String, dynamic>? authData = {
      'email': email,
      'password': password,
    };

    try {
      final authResponse = await Dio().post(userSiginUrl, data: authData);

      if (authResponse.statusCode == 200) {
        emailForApi = emailController.text;
        ToAppScreen();
      } else {
        // ignore: use_build_context_synchronously
        DialogUserNotFound(context);
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      DialogUserNotFound(context);
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
    return Scaffold(
      body: BackgroundColor(
        widget: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _loginFormState,
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // icono y titulo
                    Icon(
                      Icons.account_circle_sharp,
                      color: color5,
                      size: 150,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        color: color5,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Assistant',
                      ),
                    ),
                    const SizedBox(height: 15),

                    // input email
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

                    // input password
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
                        } else if (passwordController.text.length > 8) {
                          return 'Maximo 8 caracteres';
                        } else {
                          password = passwordController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 10),

                    // recuperar contraseña
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => toRecoveryPassword(),
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: color5,
                              fontFamily: 'Assistant',
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // iniciar sesion
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Button(
                          onPress: () {
                            if (_loginFormState.currentState!.validate()) {
                              signIn();
                            }
                          },
                          buttonText: 'Iniciar sesión',
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // nuevo registro
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Eres nuevo?, ',
                          style: TextStyle(
                            fontFamily: 'Assistant',
                            color: color4,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        // nuevo registro boton
                        GestureDetector(
                          onTap: () => toRegister(),
                          child: Text(
                            'Registrate!',
                            style: TextStyle(
                              fontFamily: 'Assistant',
                              color: color5,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // login con Google
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: color1.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          // 'assets/images/google.png',
                          'assets/images/logo_two.png',
                          width: 400,
                          height: 200,
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

  toRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  toRecoveryPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RecoverPasswordScreen(),
      ),
    );
  }

  ToAppScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
