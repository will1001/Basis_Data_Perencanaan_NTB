import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/APIProvider.dart';


class CustomSearchDelegate extends SearchDelegate {
  // final Future<List<Data>> datas;

  CustomSearchDelegate();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var hasilsearch=[];
    return ChangeNotifierProvider<APIProvider>(
      builder: (context) => APIProvider(),
      child: Consumer<APIProvider>(
        builder: (context, apiprovider, _) => NotificationListener<ScrollNotification>(
           onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                   apiprovider.limit = apiprovider.limit+10;
              }
            },
          child: ListView(
            children: <Widget>[
              // FutureBuilder<List<Data>>(
              //   future: datas,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {

              //       var hasilsearchsubket1 = snapshot.data
              //           .where((a) => (a.subket1==null?'':a.subket1).toLowerCase().contains(query));
              //       var hasilsearchsubket2 = snapshot.data
              //           .where((a) => (a.subket2==null?'':a.subket2).toLowerCase().contains(query));
              //       var hasilsearchsubket3 = snapshot.data
              //           .where((a) => (a.subket3==null?'':a.subket3).toLowerCase().contains(query));
              //       var hasilsearchsubket4 = snapshot.data
              //           .where((a) => (a.subket4==null?'':a.subket4).toLowerCase().contains(query));
              //       var hasilsearchsubket5 = snapshot.data
              //           .where((a) => (a.subket5==null?'':a.subket5).toLowerCase().contains(query));
              //       var hasilsearchsubket6 = snapshot.data
              //           .where((a) => (a.subket6==null?'':a.subket6).toLowerCase().contains(query));
              //       var hasilsearchnamadata = snapshot.data
              //           .where((a) => a.namadata.toLowerCase().contains(query));

              //       hasilsearch.addAll(hasilsearchsubket1);
              //       hasilsearch.addAll(hasilsearchsubket2);
              //       hasilsearch.addAll(hasilsearchsubket3);
              //       hasilsearch.addAll(hasilsearchsubket4);
              //       hasilsearch.addAll(hasilsearchsubket5);
              //       hasilsearch.addAll(hasilsearchsubket6);
              //       hasilsearch.addAll(hasilsearchnamadata);
              //       if(hasilsearch.length>apiprovider.limit){
              //         hasilsearch=hasilsearch.getRange(0, apiprovider.limit).toList();
              //       }
                    
              //       return Column(
              //         children: hasilsearch
              //             .map<ListTile>((a) => ListTile(
              //                   title: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: <Widget>[
              //                       Container(
              //                         color: apiprovider.expansiontilecolor,
              //                         child: ExpansionTile(
              //                             title: Column(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: <Widget>[
              //                                 a.subket1 == null
              //                                     ? Container()
              //                                     : Text(
              //                                         a.subket1,
              //                                         style: TextStyle(
              //                                           fontWeight:
              //                                               FontWeight.w300,
              //                                         ),
              //                                       ),
              //                                 a.subket2 == null
              //                                     ? Container()
              //                                     : Text(
              //                                         a.subket2,
              //                                         style: TextStyle(
              //                                           fontWeight:
              //                                               FontWeight.w300,
              //                                         ),
              //                                       ),
              //                                 a.subket3 == null
              //                                     ? Container()
              //                                     : Text(
              //                                         a.subket3,
              //                                         style: TextStyle(
              //                                           fontWeight:
              //                                               FontWeight.w300,
              //                                         ),
              //                                       ),
              //                                 a.subket4 == null
              //                                     ? Container()
              //                                     : Text(
              //                                         a.subket4,
              //                                         style: TextStyle(
              //                                           fontWeight:
              //                                               FontWeight.w300,
              //                                         ),
              //                                       ),
              //                                 a.subket5 == null
              //                                     ? Container()
              //                                     : Text(
              //                                         a.subket5,
              //                                         style: TextStyle(
              //                                           fontWeight:
              //                                               FontWeight.w300,
              //                                         ),
              //                                       ),
              //                                 a.subket6 == null
              //                                     ? Container()
              //                                     : Text(
              //                                         a.subket6,
              //                                         style: TextStyle(
              //                                           fontWeight:
              //                                               FontWeight.w300,
              //                                         ),
              //                                       ),
              //                                 Text(
              //                                   a.namadata,
              //                                   style: TextStyle(
              //                                     fontWeight: FontWeight.w900,
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                             children: <Widget>[
              //                               Column(
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.end,
              //                                 children: <Widget>[
              //                                   a.nilai == null
              //                                       ? Container()
              //                                       : ListTile(
              //                                           leading: Text('Nilai :'),
              //                                           title: Text(
              //                                               setFormatNilai(
              //                                                   a.nilai)),
              //                                         ),
              //                                   a.satuan == null
              //                                       ? ListTile(
              //                                           leading: Text('Satuan :'),
              //                                           title: Text(''),
              //                                         )
              //                                       : ListTile(
              //                                           leading: Text('Satuan :'),
              //                                           title: Text(a.satuan),
              //                                         ),
              //                                   a.tahun == null
              //                                       ? ListTile(
              //                                           leading: Text('Tahun :'),
              //                                           title: Text(''),
              //                                         )
              //                                       : ListTile(
              //                                           leading: Text('Tahun :'),
              //                                           title: Text(a.tahun
              //                                               .substring(0, 4)),
              //                                         ),
              //                                   a.sumberdata == null
              //                                       ? ListTile(
              //                                           leading:
              //                                               Text('Sumber Data :'),
              //                                           title: Text(''),
              //                                         )
              //                                       : ListTile(
              //                                           leading:
              //                                               Text('Sumber Data :'),
              //                                           title: Text(a.sumberdata),
              //                                         ),
              //                                 ],
              //                               ),
              //                             ]),
              //                       )
              //                     ],
              //                   ),
              //                 ))
              //             .toList(),
              //       );
              //     } else if (snapshot.hasError) {
              //       return Text("${snapshot.error}");
              //     }

              //     // By default, show a loading spinner.
              //     return Center(
              //       child: Padding(
              //         padding: const EdgeInsets.all(53.0),
              //         child: SizedBox(
              //           height: 100.0,
              //           width: 100.0,
              //           child: CircularProgressIndicator(),
              //         ),
              //       ),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  // TODO: Fungsi utk rubah format nilai
  String setFormatNilai(String nilai) {
    int hit = 0;
    var newnilai = [];
    var splitnilai = nilai.split('.');
    var reversednilai = splitnilai[0].split('').reversed.toList();
    for (int i = 0; i < splitnilai[0].split('').length; i++) {
      if (hit < 3) {
        newnilai.add(reversednilai[i]);
      } else {
        newnilai.add('.');
        newnilai.add(reversednilai[i]);
        hit = 0;
      }
      hit++;
    }
    if (splitnilai.length > 1) {
      newnilai.insert(0, ',' + splitnilai[1]);
    }
    return newnilai.reversed.join();
  }
}
