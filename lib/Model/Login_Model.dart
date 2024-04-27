// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  int value;
  String message;
  String username;
  String nama;
  String nobp;
  String nohp;
  String email;
  String alamat;
  String idUser;

  Login({
    required this.value,
    required this.message,
    required this.username,
    required this.nama,
    required this.nobp,
    required this.nohp,
    required this.email,
    required this.alamat,
    required this.idUser,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    value: json["value"],
    message: json["message"],
    username: json["username"],
    nama: json["nama"],
    nobp: json["nobp"],
    nohp: json["nohp"],
    email: json["email"],
    alamat: json["alamat"],
    idUser: json["id_user"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "username": username,
    "nama": nama,
    "nobp": nobp,
    "nohp": nohp,
    "email": email,
    "alamat": alamat,
    "id_user": idUser,
  };
}
