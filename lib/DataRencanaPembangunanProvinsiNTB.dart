import 'package:data_perencanaan_ntb/SearchListkategori.dart';
import 'package:data_perencanaan_ntb/ShowData.dart';
import 'package:data_perencanaan_ntb/model/APIProvider.dart';
import 'package:data_perencanaan_ntb/model/APISource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class DataRencanaPembangunanProvinsiNTB extends StatefulWidget {
  DataRencanaPembangunanProvinsiNTB({this.title, this.cachedata,this.listtahun,this.listsumberdata});
  final String title;
  final Future<List<Data>> cachedata;
  final List<String> listtahun;
  final List<String> listsumberdata;
  @override
  _DataRencanaPembangunanProvinsiNTBState createState() => _DataRencanaPembangunanProvinsiNTBState();
}

class _DataRencanaPembangunanProvinsiNTBState extends State<DataRencanaPembangunanProvinsiNTB> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var lstsumberdata;
  var lsttahun;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<APIProvider>(
      builder: (context) => APIProvider(),
      child: Consumer<APIProvider>(
        builder: (context, apiprovider, _) => Scaffold(
          key: _scaffoldKey,
          endDrawer: Drawer(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 100.0,
                  child: DrawerHeader(
                    child: Center(
                        child: Text('Filter Data',
                            style: TextStyle(
                                color: Colors.white, fontSize: 23.0))),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),
                FutureBuilder<List<Data>>(
                  future: widget.cachedata,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      lsttahun = snapshot.data
                          .map((d) => d.tahun.toString().substring(0, 4))
                          .toSet()
                          .toList();
                      lsttahun = lsttahun.toSet().toList();
                      lsttahun.remove('null');
                      lsttahun.sort();
                    }
                    return Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 55.0),
                          child: Text('Tahun :'),
                        ),
                        DropdownButton<String>(
                          value: apiprovider.tahun,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String newValue) {
                            apiprovider.tahun = newValue.toString();
                          },
                          items: (lsttahun == null
                                  ? ['']
                                  : lsttahun)
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 15.0),
                  child: Text('Sumber Data :'),
                ),
                FutureBuilder<List<Data>>(
                  future: widget.cachedata,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      lstsumberdata = snapshot.data
                          .map((d) => d.sumberdata.toString())
                          .toSet()
                          .toList();

                      lstsumberdata.remove('null');
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: apiprovider.sumberdata,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          apiprovider.sumberdata = newValue.toString();
                        },
                        items: (lstsumberdata == null ? [''] : lstsumberdata)
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 32.0),
                      child: Text('Semester :'),
                    ),
                    Text('1'),
                    Radio(
                      value: 1,
                      groupValue: apiprovider.semester,
                      onChanged: (int value) {
                        apiprovider.semester = value;
                      },
                    ),
                    Text('2'),
                    Radio(
                      value: 2,
                      groupValue: apiprovider.semester,
                      onChanged: (int value) {
                        apiprovider.semester = value;
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(31.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlatButton.icon(
                        color: Colors.blue,
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ), //`Icon` to display
                        label: Text(
                          'Terapkan',
                          style: TextStyle(color: Colors.white),
                        ), //`Text` to display
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:11.0),
                        child: FlatButton.icon(
                          color: Colors.blue,
                          icon: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ), //`Icon` to display
                          label: Text(
                            'Reset',
                            style: TextStyle(color: Colors.white),
                          ), //`Text` to display
                          onPressed: () {
                            apiprovider.tahun = null;
                            apiprovider.sumberdata = null;
                            apiprovider.semester = null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
           actions: <Widget>[
             Opacity(opacity: 0,)
           ],
            centerTitle: true,
            title: Text(
              'Data Rencana Pembangunan',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          body: showdata("33", widget.cachedata,apiprovider.semester,apiprovider.tahun,apiprovider.sumberdata),
          bottomNavigationBar:BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.filter_list),
                    title: Text('Filter'),
                  ),
                  BottomNavigationBarItem(
                    icon: Opacity(opacity: 0, child: Icon(Icons.business)),
                    title: Opacity(opacity: 0, child: Text('Business')),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    title: Text('Search'),
                  ),
                ],
                currentIndex: 1,
                selectedItemColor: Colors.blueGrey,
                onTap: (int value) {
                  if (value == 0) {
                    _scaffoldKey.currentState.openEndDrawer();
                  } else if (value == 2) {
                    showSearch(
                        context: context,
                        delegate: CustomSearchDelegateKategori(widget.cachedata,'33'));
                  }
                },
              ),
            
        ),
      ),
    );
  }
}