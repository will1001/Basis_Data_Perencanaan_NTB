import 'package:flutter/material.dart';

class Kontak extends StatefulWidget {
  @override
  _KontakState createState() => _KontakState();
}

class _KontakState extends State<Kontak> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 91.0),
            child: SizedBox(
              width: 250.0,
              height: 250.0,
              child: FadeInImage(
                fadeInDuration: const Duration(seconds: 1),
                placeholder: AssetImage('assets/images/LogoNTB.png'),
                image: AssetImage('assets/images/LogoNTB.png'),
              ),
            ),
          ),
          Center(
            child: Text('BAPPEDA',style: TextStyle(fontSize: 63,fontWeight: FontWeight.w500),),
          ),
          Center(
            child: Text('PROVINSI NUSA TENGGARA BARAT ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
          Padding(
            padding: const EdgeInsets.only(top:17.0),
            child: Center(
              child: Text('Jl. Flamboyan No.2, Mataram, Kodepos 83126'),
            ),
          ),
        ],
      ),
    );
  }
}
