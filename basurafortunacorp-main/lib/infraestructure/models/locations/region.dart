class Region {
    final int id;
    final String regionName;
    final int code;

    Region({
        required this.id,
        required this.regionName,
        required this.code,
    });

    factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        regionName: json["regionName"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "regionName": regionName,
        "code": code,
      };

}
