import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrscanner/src/bloc/scan_bloc.dart';
import 'package:qrscanner/src/models/scan_model.dart';
import 'package:qrscanner/src/pages/directions_page.dart';
import 'package:qrscanner/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

final scansBloc = new ScansBloc();

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
          onPressed: scansBloc.deleteAllScans,
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


//geo:40.72423304705168,-73.89607801875003
//https://www.google.com  
_scanQR() async{
  print('Scan QR');
  dynamic futureString = 'http://www.google.com';
  // String futureString = 'http://www.google.com';
  // try {
  //   futureString = await BarcodeScanner.scan();
  // } catch (e) {
  //   futureString = e.toString();
  // }
  // print('future string $futureString');
  if(futureString != null){
    // print('Future String: ${futureString.rawContent}');
    final scan = ScanModel(valor: futureString);
    scansBloc.saveNewScan(scan);
  }
}
}