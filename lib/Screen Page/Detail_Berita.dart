import 'package:flutter/material.dart';

import '../Model/Berita_Model.dart';

class DetailBerita extends StatelessWidget {
  final Datum? data;
  const DetailBerita({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Edukasi"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4, right:
            4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "http://192.168.43.109/uts_mobile/image/${data?.gambar}",
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.judul ?? "",
              style: const TextStyle(fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            trailing: const Icon(
              Icons.star,
              color: Colors.red,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, bottom: 16,
                left: 16),
            child: Text(
              data?.konten ?? "",
              style: const TextStyle(fontSize: 14, fontWeight:
              FontWeight.w400),
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            data?.created.toString() ?? "" ,
            style: const TextStyle(fontSize: 14, fontWeight:
            FontWeight.w400),
            textAlign: TextAlign.right,
          ),
          Text(
            data?.author ?? "",
            style: const TextStyle(fontSize: 14, fontWeight:
            FontWeight.bold),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }
}
