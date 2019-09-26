import 'package:data_perencanaan_ntb/model/APIProvider.dart';
import 'package:data_perencanaan_ntb/model/APISource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SearchList.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
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
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 55.0),
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
                        items:(widget.listtahun==null?['']:widget.listtahun)
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 15.0),
                  child: Text('Sumber Data :'),
                ),
                Padding(
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
                    items: (widget.listsumberdata == null
                            ? ['']
                            : widget.listsumberdata)
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
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
                ],
              ),
            ),
            appBar: AppBar(
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
                      unselectedLabelColor: Colors.white.withOpacity(0.3),
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
                        apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("3", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("4", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("5", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("6", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("7", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("8", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("9", widget.cachedata, apiprovider.semester,
                        apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
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
                print(value);
                if (value == 0) {
                  _scaffoldKey.currentState.openDrawer();
                } else if (value == 2) {
                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(widget.cachedata));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
