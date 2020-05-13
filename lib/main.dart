import 'package:flutter/material.dart';
import 'package:qrscanner/src/pages/directions_page.dart';
import 'package:qrscanner/src/pages/home_page.dart';
import 'package:qrscanner/src/pages/map_page.dart';
import 'package:qrscanner/src/pages/maps_page.dart';

 
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
        'map': (BuildContext context) => MapPage(),
        'directions': (BuildContext context) => DirectionsPage()
      },
      theme: ThemeData(
          primaryColor: Colors.deepPurple
      ),
    );
  }
}