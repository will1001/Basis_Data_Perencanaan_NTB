import 'dart:convert';

import 'package:data_perencanaan_ntb/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';

import 'model/APISource.dart';

Future<List<Data>> demo(String url) async {
  var responseJson;
  final store = await CacheStore.getInstance();
  final file = await store.getFile(url, headers: {
    'WDP-NTB-KEY': 'alsodhr74jrhfot97264jgnd85jg7jsofjgur5',
  });
  responseJson = json.decode(file.readAsStringSync());
  if(responseJson['status']==false){
   responseJson =
      null;
  }else{
    responseJson =
      (responseJson['data'] as List).map((p) => Data.fromJson(p)).toList();
  };
  await store.clearAll();
  return responseJson;
}

class SplashScreen extends StatefulWidget {
  SplashScreen({this.title});
  final String title;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<List<Data>> _cachedata;
  @override
  void initState() {
    super.initState();
    // setState(() {
    //   _cachedata = "demo('https://bappeda-web.herokuapp.com/api/label')";
    // });
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => Home(title: widget.title )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => Home(title: widget.title)));
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_splashscreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 144.0,
                height: 212.0,
                child: FadeInImage(
                  fadeInDuration: const Duration(seconds: 1),
                  placeholder: AssetImage('assets/images/LogoNTB.png'),
                  image: AssetImage('assets/images/LogoNTB.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Basis Data Perencanaan NTB',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(27.0),
                child: Text(
                  'Dikelola oleh BAPPEDA NTB',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                ),
              ),
              // Column(
              //   children: <Widget>[
              //     FlatButton.icon(
              //       color: Colors.blue[200],
              //       icon: Icon(Icons.touch_app),
              //       label: Text('Start'),
              //       onPressed: () {
              //         // print(_cachedata);
              //         Navigator.of(context).push(MaterialPageRoute(
              //             builder: (c) => Home(
              //                   title: widget.title,
              //                   // cachedata: _cachedata,
              //                 )));
              //       },
              //     ),
              //     FlatButton.icon(
              //       color: Colors.blue[200],
              //       icon: Icon(Icons.update),
              //       label: Text('Update Data'),
              //       onPressed: () {
              //         setState(() {
              //           _cachedata = demo('http://ngerti.net/api/data/');
              //         });
              //         showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return AlertDialog(
              //                 content: SizedBox(
              //                   height: 50,
              //                   child: FutureBuilder<List<Data>>(
              //                       future: _cachedata,
              //                       builder: (context, snapshot) {
              //                         if (snapshot.hasData) {
              //                           Navigator.of(context).pop(true);
              //                         }
              //                         return Column(
              //                           children: <Widget>[
              //                             LinearProgressIndicator(),
              //                             Padding(
              //                               padding: const EdgeInsets.all(8.0),
              //                               child: Text('Updating Data'),
              //                             )
              //                           ],
              //                         );
              //                       }),
              //                 ),
              //               );
              //             });
              //       },
              //     )
              //   ],
              // )
              //       children: <Widget>[
              //         LinearProgressIndicator(),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             'Loading Data',
              //             style: TextStyle(
              //               fontSize: 13.0,
              //               color: Colors.white,
              //             ),
              //           ),
              //         )
              //       ],
              //     )
              // FutureBuilder<List<Data>>(
              //   future: _cachedata,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return FlatButton.icon(
              //         color: Colors.green,
              //         icon: Icon(Icons.touch_app), //`Icon` to display
              //         label: Text('Start'), //`Text` to display
              //         onPressed: () {
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (c) => Home(
              //                     title: widget.title,
              //                     cachedata: _cachedata,
              //                   )));
              //         },
              //       );
              //     } else if (snapshot.hasError) {
              //       return Text("${snapshot.error}");
              //     }

              //     // By default, show a loading spinner.
              //     return Column(
              //       children: <Widget>[
              //         LinearProgressIndicator(),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             'Loading Data',
              //             style: TextStyle(
              //               fontSize: 13.0,
              //               color: Colors.white,
              //             ),
              //           ),
              //         )
              //       ],
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    ));
  }
}
