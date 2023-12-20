class RecyclingRequestItem {
  String created;
  String description;
  int estimatedWeight;
  int id;
  RecyclingSchedule schedule;
  String state;
  String type;
  User user;
  String updated;

  RecyclingRequestItem({
    required this.created,
    required this.description,
    required this.estimatedWeight,
    required this.id,
    required this.schedule,
    required this.state,
    required this.type,
    required this.user,
    required this.updated,
  });

  factory RecyclingRequestItem.fromJson(Map<String, dynamic> json) {
    return RecyclingRequestItem(
      created: json['created'],
      description: json['description'],
      estimatedWeight: json['estimatedWeight'],
      id: json['id'],
      schedule: RecyclingSchedule.fromJson(json['schedule']),
      state: json['state'],
      type: json['type'],
      user: User.fromJson(json['user']),
      updated: json['updated'],
    );
  }
}

class RecyclingSchedule {
  int availableCapacity;
  String created;
  String date;
  String endHour;
  int id;
  bool operative;
  Pyme pyme;
  int reservedCapacity;
  String startHour;
  String updated;

  RecyclingSchedule({
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

  factory RecyclingSchedule.fromJson(Map<String, dynamic> json) {
    return RecyclingSchedule(
      availableCapacity: json['availableCapacity'],
      created: json['created'],
      date: json['date'],
      endHour: json['endHour'],
      id: json['id'],
      operative: json['operative'],
      pyme: Pyme.fromJson(json['pyme']),
      reservedCapacity: json['reservedCapacity'],
      startHour: json['startHour'],
      updated: json['updated'],
    );
  }
}

class Pyme {
  String created;
  int dni;
  String email;
  int id;
  String name;
  String password;
  int phone;
  PymeAddress pymeAddress;
  RecyclingType recyclingType;
  String updated;

  Pyme({
    required this.created,
    required this.dni,
    required this.email,
    required this.id,
    required this.name,
    required this.password,
    required this.phone,
    required this.pymeAddress,
    required this.recyclingType,
    required this.updated,
  });

  factory Pyme.fromJson(Map<String, dynamic> json) {
    return Pyme(
      created: json['created'],
      dni: json['dni'],
      email: json['email'],
      id: json['id'],
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      pymeAddress: PymeAddress.fromJson(json['pymeAddress']),
      recyclingType: RecyclingType.fromJson(json['recyclingType']),
      updated: json['updated'],
    );
  }
}

class PymeAddress {
  String additional;
  Commune commune;
  String created;
  int id;
  String updated;

  PymeAddress({
    required this.additional,
    required this.commune,
    required this.created,
    required this.id,
    required this.updated,
  });

  factory PymeAddress.fromJson(Map<String, dynamic> json) {
    return PymeAddress(
      additional: json['additional'],
      commune: Commune.fromJson(json['commune']),
      created: json['created'],
      id: json['id'],
      updated: json['updated'],
    );
  }
}

class Commune {
  String created;
  int id;
  String name;
  Province province;
  String updated;

  Commune({
    required this.created,
    required this.id,
    required this.name,
    required this.province,
    required this.updated,
  });

  factory Commune.fromJson(Map<String, dynamic> json) {
    return Commune(
      created: json['created'],
      id: json['id'],
      name: json['name'],
      province: Province.fromJson(json['province']),
      updated: json['updated'],
    );
  }
}

class Province {
  String created;
  int id;
  String name;
  Region region;
  String updated;

  Province({
    required this.created,
    required this.id,
    required this.name,
    required this.region,
    required this.updated,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      created: json['created'],
      id: json['id'],
      name: json['name'],
      region: Region.fromJson(json['region']),
      updated: json['updated'],
    );
  }
}

class Region {
  int code;
  String created;
  int id;
  String regionName;
  String updated;

  Region({
    required this.code,
    required this.created,
    required this.id,
    required this.regionName,
    required this.updated,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      code: json['code'],
      created: json['created'],
      id: json['id'],
      regionName: json['regionName'],
      updated: json['updated'],
    );
  }
}

class RecyclingType {
  bool active;
  String created;
  int id;
  String typeRecycling;
  String updated;

  RecyclingType({
    required this.active,
    required this.created,
    required this.id,
    required this.typeRecycling,
    required this.updated,
  });

  factory RecyclingType.fromJson(Map<String, dynamic> json) {
    return RecyclingType(
      active: json['active'],
      created: json['created'],
      id: json['id'],
      typeRecycling: json['typeRecycling'],
      updated: json['updated'],
    );
  }
}

class User {
  String created;
  int dni;
  String email;
  int id;
  String lastname;
  String name;
  String password;
  int phone;
  String updated;
  UserAddress userAddress;
  String username;

  User({
    required this.created,
    required this.dni,
    required this.email,
    required this.id,
    required this.lastname,
    required this.name,
    required this.password,
    required this.phone,
    required this.updated,
    required this.userAddress,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      created: json['created'],
      dni: json['dni'],
      email: json['email'],
      id: json['id'],
      lastname: json['lastname'],
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      updated: json['updated'],
      userAddress: UserAddress.fromJson(json['userAddress']),
      username: json['username'],
    );
  }
}

class UserAddress {
  String additional;
  Commune commune;
  String created;
  int id;
  String updated;

  UserAddress({
    required this.additional,
    required this.commune,
    required this.created,
    required this.id,
    required this.updated,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      additional: json['additional'],
      commune: Commune.fromJson(json['commune']),
      created: json['created'],
      id: json['id'],
      updated: json['updated'],
    );
  }
}
