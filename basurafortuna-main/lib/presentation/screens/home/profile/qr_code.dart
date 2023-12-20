import 'dart:convert';

import 'package:basura_fortuna/core/constant.dart';
import 'package:basura_fortuna/infraestructure/infraestructure.dart';
import 'package:basura_fortuna/presentation/widgets/loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  Color color2 = const Color(0xFF052659);

  @override
  void initState() {
    super.initState();
    getMyProfile();
  }

  bool isLoading = true;
  Profile? myProfile;
  String jsonControllersMap = '';

  static final Logger _logger = Logger();

  // funcion para traer los datos del perfil
  Future<void> getMyProfile() async {
    try {
      final myProfileRequest =
          await Dio().get('$profileUrl?email=$emailForApi');

      if (myProfileRequest.data != null) {
        myProfile = Profile.fromJson(myProfileRequest.data);

        String? username = myProfile?.username;
        String? email = myProfile?.email;
        String? phone = myProfile?.phone.toString();

        print('username $username');
        print('email $email');
        print('phone $phone');

        Map<String, dynamic> generateQR = {
          'username': username,
          'email': email,
          'phone': phone,
        };

        jsonControllersMap = jsonEncode(generateQR);
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

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Muestre este código QR al recolector para registrar su reciclaje',
              style: TextStyle(color: color2, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            isLoading
                ? const LoadingWidget()
                : QrImageView(
                    data: jsonControllersMap,
                    size: 280,
                    embeddedImageStyle: const QrEmbeddedImageStyle(
                      size: Size(
                        100,
                        100,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
