import 'package:data_perencanaan_ntb/DataRealisasiPembangunanProvinsiNTB.dart';
import 'package:data_perencanaan_ntb/DataRencanaPembangunanProvinsiNTB.dart';
import 'package:data_perencanaan_ntb/model/APISource.dart';
import 'package:flutter/material.dart';

import 'DataPokok.dart';
import 'DataUrusanPilihan.dart';
import 'DataUrusanWajib.dart';





class Home extends StatefulWidget {
  Home({this.title,this.cachedata});
  final String title;
  final Future<List<Data>> cachedata;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
   
  }
  var lsttahun;
  var lstsumberdata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Opacity(opacity: 0.0, child: Icon(Icons.ac_unit)),
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      body: Center(
          child: ListView(
        children: <Widget>[
         FutureBuilder<List<Data>>(
            future:
               widget.cachedata,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                lsttahun = snapshot.data
                    .map((d) => d.tahun.toString().substring(0, 4))
                    .toSet()
                    .toList();
                lsttahun.add(DateTime.now().toString().substring(0, 4));
                lsttahun = lsttahun.toSet().toList();
                lstsumberdata = snapshot.data
                    .map((d) => d.sumberdata.toString())
                    .toSet()
                    .toList();


              }
              return Container();
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.blue, width: 1.0),
              left: BorderSide(color: Colors.blue, width: 1.0),
              right: BorderSide(color: Colors.blue, width: 1.0),
              bottom: BorderSide(color: Colors.blue, width: 1.0),
            )),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListTile(
                leading: Icon(
                  Icons.archive,
                  size: 65.0,
                  color: Colors.blue,
                ),
                title: Text('Data Pokok'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => DataPokok(cachedata:widget.cachedata,listtahun: lsttahun,listsumberdata: lstsumberdata,)));
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(color: Colors.blue, width: 1.0),
              right: BorderSide(color: Colors.blue, width: 1.0),
              bottom: BorderSide(color: Colors.blue, width: 1.0),
            )),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListTile(
                leading: Icon(
                  Icons.archive,
                  size: 65.0,
                  color: Colors.blue,
                ),
                title: Text('Data Urusan Pilihan'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => DataUrusanPilihan(cachedata:widget.cachedata,listtahun: lsttahun,listsumberdata: lstsumberdata,)));
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(color: Colors.blue, width: 1.0),
              right: BorderSide(color: Colors.blue, width: 1.0),
              bottom: BorderSide(color: Colors.blue, width: 1.0),
            )),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListTile(
                leading: Icon(
                  Icons.archive,
                  size: 65.0,
                  color: Colors.blue,
                ),
                title: Text('Data Urusan Wajib'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => DataUrusanWajib(cachedata:widget.cachedata,listtahun: lsttahun,listsumberdata: lstsumberdata,)));
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(color: Colors.blue, width: 1.0),
              right: BorderSide(color: Colors.blue, width: 1.0),
              bottom: BorderSide(color: Colors.blue, width: 1.0),
            )),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListTile(
                leading: Icon(
                  Icons.archive,
                  size: 65.0,
                  color: Colors.blue,
                ),
                title: Text('Data Realisasi Pembangunan Provinsi NTB'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => DataRealisasiPembangunanProvinsiNTB(cachedata:widget.cachedata,listtahun: lsttahun,listsumberdata: lstsumberdata,)));
                },
              ),
            ),
          ),
         Container(
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(color: Colors.blue, width: 1.0),
              right: BorderSide(color: Colors.blue, width: 1.0),
              bottom: BorderSide(color: Colors.blue, width: 1.0),
            )),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListTile(
                leading: Icon(
                  Icons.archive,
                  size: 65.0,
                  color: Colors.blue,
                ),
                title: Text('Data Rencana Pembangunan Provinsi NTB'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => DataRencanaPembangunanProvinsiNTB(cachedata:widget.cachedata,listtahun: lsttahun,listsumberdata: lstsumberdata,)));
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
