import 'package:flutter/material.dart';
import 'package:qrscanner/src/models/scan_model.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          )          
        ]
      ),
      body: Center(
        child: Text('Coordenadas ${scanModel.valor}'),
      ),
    );
  }
}