// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  int value;
  String username;
  String email;
  String nama;
  String nobp;
  String nohp;
  String alamat;
  String message;

  Register({
    required this.value,
    required this.username,
    required this.email,
    required this.nama,
    required this.nobp,
    required this.nohp,
    required this.alamat,
    required this.message,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    value: json["value"],
    username: json["username"],
    email: json["email"],
    nama: json["nama"],
    nobp: json["nobp"],
    nohp: json["nohp"],
    alamat: json["alamat"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "username": username,
    "email": email,
    "nama": nama,
    "nobp": nobp,
    "nohp": nohp,
    "alamat": alamat,
    "message": message,
  };
}
