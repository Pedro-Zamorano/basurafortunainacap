import 'package:basura_fortuna/infraestructure/models/locations/region.dart';

class Province {
    final int id;
    final String name;
    final Region region;

    Province({
        required this.id,
        required this.name,
        required this.region,
    });

    factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
        region: Region.fromJson(json["region"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region": region.toJson(),
      };

}