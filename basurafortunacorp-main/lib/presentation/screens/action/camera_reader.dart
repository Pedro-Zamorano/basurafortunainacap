import 'dart:developer';
import 'dart:io';

import 'package:basura_fortuna_corp/presentation/screens/screens.dart';
import 'package:basura_fortuna_corp/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraReader extends StatefulWidget {
  const CameraReader({super.key});

  @override
  State<CameraReader> createState() => _CameraReaderState();
}

class _CameraReaderState extends State<CameraReader> {
  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  // Color color3 = const Color(0xFF5483B3);
  // Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          widget: Column(
            children: [
              // camera
              Expanded(
                flex: 4,
                child: _buildQrView(context),
              ),

              // options screen
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 10),
                      result != null
                          ? Button(
                              onPress: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecyclingForm(
                                      data: '${result!.code}',
                                    ),
                                  ),
                                );
                              },
                              buttonText: 'Redireccionar',
                            )
                          : const Text('Escanea un código'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: color2,
                              ),
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  if (snapshot.data == true) {
                                    return Text(
                                      'Flash: Encendido',
                                      style: TextStyle(color: color5),
                                    );
                                  } else {
                                    return Text(
                                      'Flash: Apagado',
                                      style: TextStyle(color: color5),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: Button(
                              buttonText: 'pausar',
                              onPress: () async {
                                await controller?.pauseCamera();
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: Button(
                              buttonText: 'reanudar',
                              onPress: () async {
                                await controller?.resumeCamera();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('no Permission'),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
