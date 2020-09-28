import 'package:data_perencanaan_ntb/SearchListkategori.dart';
import 'package:data_perencanaan_ntb/model/APIProvider.dart';
import 'package:data_perencanaan_ntb/model/APISource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ShowData.dart';

class DataUrusanPilihan extends StatefulWidget {
  DataUrusanPilihan(
      {this.title, this.cachedata, this.listtahun, this.listsumberdata});
  final String title;
  final Future<List<Data>> cachedata;
  final List<String> listtahun;
  final List<String> listsumberdata;

  @override
  _DataUrusanPilihanState createState() => _DataUrusanPilihanState();
}

class _DataUrusanPilihanState extends State<DataUrusanPilihan>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var lstsumberdata;
  var lsttahun;
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(child: Text('1. Kelautan dan Perikanan')),
    Tab(child: Text('2. Pariwisata')),
    Tab(child: Text('3. Pertanian')),
    Tab(child: Text('4. Kehutanan')),
    Tab(child: Text('5. Energi dan SumberDaya Mineral')),
    Tab(child: Text('6. Perdagangan')),
    Tab(child: Text('7. Perindustrian')),
    Tab(child: Text('8. Transmigrasi'))
  ];

  var listmenu;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    listmenu = [
      {'index': 0, 'data': 'Kelautan dan Perikanan'},
      {'index': 1, 'data': 'Pariwisata'},
      {'index': 2, 'data': 'Pertanian'},
      {'index': 3, 'data': 'Kehutanan'},
      {'index': 4, 'data': 'Energi dan SumberDaya Mineral'},
      {'index': 5, 'data': 'Perdagangan'},
      {'index': 6, 'data': 'Perindustrian'},
      {'index': 7, 'data': 'Transmigrasi'},
    ];
    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: ChangeNotifierProvider<APIProvider>(
        builder: (context) => APIProvider(),
        child: Consumer<APIProvider>(
          builder: (context, apiprovider, _) => Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: DrawerHeader(
                      child: Center(
                          child: Text('Menu',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 23.0))),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Column(
                    children: listmenu
                        .map((f) {
                          return Column(
                        children: <Widget>[
                          ListTile(
                          title: Text(f['data']),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            _tabController.index = f['index'];
                            _tabController.animateTo(_tabController.index);
                            Navigator.of(context).pop();
                          },
                        ),
                        Container(
                          color: Colors.black12,
                          height: 1,
                        )
                        ],
                      );
                        })
                        .cast<Widget>()
                        .toList(),
                  ),
                ],
              ),
            ),
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
                            items: (lsttahun == null ? [''] : lsttahun)
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
                Opacity(
                  opacity: 0,
                )
              ],
              leading: Opacity(
                opacity: 0,
              ),
              centerTitle: true,
              title: Text(
                'Data Urusan Pilihan',
                style: TextStyle(fontSize: 16.0),
              ),
              bottom: PreferredSize(
                  child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.white.withOpacity(1),
                      indicatorColor: Colors.white,
                      controller: _tabController,
                      tabs: myTabs),
                  preferredSize: Size.fromHeight(30.0)),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  child: Center(
                    child: showdata("2", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun, apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("3", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun, apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("4", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun, apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("5", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun, apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("6", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun, apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("7", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun, apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("8", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun, apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("9", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun, apiprovider.sumberdata),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  title: Text('Menu'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.filter_list),
                  title: Text('Filter'),
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
                  _scaffoldKey.currentState.openDrawer();
                } else if (value == 1) {
                  _scaffoldKey.currentState.openEndDrawer();
                } else if (value == 2) {
                    String kategori =  (_tabController.index+2).toString();

                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegateKategori(widget.cachedata,kategori));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
