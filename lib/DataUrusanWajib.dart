import 'package:data_perencanaan_ntb/model/APIProvider.dart';
import 'package:data_perencanaan_ntb/model/APISource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SearchList.dart';
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

class _DataUrusanWajibState extends State<DataUrusanWajib> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
                        items: (widget.listtahun==null?['']:widget.listtahun)
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
                'Data Urusan Wajib',
                style: TextStyle(fontSize: 16.0),
              ),
              bottom: PreferredSize(
                  child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.white.withOpacity(0.3),
                      indicatorColor: Colors.white,
                      tabs: myTabs),
                  preferredSize: Size.fromHeight(30.0)),
            ),
            body: TabBarView(
              children: <Widget>[
                Container(
                  child: Center(
                    child: showdata("10", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("11", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("12", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("13", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("14", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("15", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("16", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("17", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("18", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("19", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("20", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("21", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("22", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("23", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("24", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("25", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("26", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("27", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("28", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("29", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("30", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
                  ),
                ),
                Container(
                  child: Center(
                    child: showdata("31", widget.cachedata,
                        apiprovider.semester, apiprovider.tahun,apiprovider.sumberdata),
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
