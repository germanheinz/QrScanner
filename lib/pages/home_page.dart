import 'package:flutter/material.dart';
import 'package:qrscanner/pages/directions_page.dart';
import 'package:qrscanner/pages/maps_page.dart';
import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int indexPage = 0;

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('QR Scanner'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete_forever), 
          onPressed: (){},
        ),
      ],
    ),
    body: _callPage(indexPage),
    bottomNavigationBar: _creatingButtonNavigationBar(),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: _creatingButton(),
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
    selectedItemColor: Theme.of(context).primaryColor,
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

Widget _creatingButton(){
  return FloatingActionButton(
    backgroundColor: Theme.of(context).primaryColor,
    onPressed: _scanQR,
    child: Icon(Icons.filter_center_focus),
  );
}

_scanQR() async{
  //geo:40.72423304705168,-73.89607801875003
  
  print('Scan QR');
  dynamic futureString = '';
  try {
    futureString = await BarcodeScanner.scan();
  } catch (e) {
    futureString = e.toString();
  }
  print('future string $futureString');
  if(futureString != null){
    print('Future String: ${futureString.rawContent}');
  }
}
}