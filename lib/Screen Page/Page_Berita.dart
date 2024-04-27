import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas/Screen%20Page/Detail_Berita.dart';

import '../Model/Berita_Model.dart';
import '../Utils/Session_Manager.dart';
import 'Login.dart';

class PageBerita extends StatefulWidget {
  const PageBerita({super.key});

  @override
  State<PageBerita> createState() => _PageBeritaState();
}

class _PageBeritaState extends State<PageBerita> {
  String? userName;
  String? id;

  Future getDataSession() async {
    await Future.delayed(const Duration(seconds: 1), () {
      session.getSession().then((value) {
        print('data sesi .. ' + value.toString());
        userName = session.userName;
        id = session.idUser;
      });
    });
  }

  void initState() {
    super.initState();
    session.getSession();
    getDataSession();
  }

  //method untuk get berita
  Future<List<Datum>?> getBerita() async {
    try {
      http.Response response = await http
          .get(Uri.parse("http://192.168.43.109/uts_mobile/berita.php"));
      return beritaFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  List<Datum>? filterDevice;
  List<Datum>? listDevice;
  TextEditingController cari = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edukasi List'),
        backgroundColor: Colors.green,
        actions: [
          TextButton(onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => PageUser()
            //     )
            // );
          },
              child: Text('HI ${userName}')),
          //logout
          IconButton(
            onPressed: () {
              //clear session
              setState(() {
                session.clearSession();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
              });
            },
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: cari,
            onChanged: (value) {
              setState(() {
                filterDevice = listDevice
                    ?.where((element) =>
                element.judul!
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                    element.konten!
                        .toLowerCase()
                        .contains(value.toLowerCase()) ||
                    element.author!
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                    element.gambar!
                        .toLowerCase()
                        .contains(value.toLowerCase()) ||
                    element.created!
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase())

                )

                    .toList();
              });
            },
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.8),
          ),
          Expanded(
            child: FutureBuilder(
              future: getBerita(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  listDevice = snapshot.data;
                  if (filterDevice == null) {
                    filterDevice = listDevice;
                  }
                  return ListView.builder(
                      itemCount: filterDevice!.length,
                      itemBuilder: (context, index) {
                        Datum? data = filterDevice?[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              //   //ini untuk ke detail
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetailBerita(data: data,)));
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'http://192.168.43.109/uts_mobile/image/${data?.gambar}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "${data?.judul}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                          fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      "${data?.konten}",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

