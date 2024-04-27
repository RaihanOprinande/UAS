// To parse this JSON data, do
//
//     final berita = beritaFromJson(jsonString);

import 'dart:convert';

Berita beritaFromJson(String str) => Berita.fromJson(json.decode(str));

String beritaToJson(Berita data) => json.encode(data.toJson());

class Berita {
  bool isSuccess;
  String message;
  List<Datum> data;

  Berita({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Berita.fromJson(Map<String, dynamic> json) => Berita(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String idBerita;
  String judul;
  String konten;
  String gambar;
  String author;
  DateTime created;
  dynamic updated;

  Datum({
    required this.idBerita,
    required this.judul,
    required this.konten,
    required this.gambar,
    required this.author,
    required this.created,
    required this.updated,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idBerita: json["id_berita"],
    judul: json["judul"],
    konten: json["konten"],
    gambar: json["gambar"],
    author: json["author"],
    created: DateTime.parse(json["created"]),
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "id_berita": idBerita,
    "judul": judul,
    "konten": konten,
    "gambar": gambar,
    "author": author,
    "created": created.toIso8601String(),
    "updated": updated,
  };
}
