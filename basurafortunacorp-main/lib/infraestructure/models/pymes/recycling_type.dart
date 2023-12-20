class RecyclingType {
  final bool active;
  final int id;
  final String typeRecycling;

  RecyclingType({
    required this.active,
    required this.id,
    required this.typeRecycling,
  });

  factory RecyclingType.fromJson(Map<String, dynamic> json) => RecyclingType(
        active: json['active'],
        id: json['id'],
        typeRecycling: json['typeRecycling'],
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'id': id,
        'typeRecycling': typeRecycling,
      };
}