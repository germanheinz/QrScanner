import 'dart:async';

import 'package:qrscanner/src/bloc/validator.dart';
import 'package:qrscanner/src/models/scan_model.dart';
import 'package:qrscanner/src/providers/db_provider.dart';

class ScansBloc with Validators{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    getAllScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream     => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose(){
    _scansController?.close();
  }
  getAllScans() async {
    _scansController.sink.add( await DBProvider.db.getAllScan());
  }
  saveNewScan(ScanModel scanModel) async {
   await DBProvider.db.newScan(scanModel);
   getAllScans(); 
  }
  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getAllScans();
  }
  deleteAllScans() async {
    await DBProvider.db.deleteAllScan();
    getAllScans();
  }

}