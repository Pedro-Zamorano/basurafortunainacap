import 'package:basura_fortuna/infraestructure/models/locations/commune.dart';

class UserAddress {
  final String additional;
  final Commune commune;

  UserAddress({
    required this.additional,
    required this.commune,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        additional: json['additional'],
        commune: Commune.fromJson(json['commune']),
      );

  Map<String, dynamic> toJson() => {
        'additional': additional,
        'commune': commune.toJson(),
      };
}

class Profile {
  final int id;
  final String created;
  final String updated;
  final String username;
  final String name;
  final String lastname;
  final int dni;
  final String email;
  final int phone;
  final String password;
  final UserAddress userAddress;

  Profile({
    required this.id,
    required this.created,
    required this.updated,
    required this.username,
    required this.name,
    required this.lastname,
    required this.dni,
    required this.email,
    required this.phone,
    required this.password,
    required this.userAddress,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'],
        created: json['created'],
        updated: json['updated'],
        username: json['username'],
        name: json['name'],
        lastname: json['lastname'],
        dni: json['dni'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        userAddress: UserAddress.fromJson(json['userAddress']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created': created,
        'updated': updated,
        'username': username,
        'name': name,
        'lastname': lastname,
        'dni': dni,
        'email': email,
        'phone': phone,
        'password': password,
        'userAddress': userAddress.toJson(),
      };
}
