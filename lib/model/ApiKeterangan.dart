import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<KeteranganAPI>> fetchKeterangan(String id) async {
  var responseJson;
  String url = "https://bappeda-web.herokuapp.com/api/Keterangan?id_data=" + id;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    responseJson = json.decode(response.body);
    responseJson =
        (responseJson as List).map((p) => KeteranganAPI.fromJson(p)).toList();
  } else {
    responseJson = null;
  }

  return responseJson;
}

class KeteranganAPI {
  final String nama;

  KeteranganAPI({
    this.nama,
  });

  factory KeteranganAPI.fromJson(Map<String, dynamic> json) {
    return KeteranganAPI(
      nama: json['nama'],
    );
  }
}
