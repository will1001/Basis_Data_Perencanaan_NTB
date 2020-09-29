import 'package:data_perencanaan_ntb/DataRealisasiPembangunanProvinsiNTB.dart';
import 'package:data_perencanaan_ntb/DataRencanaPembangunanProvinsiNTB.dart';
import 'package:data_perencanaan_ntb/Kontak.dart';
import 'package:flutter/material.dart';

import 'DataPokok.dart';
import 'DataUrusanPilihan.dart';
import 'DataUrusanWajib.dart';
import 'SearchList.dart';





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
        //  FutureBuilder<List<Data>>(
        //     future:
        //        ,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         lsttahun = snapshot.data
        //             .map((d) => d.tahun.toString().substring(0, 4))
        //             .toSet()
        //             .toList();
        //         lsttahun.add(DateTime.now().toString().substring(0, 4));
        //         lsttahun = lsttahun.toSet().toList();
        //         lstsumberdata = snapshot.data
        //             .map((d) => d.sumberdata.toString())
        //             .toSet()
        //             .toList();


        //       }
        //       return Container();
        //     },
        //   ),
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
                title: Text('Data Umum'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => DataPokok()));
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
                      MaterialPageRoute(builder: (c) => DataUrusanPilihan()));
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
                      MaterialPageRoute(builder: (c) => DataUrusanWajib()));
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
                      MaterialPageRoute(builder: (c) => DataRealisasiPembangunanProvinsiNTB()));
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
                      MaterialPageRoute(builder: (c) => DataRencanaPembangunanProvinsiNTB()));
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
                  Icons.search,
                  size: 65.0,
                  color: Colors.blue,
                ),
                title: Text('Search Data'),
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate());
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
                  Icons.contacts,
                  size: 65.0,
                  color: Colors.blue,
                ),
                title: Text('Kontak'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => Kontak()));
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
