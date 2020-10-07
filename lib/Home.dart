import 'package:data_perencanaan_ntb/DataRealisasiPembangunanProvinsiNTB.dart';
import 'package:data_perencanaan_ntb/DataRencanaPembangunanProvinsiNTB.dart';
import 'package:data_perencanaan_ntb/Kontak.dart';
import 'package:flutter/material.dart';

import 'DataPokok.dart';
import 'DataUrusanPilihan.dart';
import 'DataUrusanWajib.dart';
import 'SearchData.dart';
import 'ViewChart.dart';

class Home extends StatefulWidget {
  Home({this.title});
  final String title;
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
      // appBar: AppBar(
      //   leading: Opacity(opacity: 0.0, child: Icon(Icons.ac_unit)),
      //   centerTitle: true,
      //   title: Text(
      //     widget.title,
      //     style: TextStyle(fontSize: 16.0),
      //   ),
      // ),
      body: Center(
          child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.folder_open,
                    size: 65.0,
                    color: Colors.blue,
                  ),
                  title: Text('Data Umum'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => DataPokok()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:0.0,right: 20,left:20,bottom: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.folder_open,
                    size: 65.0,
                    color: Colors.blue,
                  ),
                  title: Text('Data Urusan Pilihan'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => DataUrusanPilihan()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:0.0,right: 20,left:20,bottom: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.folder_open,
                    size: 65.0,
                    color: Colors.blue,
                  ),
                  title: Text('Data Urusan Wajib'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => DataUrusanWajib()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:0.0,right: 20,left:20,bottom: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.folder_open,
                    size: 65.0,
                    color: Colors.blue,
                  ),
                  title: Text('Data Urusan Pilihan'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => DataUrusanPilihan()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:0.0,right: 20,left:20,bottom: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.folder_open,
                    size: 65.0,
                    color: Colors.blue,
                  ),
                  title: Text('Data Realisasi Pembangunan Provinsi NTB'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => DataRealisasiPembangunanProvinsiNTB()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:0.0,right: 20,left:20,bottom: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.folder_open,
                    size: 65.0,
                    color: Colors.blue,
                  ),
                  title: Text('Data Rencana Pembangunan Provinsi NTB'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => DataRencanaPembangunanProvinsiNTB()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:0.0,right: 20,left:20,bottom: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    size: 65.0,
                    color: Colors.blue,
                  ),
                  title: Text('Search Data'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => SearchData(kategori: '')));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:0.0,right: 20,left:20,bottom: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    size: 65.0,
                    color: Colors.blue,
                  ),
                  title: Text('Kontak'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => Kontak()));
                  },
                ),
              ),
            ),
          ),
         
        ],
      )),
    );
  }
}
