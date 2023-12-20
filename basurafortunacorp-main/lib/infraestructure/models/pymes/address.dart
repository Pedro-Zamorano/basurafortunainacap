import 'package:basura_fortuna_corp/infraestructure/infraestructure.dart';

class PymeAddress {
  final String additional;
  final Commune commune;
  final int id;

  PymeAddress({
    required this.additional,
    required this.commune,
    required this.id,
  });

  factory PymeAddress.fromJson(Map<String, dynamic> json) => PymeAddress(
        additional: json['additional'],
        commune: Commune.fromJson(json['commune']),
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'additional': additional,
        'commune': commune.toJson(),
        'id': id,
      };
}
