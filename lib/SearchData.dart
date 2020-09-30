import 'package:data_perencanaan_ntb/ShowData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class CustomSearchDelegate extends SearchDelegate {
//   // final Future<List<Data>> datas;
//   final String kategori;
//   List _listData = new List();

//   CustomSearchDelegate(this.kategori);
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {

//     if (query.length > 2) {
//       return showdata(kategori, _listData);
//     } else {
//       return Text("Ketik minimal 3 huruf untuk pencarian Data");
//     }
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {

//     if (query.length > 3) {
//       return Text("");
//     } else {
//       return Text("");
//     }
//   }

//   fetch(String id_kategori, String keyword) async {
//     final response = await http.get(
//         "https://web-bappeda.herokuapp.com/api/Datas?limit=0" +
//             "&id_kategori=" +
//             id_kategori +
//             "&cari=" +
//             nullReplacer(keyword));
//     if (response.statusCode == 200) {
//       // setState(() {
//       _listData.addAll(json.decode(response.body));
//       // _isLoading = false;
//       // });
//     } else {
//       throw Exception('failed load data');
//     }
//   }

//   nullReplacer(var val) {
//     val = val == null ? '' : val;
//     return val;
//   }
// }

class SearchData extends StatefulWidget {
  SearchData({this.kategori});
  final String kategori;
  @override
  _SearchDataState createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  String query = "";
  final myController = TextEditingController();
  List _listData = new List();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_setQuery);
  }

  _setQuery() {
    setState(() {
      query = myController.text;
    });
    if (query.length > 3) {
      setState(() {
        _isLoading = true;
      });
      fetch(widget.kategori, myController.text);
      print(_listData);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextFormField(
          controller: myController,
          decoration: const InputDecoration(
            hintText: 'Search',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          // onEditingComplete: () {
          //   setState(() {
          //     query = "ontap";
          //   });
          //   FocusScope.of(context).requestFocus(FocusNode());
          //   //  FocusScope.of(context).requestFocus(new FocusNode());
          // },
          // onFieldSubmitted: () {
          //   setState(() {
          //     query = "ontap";
          //   });
          //   // FocusScope.of(context).requestFocus(FocusNode());
          //   //  FocusScope.of(context).requestFocus(new FocusNode());
          // },
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  myController.text = "";
                });
              })
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _listData.length == 0
              ? query.length != 0
                  ? Center(
                      child: Text("Data Tidak Di Temukan"),
                    )
                  : showdata(widget.kategori, _listData)
              : showdata(widget.kategori, _listData),
    );
  }

  fetch(String id_kategori, String keyword) async {
    final response = await http.get(
        "https://web-bappeda.herokuapp.com/api/Datas?limit=0" +
            "&id_kategori=" +
            id_kategori +
            "&cari=" +
            nullReplacer(keyword));
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _listData.clear();
          _listData.addAll(json.decode(response.body));
          _isLoading = false;
        });
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
