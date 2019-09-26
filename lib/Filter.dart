import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/APIProvider.dart';

Widget filter() {
  return ChangeNotifierProvider<APIProvider>(
    builder: (context) => APIProvider(),
    child: Consumer<APIProvider>(
      builder: (context, apiprovider, _) => Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 100.0,
              child: DrawerHeader(
                child: Center(
                    child: Text('Filter Data',
                        style: TextStyle(color: Colors.white, fontSize: 23.0))),
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
                  items: ['2017', '2018']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
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
             Column(
               children: <Widget>[
                 FlatButton.icon(
                          color: Colors.blue,
                          icon: Icon(Icons.filter_list,color: Colors.white,), //`Icon` to display
                          label: Text('Terapkan Filter',style: TextStyle(color: Colors.white),), //`Text` to display
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
               ],
             ),
          ],
        ),
      ),
    ),
  );
}
