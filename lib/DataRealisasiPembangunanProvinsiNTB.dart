import 'package:data_perencanaan_ntb/SearchListkategori.dart';
import 'package:data_perencanaan_ntb/ShowData.dart';
import 'package:data_perencanaan_ntb/model/APIProvider.dart';
import 'package:data_perencanaan_ntb/model/APISource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'SearchData.dart';

class DataRealisasiPembangunanProvinsiNTB extends StatefulWidget {
  DataRealisasiPembangunanProvinsiNTB(
      {this.title, this.cachedata, this.listtahun, this.listsumberdata});
  final String title;
  final Future<List<Data>> cachedata;
  final List<String> listtahun;
  final List<String> listsumberdata;
  @override
  _DataRealisasiPembangunanProvinsiNTBState createState() =>
      _DataRealisasiPembangunanProvinsiNTBState();
}

class _DataRealisasiPembangunanProvinsiNTBState
    extends State<DataRealisasiPembangunanProvinsiNTB> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _sumber_data;
  String _tahun;
  int _semester;
  bool _isLoading = true;
  bool _dataIsEmpty = false;
  int _pageData = 0;
  var dataCache;
  List _listData = new List();
  List lstsumberdata = new List();
  List lsttahun = new List();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch("32", _pageData.toString(), null, null, null);
    fetchListTahun("32");
    fetchListSumberData("32");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _pageData += 10;
          _isLoading = true;
        });
        fetch("32", _pageData.toString(), _tahun, _sumber_data, _semester);
      }
    });
  }

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
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 55.0),
                      child: Text('Tahun :'),
                    ),
                    DropdownButton<String>(
                      value: _tahun,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _tahun = newValue;
                        });
                      },
                      items: (lsttahun == null ? [''] : lsttahun)
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value['YEAR(`tahun`)'],
                          child: Text(value['YEAR(`tahun`)']),
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
                    value: _sumber_data,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        _sumber_data = newValue;
                      });
                    },
                    items: (lstsumberdata == null ? [''] : lstsumberdata)
                        .map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value['id'],
                        child: Text(value['nama_sumber']),
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
                      groupValue: _semester,
                      onChanged: (int value) {
                        setState(() {
                          _semester = value;
                        });
                      },
                    ),
                    Text('2'),
                    Radio(
                      value: 2,
                      groupValue: _semester,
                      onChanged: (int value) {
                        setState(() {
                          _semester = value;
                        });
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
                          setState(() {
                            _listData.clear();
                            _isLoading = true;
                          });
                          fetch("32", 0.toString(), _tahun, _sumber_data,
                              _semester);
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 11.0),
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
                            setState(() {
                              _tahun = null;
                              _sumber_data = null;
                              _semester = null;
                            });
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
            centerTitle: true,
            title: Text(
              'Data Realisasi Pembangunan',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          body: ListView.builder(
              controller: _scrollController,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    _dataIsEmpty
                        ? Text("Data Kosong / Belum Di Inputkan")
                        : showdata("32", _listData),
                    _isLoading
                        ? _dataIsEmpty
                            ? Container()
                            : Center(child: CircularProgressIndicator())
                        : Container()
                  ],
                );
              }),
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
                _scaffoldKey.currentState.openEndDrawer();
              } else if (value == 2) {
                // showSearch(
                //     context: context,
                //     delegate:
                //         CustomSearchDelegateKategori(widget.cachedata, '32'));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) => SearchData(kategori: '32')));
              }
            },
          ),
        ),
      ),
    );
  }

  fetch(String id_kategori, String limit, String tahun, String sumber_data,
      int semester) async {
    final response = await http.get(
        "https://web-bappeda.herokuapp.com/api/Datas?limit=" +
            limit +
            "&id_kategori=" +
            id_kategori +
            "&tahun=" +
            nullReplacer(tahun) +
            "&sumber_data=" +
            nullReplacer(sumber_data) +
            "&semester=" +
            nullReplacer(semester).toString());
    if (response.statusCode == 200) {
      if (mounted) {
        var responseLength = json.decode(response.body).length;
        if (responseLength != 0) {
          if (mounted) {
            setState(() {
              _listData.addAll(json.decode(response.body));
              _isLoading = false;
            });
          }
        } else {
          setState(() {
          _dataIsEmpty = true;
        });
        }
      }
    } else {
      throw Exception('failed load data');
    }
  }

//data tahun filter
  fetchListTahun(String id_kategori) async {
    final response = await http.get(
        "https://web-bappeda.herokuapp.com/api/Datas?id_kategori=" +
            id_kategori +
            "&get_group_parameter=tahun");
    if (response.statusCode == 200) {
      print("oii");
      var responseLength = json.decode(response.body).length;
      if (responseLength != 0) {
        if (mounted) {
          setState(() {
            lsttahun.addAll(json.decode(response.body));
            _isLoading = false;
          });
        }
      }
    } else {
      throw Exception('failed load data');
    }
  }

  // data sumber_data filter
  fetchListSumberData(String id_kategori) async {
    final response = await http.get(
        "https://web-bappeda.herokuapp.com/api/Datas?id_kategori=" +
            id_kategori +
            "&get_group_parameter=sumber_data");
    if (response.statusCode == 200) {
      var responseLength = json.decode(response.body).length;
      if (responseLength != 0) {
        if (mounted) {
          setState(() {
            lstsumberdata.addAll(json.decode(response.body));
            if (lstsumberdata[0]['nama_sumber'] == '0') {
              lstsumberdata.removeAt(0);
            } else {
              return '';
            }
            _isLoading = false;
          });
        }
      }
    } else {
      throw Exception('failed load data');
    }
  }

  nullReplacer(var val) {
    val = val == null ? '' : val;
    return val;
  }
}
