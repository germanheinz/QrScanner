import 'dart:async';

import 'package:qrscanner/src/models/scan_model.dart';

class ScansBloc{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){

  }

  final _scnasController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scnasController.stream;

  dispose(){
    _scnasController?.close();
  }

}