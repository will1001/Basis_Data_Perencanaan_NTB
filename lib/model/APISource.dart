
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<List<Data>> fetchData() async {
  var responseJson;
  String url = "https://bappeda-web.herokuapp.com/api/data";
  final response = await http.get(url,headers: {
    'WDP-NTB-KEY': 'alsodhr74jrhfot97264jgnd85jg7jsofjgur5',
  });
  if (response.statusCode == 200) {
    responseJson = json.decode(response.body);
    responseJson =
        (responseJson['data'] as List).map((p) => Data.fromJson(p)).toList();
  } else {
    responseJson = null;
  }
  // print(response);

  return responseJson;
}

class Data {
  final String id;
  final String idkategori;
  final String namadata;
  final String subket1;
  final String subket2;
  final String subket3;
  final String subket4;
  final String subket5;
  final String subket6;
  final String subket7;
  final String subket8;
  final String subket9;
  final String nilai;
  final String satuan;
  final String semester;
  final String tahun;
  final String createdat;
  final String updatedat;
  final String sumberdata;

  Data({
    this.id,
    this.idkategori,
    this.namadata,
    this.subket1,
    this.subket2,
    this.subket3,
    this.subket4,
    this.subket5,
    this.subket6,
    this.subket7,
    this.subket8,
    this.subket9,
    this.nilai,
    this.satuan,
    this.tahun,
    this.semester,
    this.createdat,
    this.updatedat,
    this.sumberdata,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'].toString(),
      idkategori: json['id_kategori'].toString(),
      namadata: json['nama_data'],
      subket1: json['sub_ket1'],
      subket2: json['sub_ket2'],
      subket3: json['sub_ket3'],
      subket4: json['sub_ket4'],
      subket5: json['sub_ket5'],
      subket6: json['sub_ket6'],
      subket7: json['sub_ket7'],
      subket8: json['sub_ket8'],
      subket9: json['sub_ket9'],
      nilai: json['nilai'].toString(),
      satuan: json['satuan'],
      tahun: json['tahun'],
      semester: json['semester'],
      createdat: json['created_at'],
      updatedat: json['updated_at'],
      sumberdata: json['sumber_data'],
    );
  }
}