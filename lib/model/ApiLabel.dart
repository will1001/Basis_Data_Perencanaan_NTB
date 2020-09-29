import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<List<BeritaAPI>> fetchBeritaAPI(String dataLimit) async {
  var responseJson;
  String url = "https://web-bappeda.herokuapp.com/api/Datas?limit=" + dataLimit;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    responseJson = json.decode(response.body);
    responseJson =
        (responseJson as List).map((p) => BeritaAPI.fromJson(p)).toList();
  } else {
    responseJson = null;
  }

  return responseJson;
}

class BeritaAPI {
  final String id;
  final String nama_data;
  final String nilai;
  final String satuan;
  final String tahun;
  final String nama_sumber;
  final String kab_kota;

  

  BeritaAPI({
    this.id,
    this.nama_data,
    this.nilai,
    this.satuan,
    this.tahun,
    this.nama_sumber,
    this.kab_kota,
  });

  factory BeritaAPI.fromJson(Map<String, dynamic> json) {
    return BeritaAPI(
      id: json['id'],
      nama_data: json['nama_data'],
      nilai: json['nilai'],
      satuan: json['satuan'],
      tahun: json['tahun'],
      nama_sumber: json['nama_sumber'],
      kab_kota: json['nama'],
    );
  }
}