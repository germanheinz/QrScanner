import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:qrscanner/pages/directions_page.dart';
import 'package:qrscanner/pages/home_page.dart';
import 'package:qrscanner/pages/maps_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRScanner',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'maps': (BuildContext context) => MapsPage(),
        'directions': (BuildContext context) => DirectionsPage()
      },
    );
  }
}