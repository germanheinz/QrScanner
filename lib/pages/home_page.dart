import 'package:flutter/material.dart';
import 'package:qrscanner/pages/directions_page.dart';
import 'package:qrscanner/pages/maps_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int indexPage = 0;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _callPage(indexPage),
    bottomNavigationBar: _creatingButtonNavigationBar(),
  );
}

Widget _creatingButtonNavigationBar(){
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.navigate_before),
        title: Text('Mapa'),
      ),
        BottomNavigationBarItem(
        icon: Icon(Icons.navigate_next),
        title: Text('Directions'),
      ),
    ],
    currentIndex: indexPage,
    selectedItemColor: Colors.amber[800],
    onTap: (index){
      setState(() {
        indexPage = index;
      });
    },
  );
}

Widget _callPage(int currentPage){
  switch(currentPage){
    case 0: return MapsPage();
    case 1: return DirectionsPage();
    default: return MapsPage();
  }
}
}