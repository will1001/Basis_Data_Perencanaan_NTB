import 'package:data_perencanaan_ntb/SearchListkategori.dart';
import 'package:data_perencanaan_ntb/model/APIProvider.dart';
import 'package:data_perencanaan_ntb/model/APISource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ShowData.dart';

class DataUrusanWajib extends StatefulWidget {
  DataUrusanWajib(
      {this.title, this.cachedata, this.listtahun, this.listsumberdata});
  final String title;
  final Future<List<Data>> cachedata;
  final List<String> listtahun;
  final List<String> listsumberdata;
  @override
  _DataUrusanWajibState createState() => _DataUrusanWajibState();
}

class _DataUrusanWajibState extends State<DataUrusanWajib>
    with SingleTickerProviderStateMixin {
  var warnabg = Colors.white;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var lstsumberdata;
  var lsttahun;
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(child: Text('1. Pendidikan')),
    Tab(child: Text('2. Kesehatan')),
    Tab(child: Text('3. Pekerjaan Umum dan Penataan Ruang')),
    Tab(child: Text('4. Perumahan dan Kawasan Permukiman')),
    Tab(child: Text('5. Keamanan dan Ketertiban Umum')),
    Tab(child: Text('6. Sosial')),
    Tab(child: Text('7. Tenaga Kerja')),
    Tab(child: Text('8. Pemberdayaan Perempuan dan Perlindungan Anak')),
    Tab(child: Text('9. Pangan')),
    Tab(child: Text('10. Pertanahan')),
    Tab(child: Text('11. Lingkungan Hidup')),
    Tab(child: Text('12. Administrasi Kependudukan dan Pencatatan Sipil')),
    Tab(child: Text('13. Pemberdayaan Masyarakat Desa')),
    Tab(child: Text('14. Pengendalian Penduduk dan Keluarga Berencana')),
    Tab(child: Text('15. Perhubungan')),
    Tab(child: Text('16. Komunikasi dan Informatika')),
    Tab(child: Text('17. Koperasi Usaha Kecil dan Menengah')),
    Tab(child: Text('18. Penanaman Modal')),
    Tab(child: Text('19. Kepemudaan dan Olahraga')),
    Tab(child: Text('20. Kebudayaan')),
    Tab(child: Text('21. Perpustakaan')),
    Tab(child: Text('22. Kearsipan')),
  ];

  var listmenu;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    listmenu = [
      {'index': 0, 'data': 'Pendidikan'},
      {'index': 1, 'data': 'Kesehatan'},
      {'index': 2, 'data': 'Pekerjaan Umum dan Penataan Ruang'},
      {'index': 3, 'data': 'Perumahan dan Kawasan Permukiman'},
      {'index': 4, 'data': 'Keamanan dan Ketertiban Umum'},
      {'index': 5, 'data': 'Sosial'},
      {'index': 6, 'data': 'Tenaga Kerja'},
      {'index': 7, 'data': 'Pemberdayaan Perempuan dan Perlindungan Anak'},
      {'index': 8, 'data': 'Pangan'},
      {'index': 9, 'data': 'Pertanahan'},
      {'index': 10, 'data': 'Lingkungan Hidup'},
      {'index': 11, 'data': 'Administrasi Kependudukan dan Pencatatan Sipil'},
      {'index': 12, 'data': 'Pemberdayaan Masyarakat Desa'},
      {'index': 13, 'data': 'Pengendalian Penduduk dan Keluarga Berencana'},
      {'index': 14, 'data': 'Perhubungan'},
      {'index': 15, 'data': 'Komunikasi dan Informatika'},
      {'index': 16, 'data': 'Koperasi Usaha Kecil dan Menengah'},
      {'index': 17, 'data': 'Penanaman Modal'},
      {'index': 18, 'data': 'Kepemudaan dan Olahraga'},
      {'index': 19, 'data': 'Kebudayaan'},
      {'index': 20, 'data': 'Perpustakaan'},
      {'index': 21, 'data': 'Kearsipan'},
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
      length: 22,
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
                                  _tabController
                                      .animateTo(_tabController.index);
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
                'Data Urusan Wajib',
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
                    child: showdata(
                        "10",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "11",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "12",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "13",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "14",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "15",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "16",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "17",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "18",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "19",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "20",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "21",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "22",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "23",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "24",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "25",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "26",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "27",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "28",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "29",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "30",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata(
                        "31",
                        widget.cachedata,
                        apiprovider.semester,
                        apiprovider.tahun,
                        apiprovider.sumberdata),
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
                  String kategori = (_tabController.index + 10).toString();
                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegateKategori(
                          widget.cachedata, kategori));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
