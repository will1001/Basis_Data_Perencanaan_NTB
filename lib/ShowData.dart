import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'LegendWithMeasures.dart';
import 'ViewChart.dart';
import 'model/ApiKeterangan.dart';

Widget showdata(String kategori, List _listData,var context) {
  int nmr = 0;
  var HeadTable = [
    "No",
    "Grafik",
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
        columnSpacing: 25,
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
              DataCell(IconButton(icon: Icon(Icons.insert_chart), onPressed: (){
                Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => ViewChart(kategori,e['nama_data'],e['id'])));
              })),
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
              DataCell(Text(setFormatNilai(e['nilai']))),
              DataCell(Text(e['satuan'])),
              DataCell(Text(semesterConverter(e['tahun'].substring(6, 7)))),
              DataCell(Text(e['tahun'].substring(0, 4))),
              DataCell(Wrap(
                direction: Axis.vertical,
                children: [
                  Container(width: 200,child: Text(zeroReplacer(e['nama_sumber']))),
                ],
              )),
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

String semesterConverter(String bulan) {
  if (int.parse(bulan) > 6) {
    return "Genap";
  } else {
    return "Ganjil";
  }
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


// }
