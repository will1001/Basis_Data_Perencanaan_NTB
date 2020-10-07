import 'package:flutter/material.dart';
import 'LegendWithMeasures.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/ApiKeterangan.dart';

// import 'SelectionChart.dart';

class ViewChart extends StatefulWidget {
  final String kategori;
  final String namaData;
  final String idData;

  ViewChart(this.kategori, this.namaData, this.idData);
  @override
  _ViewChartState createState() => _ViewChartState();
}

class _ViewChartState extends State<ViewChart> {
  bool _isLoading = true;
  List _listData = new List();
  // List _listData2 = new List();
  // List _listData2 = ["2015","2016","2017","2018"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch(widget.kategori, widget.namaData);
    print(_listData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //       shadowColor: Colors.white,
      //       elevation: 0,
      //       toolbarHeight: 30,
      //       iconTheme: IconThemeData(
      //         color: Colors.black, //change your color here
      //       ),
      // ),
      body: _listData.length == 0
          ? Center(child: CircularProgressIndicator())
          :
          // : ListView(
          //     scrollDirection: Axis.vertical,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 10.0),
          //         child: Row(
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(right:30.0),
          //               child: IconButton(
          //                   icon: Icon(Icons.arrow_back),
          //                   onPressed: () {
          //                     Navigator.pop(context);
          //                   }),
          //             ),
          //             Center(
          //                 child: Wrap(
          //               direction: Axis.vertical,
          //               children: [
          //                 FutureBuilder<List<KeteranganAPI>>(
          //                     future: fetchKeterangan(widget.idData),
          //                     builder: (context, snapshot2) {
          //                       if (snapshot2.hasData) {
          //                         return Wrap(
          //                           direction: Axis.vertical,
          //                           children: snapshot2.data.map((f) {
          //                             return Text(f.nama);
          //                           }).toList(),
          //                         );
          //                       } else {
          //                         return Container();
          //                       }
          //                     }),
          //                 Text(
          //                   widget.namaData,
          //                   style: TextStyle(fontWeight: FontWeight.bold),
          //                 ),
          //               ],
          //             )),
          //           ],
          //         ),
          //       ),
          //       SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Expanded(
          //           child: Padding(
          //           padding: const EdgeInsets.only(left: 8.0, top: 10),
          //             child: SizedBox(
          //               width: MediaQuery.of(context).size.width + 40,
          //               height: MediaQuery.of(context).size.height - 150,
          //               // child: Text(_listData.toString()),
          //               child: LegendWithMeasures(
          //                 _createSampleData(_listData),
          //                 // Disable animations for image tests.
          //                 animate: false,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          ListView(
            children: [
              Row(
                children: [
                   Padding(
                        padding: const EdgeInsets.only(right:30.0),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                  Center(
                          child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          FutureBuilder<List<KeteranganAPI>>(
                              future: fetchKeterangan(widget.idData),
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
                            widget.namaData,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 570,
                  child: 
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 570,
                        child: LegendWithMeasures(
                                        _createSampleData(_listData),
                                        // Disable animations for image tests.
                                        animate: false,
                                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData(
      List _listData) {
    var dataSemeterGanjil = [
      _listData.length == 0
          ? new OrdinalSales('', 0)
          : new OrdinalSales(_listData[0]['tahun'].toString().substring(0, 4),
              double.parse(_listData[0]['nilai'])),
    ];

    final dataSemeterGenap = [
      _listData.length == 1
          ? new OrdinalSales('', 0)
          : new OrdinalSales(_listData[1]['tahun'].toString().substring(0, 4),
              double.parse(_listData[1]['nilai'])),
    ];

    for (var i = 2; i < _listData.length; i++) {
      if (i % 2 == 0) {
        dataSemeterGanjil.add(new OrdinalSales(
            _listData[i]['tahun'].toString().substring(0, 4),
            double.parse(_listData[i]['nilai'])));
      } else {
        dataSemeterGenap.add(new OrdinalSales(
            _listData[i]['tahun'].toString().substring(0, 4),
            double.parse(_listData[i]['nilai'])));
      }
    }

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Semester 1',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: dataSemeterGanjil,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Semester 2',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: dataSemeterGenap,
      ),
    ];
  }

  fetch(String id_kategori, String keyword) async {
    final response = await http.get(
        "https://bappeda-web.herokuapp.com/api/Datas?limit=0" +
            "&id_kategori=" +
            id_kategori +
            "&cari=" +
            nullReplacer(keyword));
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _listData.clear();
          _listData.addAll(json.decode(response.body));
          _isLoading = false;
        });
      }
    } else {
      throw Exception('failed load data');
    }
  }

  nullReplacer(var val) {
    val = val == null ? '' : val;
    return val;
  }

  checkGanjil(var val) {
    if (int.parse(val['tahun'].toString(6, 7)) < 7) {
      return new OrdinalSales(val['tahun'], val['nilai']);
    }
  }

  checkGenap(var val) {
    if (int.parse(val['tahun'].toString(6, 7)) > 6) {
      return new OrdinalSales(val['tahun'], val['nilai']);
    }
  }
}
