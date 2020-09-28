import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'model/APIProvider.dart';
import 'model/APISource.dart';

Widget showdata(String kategori, Future<List<Data>> cachedata, int semester,
    String tahun, String sumberdata) {
  return ChangeNotifierProvider<APIProvider>(
    builder: (context) => APIProvider(),
    child: Consumer<APIProvider>(
      builder: (context, apiprovider, _) => ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Center(
              child: FutureBuilder<List<Data>>(
                future: cachedata,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data;
                    if (tahun != null &&
                        semester == null &&
                        sumberdata == null) {
                      data = snapshot.data
                          .where((a) => a.tahun.substring(0, 4) == tahun)
                          .toList();
                      data =
                          data.where((a) => a.idkategori == kategori).toList();
                    } else if (tahun == null &&
                        semester != null &&
                        sumberdata == null) {
                      var semestertemp = semester == 1 ? "Ganjil" : "Genap";
                      data = snapshot.data
                          .where((a) => a.idkategori == kategori)
                          .toList();
                      data = data
                          .where((a) => a.semester == semestertemp)
                          .toList();
                    } else if (tahun == null &&
                        semester == null &&
                        sumberdata != null) {
                      data = snapshot.data
                          .where((a) => a.idkategori == kategori)
                          .toList();
                      data = data
                          .where((a) => a.sumberdata == sumberdata)
                          .toList();
                    } else if (tahun != null &&
                        semester != null &&
                        sumberdata == null) {
                      var semestertemp = semester == 1 ? "Ganjil" : "Genap";
                      data = snapshot.data
                          .where((a) => a.idkategori == kategori)
                          .toList();
                      data = data
                          .where((a) => a.tahun.substring(0, 4) == tahun)
                          .toList();
                      data = data
                          .where((a) => a.semester == semestertemp)
                          .toList();
                    } else if (tahun != null &&
                        semester == null &&
                        sumberdata != null) {
                      data = snapshot.data
                          .where((a) => a.tahun.substring(0, 4) == tahun)
                          .toList();
                      data =
                          data.where((a) => a.idkategori == kategori).toList();
                      data = data
                          .where((a) => a.sumberdata == sumberdata)
                          .toList();
                    } else if (tahun == null &&
                        semester != null &&
                        sumberdata != null) {
                      var semestertemp = semester == 1 ? "Ganjil" : "Genap";
                      data = snapshot.data
                          .where((a) => a.sumberdata == sumberdata)
                          .toList();
                      data =
                          data.where((a) => a.idkategori == kategori).toList();
                      data = data
                          .where((a) => a.semester == semestertemp)
                          .toList();
                    } else if (tahun != null &&
                        semester != null &&
                        sumberdata != null) {
                      var semestertemp = semester == 1 ? "Ganjil" : "Genap";
                      data = snapshot.data
                          .where((a) => a.tahun.substring(0, 4) == tahun)
                          .toList();
                      data =
                          data.where((a) => a.idkategori == kategori).toList();
                      data = data
                          .where((a) => a.semester == semestertemp)
                          .toList();
                      data = data
                          .where((a) => a.sumberdata == sumberdata)
                          .toList();
                    } else {
                      data = snapshot.data
                          .where((a) => a.idkategori == kategori)
                          .toList();
                    }
                    return InfosList(datas: data);
                  } else if (!snapshot.hasData) {
                    Future.delayed(Duration(seconds: 3), () {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: SizedBox(
                              height: 250.0,
                              width: 250.0,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Mohon Cek koneksi internet Anda",
                              style: TextStyle(
                                  fontSize: 23.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      );
                    });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: SizedBox(
                          height: 250.0,
                          width: 250.0,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          LinearProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Loading Data',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class InfosList extends StatelessWidget {
  final List<Data> datas;

  InfosList({Key key, this.datas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<APIProvider>(
      builder: (context) => APIProvider(),
      child: Consumer<APIProvider>(
        builder: (context, apiprovider, _) => Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: (datas.length == 0 ? 1 : datas.length),
                    itemBuilder: (BuildContext context, int i) {
                      if (datas.length == 0) {
                        return Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Belum Ada Data',style: TextStyle(fontSize: 21),))
                          ],
                        );
                      }
                      apiprovider.expansiontilecolor == Colors.white
                          ? apiprovider.expansiontilecolor = Colors.grey[300]
                          : apiprovider.expansiontilecolor = Colors.white;
                      return Container(
                        color: apiprovider.expansiontilecolor,
                        child: ExpansionTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                datas[i].subket1 == null
                                    ? Container()
                                    : Text(
                                        datas[i].subket1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                datas[i].subket2 == null
                                    ? Container()
                                    : Text(
                                        datas[i].subket2,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                datas[i].subket3 == null
                                    ? Container()
                                    : Text(
                                        datas[i].subket3,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                datas[i].subket4 == null
                                    ? Container()
                                    : Text(
                                        datas[i].subket4,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                datas[i].subket5 == null
                                    ? Container()
                                    : Text(
                                        datas[i].subket5,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                datas[i].subket6 == null
                                    ? Container()
                                    : Text(
                                        datas[i].subket6,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                Text(
                                  datas[i].namadata,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  datas[i].nilai == null
                                      ? Container()
                                      : ListTile(
                                          leading: Text('Nilai :'),
                                          title: Text(
                                              setFormatNilai(datas[i].nilai)),
                                        ),
                                  datas[i].satuan == null
                                      ? ListTile(
                                          leading: Text('Satuan :'),
                                          title: Text(''),
                                        )
                                      : ListTile(
                                          leading: Text('Satuan :'),
                                          title: Text(datas[i].satuan),
                                        ),
                                  datas[i].tahun == null
                                      ? ListTile(
                                          leading: Text('Tahun :'),
                                          title: Text(''),
                                        )
                                      : ListTile(
                                          leading: Text('Tahun :'),
                                          title: Text(
                                              datas[i].tahun.substring(0, 4)),
                                        ),
                                  datas[i].sumberdata == null
                                      ? ListTile(
                                          leading: Text('Sumber Data :'),
                                          title: Text(''),
                                        )
                                      : ListTile(
                                          leading: Text('Sumber Data :'),
                                          title: Text(datas[i].sumberdata),
                                        ),
                                  datas[i].semester == null
                                      ? ListTile(
                                          leading: Text('Semester :'),
                                          title: Text(''),
                                        )
                                      : ListTile(
                                          leading: Text('Semester :'),
                                          title: Text(datas[i].semester),
                                        ),
                                ],
                              ),
                            ]),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

// TODO: Fungsi utk rubah format nilai
  String setFormatNilai(String nilai) {
    int hit = 0;
    var newnilai = [];
    var splitnilai = nilai.split('.');
    var reversednilai = splitnilai[0].split('').reversed.toList();
    for (int i = 0; i < splitnilai[0].split('').length; i++) {
      if (hit < 3) {
        newnilai.add(reversednilai[i]);
      } else {
        newnilai.add('.');
        newnilai.add(reversednilai[i]);
        hit = 0;
      }
      hit++;
    }
    if (splitnilai.length > 1) {
      newnilai.insert(0, ',' + splitnilai[1]);
    }
    return newnilai.reversed.join();
  }
}
