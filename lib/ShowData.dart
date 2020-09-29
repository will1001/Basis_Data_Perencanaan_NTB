import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'dart:async';
// import 'model/APIProvider.dart';
// import 'model/APISource.dart';
import 'model/ApiKeterangan.dart';

Widget showdata(String kategori, List _listData) {
  int nmr = 0;
  var HeadTable = [
    "No",
    "Keterangan",
    "Nilai",
    "Satuan",
    "Semester",
    "Tahun",
    "Sumber Data",
    "Kabupaten/Kota",
  ];

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        dataRowHeight: 120,
        columns: HeadTable.map((e) {
          return DataColumn(
            label: Text(
              e,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          );
        }).toList(),
        rows: _listData.map((e) {
          nmr++;
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(nmr.toString())),
              DataCell(
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    FutureBuilder<List<KeteranganAPI>>(
                        future: fetchKeterangan(e['id']),
                        builder: (context, snapshot2) {
                          if (snapshot2.hasData) {
                            return Wrap(
                              direction: Axis.vertical,
                              children: snapshot2.data.map((f) {
                                return Text(f.nama);
                              }).toList(),
                            );
                          } else {
                            return Container();
                          }
                        }),
                    Text(
                      e['nama_data'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              DataCell(Text(e['nilai'])),
              DataCell(Text(e['satuan'])),
              DataCell(Text(semesterConverter(e['tahun'].substring(0, 4)))),
              DataCell(Text(e['tahun'].substring(0, 4))),
              DataCell(Text(zeroReplacer(e['nama_sumber']))),
              DataCell(Text(nullChecker(e['nama']))),
            ],
          );
        }).toList(),
      ),
    ),
  );
}

// TODO: Fungsi utk rubah format nilai
String nullChecker(String nilai) {
  if (nilai == null) {
    return "";
  } else {
    return nilai;
  }
}

String zeroReplacer(String nilai) {
  if (nilai == "0") {
    return "";
  } else {
    return nilai;
  }
}

String semesterConverter(String tahun) {
  if (int.parse(tahun) % 2 == 0) {
    return "Genap";
  } else {
    return "Ganjil";
  }
}

// class InfosList extends StatelessWidget {
//   // final List<Data> datas;

//   InfosList({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<APIProvider>(
//       builder: (context) => APIProvider(),
//       child: Consumer<APIProvider>(
//         builder: (context, apiprovider, _) => Row(
//           children: <Widget>[
//             Expanded(
//               child: SizedBox(
//                   height: MediaQuery.of(context).size.height,
//                   child: ListView.separated(
//                     separatorBuilder: (BuildContext context, int index) =>
//                         Divider(),
//                     itemCount: (datas.length == 0 ? 1 : datas.length),
//                     itemBuilder: (BuildContext context, int i) {
//                       if (datas.length == 0) {
//                         return Column(
//                           children: <Widget>[
//                             Padding(
//                                 padding: EdgeInsets.all(8),
//                                 child: Text(
//                                   'Belum Ada Data',
//                                   style: TextStyle(fontSize: 21),
//                                 ))
//                           ],
//                         );
//                       }
//                       apiprovider.expansiontilecolor == Colors.white
//                           ? apiprovider.expansiontilecolor = Colors.grey[300]
//                           : apiprovider.expansiontilecolor = Colors.white;
//                       return Container(
//                         color: apiprovider.expansiontilecolor,
//                         child: ExpansionTile(
//                             title: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 datas[i].subket1 == null
//                                     ? Container()
//                                     : Text(
//                                         datas[i].subket1,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ),
//                                 datas[i].subket2 == null
//                                     ? Container()
//                                     : Text(
//                                         datas[i].subket2,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ),
//                                 datas[i].subket3 == null
//                                     ? Container()
//                                     : Text(
//                                         datas[i].subket3,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ),
//                                 datas[i].subket4 == null
//                                     ? Container()
//                                     : Text(
//                                         datas[i].subket4,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ),
//                                 datas[i].subket5 == null
//                                     ? Container()
//                                     : Text(
//                                         datas[i].subket5,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ),
//                                 datas[i].subket6 == null
//                                     ? Container()
//                                     : Text(
//                                         datas[i].subket6,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ),
//                                 Text(
//                                   datas[i].namadata,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w900,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             children: <Widget>[
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: <Widget>[
//                                   datas[i].nilai == null
//                                       ? Container()
//                                       : ListTile(
//                                           leading: Text('Nilai :'),
//                                           title: Text(
//                                               setFormatNilai(datas[i].nilai)),
//                                         ),
//                                   datas[i].satuan == null
//                                       ? ListTile(
//                                           leading: Text('Satuan :'),
//                                           title: Text(''),
//                                         )
//                                       : ListTile(
//                                           leading: Text('Satuan :'),
//                                           title: Text(datas[i].satuan),
//                                         ),
//                                   datas[i].tahun == null
//                                       ? ListTile(
//                                           leading: Text('Tahun :'),
//                                           title: Text(''),
//                                         )
//                                       : ListTile(
//                                           leading: Text('Tahun :'),
//                                           title: Text(
//                                               datas[i].tahun.substring(0, 4)),
//                                         ),
//                                   datas[i].sumberdata == null
//                                       ? ListTile(
//                                           leading: Text('Sumber Data :'),
//                                           title: Text(''),
//                                         )
//                                       : ListTile(
//                                           leading: Text('Sumber Data :'),
//                                           title: Text(datas[i].sumberdata),
//                                         ),
//                                   datas[i].semester == null
//                                       ? ListTile(
//                                           leading: Text('Semester :'),
//                                           title: Text(''),
//                                         )
//                                       : ListTile(
//                                           leading: Text('Semester :'),
//                                           title: Text(datas[i].semester),
//                                         ),
//                                 ],
//                               ),
//                             ]),
//                       );
//                     },
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }

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
// }
