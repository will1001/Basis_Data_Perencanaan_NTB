import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class APIProvider with ChangeNotifier{
  // Future<List<Data>> _responseJson=fetchData();
  Color _expansiontilecolor= Colors.white;
  String _tahun;
  String _sumberdata;
   int _limit = 10;
  int _bottomNavigationBarIndex = 0;
  int _semester;
 
 
  // Future<List<Data>> get responseJson => _responseJson;
  Color get expansiontilecolor => _expansiontilecolor;
  String get tahun => _tahun;
  String get sumberdata => _sumberdata;
  int get limit => _limit;
  int get bottomNavigationBarIndex => _bottomNavigationBarIndex;
  int get semester => _semester;

  
 

  set expansiontilecolor(Color value ){
    _expansiontilecolor = value;
    notifyListeners();
  }


  set sumberdata(String value ){
    _sumberdata = value;
    notifyListeners();
  }
  set tahun(String value ){
    _tahun = value;
    notifyListeners();
  }

  set semester(int value ){
    _semester = value;
    notifyListeners();
  }
  
  set limit(int value ){
    _limit = value;
    notifyListeners();
  }
  
  set bottomNavigationBarIndex(int value ){
    _bottomNavigationBarIndex = value;
    notifyListeners();
  }



}