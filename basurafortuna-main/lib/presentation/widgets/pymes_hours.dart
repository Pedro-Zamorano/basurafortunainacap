// import 'package:flutter/material.dart';

// class PymesHours extends StatelessWidget {
//   final String hour;
//   const PymesHours({super.key, required this.hour});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Center(
//         child: Text(
//           hour,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PymesHours extends StatefulWidget {
  final String hour;
  final Function(bool) onSelect;
  final bool isSelected;

  const PymesHours(
      {Key? key,
      required this.hour,
      required this.onSelect,
      this.isSelected = false})
      : super(key: key);

  @override
  _PymesHoursState createState() => _PymesHoursState();
}

class _PymesHoursState extends State<PymesHours> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onSelect(_isSelected);
        });
      },
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: _isSelected
              ? Colors.blue
              : Colors.white, // Cambia el color cuando está seleccionado
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            widget.hour,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
