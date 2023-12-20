import 'package:basura_fortuna/infraestructure/models/locations/province.dart';

class Commune {
    final int id;
    final String name;
    final Province? province;

    Commune({
        required this.id,
        required this.name,
        this.province,
    });

    factory Commune.fromJson(Map<String, dynamic> json) => Commune(
        id: json["id"],
        name: json["name"],
        province: Province.fromJson(json["province"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "province": province?.toJson(),
      };

}