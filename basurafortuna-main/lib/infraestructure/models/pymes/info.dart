import 'package:basura_fortuna/infraestructure/infraestructure.dart';

class PymesInfo {
  final int dni;
  final String email;
  final int id;
  final String name;
  final String password;
  final int phone;
  final PymeAddress pymeAddress;
  final RecyclingType recyclingType;

  PymesInfo({
    required this.dni,
    required this.email,
    required this.id,
    required this.name,
    required this.password,
    required this.phone,
    required this.pymeAddress,
    required this.recyclingType,
  });

  factory PymesInfo.fromJson(Map<String, dynamic> json) => PymesInfo(
        dni: json['dni'],
        email: json['email'],
        id: json['id'],
        name: json['name'],
        password: json['password'],
        phone: json['phone'],
        pymeAddress: PymeAddress.fromJson(json['pymeAddress']),
        recyclingType: RecyclingType.fromJson(json['recyclingType']),
      );

  Map<String, dynamic> toJson() => {
        'dni': dni,
        'email': email,
        'id': id,
        'name': name,
        'password': password,
        'phone': phone,
        'pymeAddress': pymeAddress.toJson(),
        'recyclingType': recyclingType.toJson(),
      };
}
