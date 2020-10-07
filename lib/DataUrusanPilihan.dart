import 'package:data_perencanaan_ntb/SearchListkategori.dart';
import 'package:data_perencanaan_ntb/model/APIProvider.dart';
import 'package:data_perencanaan_ntb/model/APISource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'SearchData.dart';
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
  String _sumber_data;
  String _tahun;
  String _tahun_file;
  String _tahun_terbaru;
  String _fileName;
  int _semester;
  bool _isLoading = true;
  bool _isLoadingFile = true;
  bool _apicall = true;
  bool _dataIsEmpty = false;
  bool _fileIsEmpty = false;
  int _pageData = 0;
  int _kategori = 2;
  var dataCache;
  List _listData = new List();
  List _listDataFile = new List();
  List lstsumberdata = new List();
  List lsttahun = new List();
  List lsttahunFile = new List();
  ScrollController _scrollController = new ScrollController();

  var listmenu;

  @override
  void initState() {
    super.initState();

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

    if (_apicall) {
      fetch(_kategori.toString(), 0.toString(), null, null, null);
      fetchKategori(_kategori.toString());
      fetchfile(_kategori.toString(), "");
      fetchListTahunFile(_kategori.toString());
      fetchListTahun(_kategori.toString());
      fetchListSumberData(_kategori.toString());
      _apicall = false;
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _pageData += 10;
          _isLoading = true;
        });
        fetch(_kategori.toString(), _pageData.toString(), _tahun, _sumber_data,
            _semester);
      }
    });
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Center(
                    child: SizedBox(
                  width: 204.0,
                  height: 352.0,
                  child: FadeInImage(
                    fadeInDuration: const Duration(seconds: 1),
                    placeholder:
                        AssetImage('assets/images/Bappeda-Logo-300x95.png'),
                    image: AssetImage('assets/images/Bappeda-Logo-300x95.png'),
                  ),
                )),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 3.0, color: Colors.blue),
                  ),
                  color: Colors.white,
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
                            setState(() {
                              _listData.clear();
                              lstsumberdata.clear();
                              lsttahun.clear();
                              lsttahunFile.clear();
                              _tahun = null;
                              _tahun_terbaru = null;
                              _sumber_data = null;
                              _semester = null;
                              _kategori = f['index'] + 2;
                              _apicall = true;
                              _isLoading = true;
                              _dataIsEmpty = false;
                              _fileIsEmpty = false;
                            });

                            fetchListTahun(_kategori.toString());
                            fetchListTahunFile(_kategori.toString());
                            fetchKategori(_kategori.toString());
                            fetchfile(_kategori.toString(),"");
                            fetchListSumberData(_kategori.toString());
                            fetch(_kategori.toString(), 0.toString(), null,
                                null, null);
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
                    child: SizedBox(
                  width: 204.0,
                  height: 352.0,
                  child: FadeInImage(
                    fadeInDuration: const Duration(seconds: 1),
                    placeholder:
                        AssetImage('assets/images/Bappeda-Logo-300x95.png'),
                    image: AssetImage('assets/images/Bappeda-Logo-300x95.png'),
                  ),
                )),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 3.0, color: Colors.blue),
                  ),
                  color: Colors.white,
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
                  icon: Icon(Icons.keyboard_arrow_down),
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
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                itemHeight: 80,
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
                      fetch(_kategori.toString(), 0.toString(), _tahun,
                          _sumber_data, _semester);
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
        backgroundColor: Colors.transparent,
        shadowColor: Colors.white,
        elevation: 0,
        toolbarHeight: 50,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
          )
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Column(
          children: [
            // Text(
            //   'Data Urusan Pilihan',
            //   style: TextStyle(fontSize: 16.0),
            // ),
            Text(
              listmenu[_kategori - 2]['data'],
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
        // bottom: PreferredSize(
        //     child: TabBar(
        //         isScrollable: true,
        //         unselectedLabelColor: Colors.white.withOpacity(1),
        //         indicatorColor: Colors.white,
        //         controller: _tabController,
        //         tabs: myTabs),
        //     preferredSize: Size.fromHeight(30.0)),
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                _dataIsEmpty
                    ? Text("Data Kosong / Belum Di Inputkan")
                    : showdata(_kategori.toString(), _listData, context),
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
            // String kategori = (_tabController.index + 2).toString();

            //   showSearch(
            //       context: context,
            //       delegate: CustomSearchDelegateKategori(
            //           widget.cachedata, kategori));
            Navigator.of(context).push(MaterialPageRoute(
                builder: (c) => SearchData(kategori: _kategori.toString())));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your onPressed code here!

          if (_isLoadingFile && !_fileIsEmpty) {
            print("please wait");
          } else {
            fileCheckPopup();
          }
        },
        child: Text(
          "PDF",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[400],
      ),
    );
  }

  fetch(String id_kategori, String limit, String tahun, String sumber_data,
      int semester) async {
    final response = await http.get(
        "https://bappeda-web.herokuapp.com/api/Datas?limit=" +
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
      var responseLength = json.decode(response.body).length;
      if (responseLength != 0) {
        // print(json.decode(response.body).toString());
        if (mounted) {
          setState(() {
            _listData.addAll(json.decode(response.body));
            _isLoading = false;
            _dataIsEmpty = false;
          });
        }
      } else {
        setState(() {
          _dataIsEmpty = true;
        });
      }
    } else {
      throw Exception('failed load data');
    }
  }

  fetchListTahunFile(String id_kategori) async {
    final response = await http.get(
        "https://bappeda-web.herokuapp.com/api/file?kategori=" +
            id_kategori +
            "&get_list_tahun=tahun");
    if (response.statusCode == 200) {
      var responseLength = json.decode(response.body).length;
      if (responseLength != 0) {
        if (mounted) {
          setState(() {
            lsttahunFile.addAll(json.decode(response.body));
            _isLoadingFile = false;
          });
        }
      }else {
        setState(() {
          _fileIsEmpty = true;
        });
      }
    } else {
      throw Exception('failed load data');
    }
  }

  fetchfile(String id_kategori, String tahun) async {
    String url;

    if (tahun == '') {
      url =
          "https://bappeda-web.herokuapp.com/api/file?kategori=" + id_kategori;
    } else {
      url = "https://bappeda-web.herokuapp.com/api/file?kategori=" +
          id_kategori +
          "&tahun=" +
          tahun;
    }
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseLength = json.decode(response.body).length;
      print(json.decode(response.body));
      if (responseLength != 0) {
        if (mounted) {
          setState(() {
            if (tahun == '') {
              _tahun_terbaru = json.decode(response.body)[0]['tahun'];
            } else {
              _listDataFile.addAll(json.decode(response.body));
            }
          });
        }
      }
    } else {
      throw Exception('failed load data');
    }
  }

  fetchKategori(String id_kategori) async {
    final response = await http.get(
        "https://bappeda-web.herokuapp.com/api/kategori?id=" +
            id_kategori +
            "&limit=0");
    if (response.statusCode == 200) {
      var responseLength = json.decode(response.body).length;
      if (responseLength != 0) {
        if (mounted) {
          setState(() {
            // _fileName = json.decode(response.body)['nama'];
            // print(json.decode(response.body)[0]['nama']);
            _fileName = json
                .decode(response.body)[0]['nama']
                .toString()
                .replaceAll(' ', '_');
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
        "https://bappeda-web.herokuapp.com/api/Datas?id_kategori=" +
            id_kategori +
            "&get_group_parameter=tahun");
    if (response.statusCode == 200) {
      var responseLength = json.decode(response.body).length;
      if (responseLength != 0) {
        if (mounted) {
          setState(() {
            lsttahun.addAll(json.decode(response.body));
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
        "https://bappeda-web.herokuapp.com/api/Datas?id_kategori=" +
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

  fileCheckPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pilih Tahun"),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                height: 70,
                child: Column(
                  children: [
                    DropdownButton<String>(
                      value: _tahun_file,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text("Tahun"),
                      isExpanded: true,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _tahun_file = newValue;
                        });
                      },
                      items: (lsttahunFile == null ? [''] : lsttahunFile)
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value['tahun'],
                          child: Text(value['tahun']),
                        );
                      }).toList(),
                    ),
                    Center(
                      child: _fileIsEmpty
                          ? Text(
                              "PDF File Tidak Tersedia",
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(),
                    )
                  ],
                ),
              );
            }),
            actions: [
              FlatButton(
                child: Text("close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              _fileIsEmpty?Container():FlatButton(
                child: Text("ok"),
                onPressed: () async {
                  if (_tahun_file == null) {
                    Navigator.pop(context);
                  } else {
                    String url =
                        'https://bappeda-web.herokuapp.com/upload/${_fileName}_${_tahun_file}.pdf';

                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                },
              ),
            ],
          );
        });
  }
}
