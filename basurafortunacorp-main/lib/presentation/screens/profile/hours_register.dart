import 'package:basura_fortuna_corp/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

class HoursRegister extends StatefulWidget {
  const HoursRegister({super.key});

  @override
  State<HoursRegister> createState() => _HoursRegisterState();
}

class _HoursRegisterState extends State<HoursRegister> {
  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  Color color3 = const Color(0xFF5483B3);
  Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);

  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 09, minute: 00),
    const TimeOfDay(hour: 10, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Rango de Horas',
            style: TextStyle(
              fontFamily: 'Assistant',
              color: color2,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 20),

          // hour range
          TimeRange(
            fromTitle: Text(
              'DESDE',
              style: TextStyle(
                fontSize: 14,
                color: color2,
                fontWeight: FontWeight.w600,
              ),
            ),
            toTitle: Text(
              'HASTA',
              style: TextStyle(
                fontSize: 14,
                color: color2,
                fontWeight: FontWeight.w600,
              ),
            ),
            textStyle: TextStyle(
              fontWeight: FontWeight.normal,
              color: color2,
            ),
            activeTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: color5,
            ),
            borderColor: color2,
            activeBorderColor: color2,
            backgroundColor: Colors.transparent,
            activeBackgroundColor: color1,
            firstTime: const TimeOfDay(hour: 9, minute: 00),
            lastTime: const TimeOfDay(hour: 18, minute: 00),
            initialRange: _timeRange,
            timeStep: 30,
            timeBlock: 30,
            onRangeCompleted: (range) => setState(() => _timeRange = range),
            onFirstTimeSelected: (startHour) {},
          ),
          const SizedBox(height: 30),

          // default button
          if (_timeRange != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Rango seleccionado: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
                  style: TextStyle(fontSize: 18, color: color2),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: SizedBox(
                    width: double.infinity,
                    child: Button(
                      backgroundColor: color4,
                      textColor: color1,
                      buttonText: 'Por defecto',
                      onPress: () {
                        setState(() => _timeRange = _defaultTimeRange);
                      },
                    ),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 20),

          // register button
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              width: double.infinity,
              child: Button(
                buttonText: 'Registrar',
                onPress: () {},
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Para registrar sus horas seleccionadas, \npresione en "Registrar"',
            style: TextStyle(fontSize: 12, color: color5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
