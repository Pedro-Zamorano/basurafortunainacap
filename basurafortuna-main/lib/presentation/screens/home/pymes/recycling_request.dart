import 'package:basura_fortuna/core/constant.dart';
import 'package:basura_fortuna/core/dialogs.dart';
import 'package:basura_fortuna/infraestructure/infraestructure.dart';
import 'package:basura_fortuna/presentation/screens/screens.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:basura_fortuna/presentation/widgets/widgets.dart';
import 'package:logger/logger.dart';

class RecyclingRequest extends StatefulWidget {
  final int pymeId;

  const RecyclingRequest({super.key, required this.pymeId});

  @override
  State<RecyclingRequest> createState() => _RecyclingRequestState();
}

class _RecyclingRequestState extends State<RecyclingRequest> {
  @override
  void initState() {
    super.initState();
    getUserId();
    getSchedules();
  }

  bool isLoading = true;
  bool _isSelected = false;
  Schedule? schedule;
  int? userId;
  final GlobalKey<FormState> _requestFormState = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController estimatedWeightController =
      TextEditingController();
  static final Logger _logger = Logger();
  String required = '* Campo requerido';

  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  Color color3 = const Color(0xFF5483B3);
  Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);

  String? description;
  int? estimatedWeight;
  int? type;

  // recycling request
  // todo: Guardar la solicitud en BD
  Future<void> requestRecycling() async {
    if (schedule?.pyme.recyclingType.typeRecycling == 'PLASTICO') {
      type = 0;
    } else if (schedule?.pyme.recyclingType.typeRecycling == 'PAPEL_CARTON') {
      type = 1;
    } else if (schedule?.pyme.recyclingType.typeRecycling == 'VIDRIO') {
      type = 2;
    }else if (schedule?.pyme.recyclingType.typeRecycling == 'RESIDUOS_ELECTRONICOS_ELECTRICOS') {
      type = 3;
    }else if (schedule?.pyme.recyclingType.typeRecycling == 'RESIDUOS_PELIGROSOS') {
      type = 4;
    }else if (schedule?.pyme.recyclingType.typeRecycling == 'MATERIA_ORGANICA') {
      type = 5;
    }

    Map<String, dynamic>? newRecycling = {
      'description': description,
      'estimated_weight': estimatedWeight,
      'schedule_fk': schedule?.id,
      'state': 0,
      'type': type,
      'user_fk': userId,
    };

    try {
      await Dio().post(recyclingRequestUrl, data: newRecycling);
      // ignore: use_build_context_synchronously
      DialogExito(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      DialogError(context);
      _logger.e(e.toString());
    }
  }

  // get schedules
  Future<void> getSchedules() async {
    try {
      final scheduleRequest =
          await Dio().get('$pymeSchedules?id=${widget.pymeId}');

      if (scheduleRequest.statusCode == 200) {
        schedule = Schedule.fromJson(scheduleRequest.data);

        print('--> schedule data: $schedule');
      }
    } catch (e) {
      _logger.e(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  // Obteniendo el ID del usuario
  Future<void> getUserId() async {
    try {
      final userIdRequest = await Dio().get('$profileUrl?email=$emailForApi');

      if (userIdRequest.statusCode == 200) {
        Profile userData = Profile.fromJson(userIdRequest.data);
        userId = userData.id;
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_bf.png',
          width: 170,
          height: 130,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.01, 0.99],
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: color5,
          ),
        ),
      ),
      body: AppBackground(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        widget: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _requestFormState,
                child: Column(
                  children: [
                    // description
                    TextInput(
                      labelTitle: 'Descripción',
                      hintText: 'Indique que solicita retirar',
                      obscureText: false,
                      labelIcon: Icons.recycling,
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (descriptionController.text.isEmpty) {
                          return required;
                        } else {
                          description = descriptionController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // estimated weight
                    TextInput(
                      labelTitle: 'Peso estimado',
                      hintText: 'Indique un peso estimado',
                      obscureText: false,
                      labelIcon: Icons.balance,
                      controller: estimatedWeightController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (estimatedWeightController.text.isEmpty) {
                          return required;
                        } else {
                          estimatedWeight =
                              int.parse(estimatedWeightController.text);
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // title
                    Text(
                      'Horas Disponibles',
                      style: TextStyle(
                        color: color5,
                        fontSize: 32,
                        fontFamily: 'Assistant',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // hours
                    isLoading
                        ? const LoadingWidget()
                        : Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              // TODO: al seleccionar una hora, que las otras se deshabiliten
                              // y cuando presione el boton, me pregunte si quiero confirmar la seleccion
                              // todo: rango de horas
                              // hour list
                              PymesHours(
                                hour: "${schedule?.startHour}",
                                isSelected: _isSelected,
                                onSelect: (selected) {
                                  setState(() {
                                    _isSelected = selected;
                                  });
                                },
                              ),
                              PymesHours(
                                hour: "${schedule?.endHour}",
                                isSelected: _isSelected,
                                onSelect: (selected) {
                                  setState(() {
                                    _isSelected = selected;
                                  });
                                },
                              ),
                            ],
                          ),

                    const SizedBox(height: 20),

                    // button
                    Button(
                      buttonText: 'Reservar',
                      onPress: () {
                        if (_requestFormState.currentState!.validate()) {
                          requestRecycling();
                        }
                      },
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

//==== EXITO
void DialogExito(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF052659),
        title: Text(
          'Éxito',
          style: TextStyle(
            color: color5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text('Solicitud exitosa.'),
        contentTextStyle: TextStyle(
          color: color5,
          fontSize: 18,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: color3),
              child: const Text(
                'Aceptar',
                style: TextStyle(
                  color: Color(0xFF021024),
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

//==== ERROR DEL CATCH
void DialogError(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF052659),
        title: const Text(
          'Falla en solicitud',
          style: TextStyle(
            color: Color(0xFFC1E8FF),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text('No fue posible procesar la solicitud.'),
        contentTextStyle: const TextStyle(
          color: Color(0xFFC1E8FF),
          fontSize: 18,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              child: const Text(
                'Volver',
                style: TextStyle(
                  color: Color(0xFFC1E8FF),
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
