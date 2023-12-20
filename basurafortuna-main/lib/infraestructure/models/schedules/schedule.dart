import 'package:basura_fortuna/infraestructure/infraestructure.dart';

class Schedule {
  int availableCapacity;
  String created;
  String date;
  String endHour;
  int id;
  bool operative;
  PymesInfo pyme;
  int reservedCapacity;
  String startHour;
  String updated;

  Schedule({
    required this.availableCapacity,
    required this.created,
    required this.date,
    required this.endHour,
    required this.id,
    required this.operative,
    required this.pyme,
    required this.reservedCapacity,
    required this.startHour,
    required this.updated,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      availableCapacity: json['availableCapacity'],
      created: json['created'],
      date: json['date'],
      endHour: json['endHour'],
      id: json['id'],
      operative: json['operative'],
      pyme: PymesInfo.fromJson(json['pyme']),
      reservedCapacity: json['reservedCapacity'],
      startHour: json['startHour'],
      updated: json['updated'],
    );
  }
}
