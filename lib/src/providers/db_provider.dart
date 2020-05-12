import 'dart:io';

import 'package:qrscanner/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider{
  static Database _dataBase;
  static final DBProvider db = DBProvider._private();

  DBProvider._private();

  Future<Database> get database async{
    if(_dataBase != null) return _dataBase;

    _dataBase = await initDB();
    return _dataBase;
  }

  //Initialiation DB
  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
      
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')'
        );
      }
    );
  }

  //Create Registry 2 ways
  //1
  newScanRar(ScanModel scanModel) async{
    final db = await database;
    final res = await db.rawInsert(
      "INSERT Into Scans(id,tipo,valor) "
      "VALUES (${scanModel.id}, '${scanModel.tipo}', '${scanModel.valor}')"
    );
    return res;
  }
  //2
  newScan(ScanModel scanModel) async{
    final db = await database;
    final res = db.insert('Scans', scanModel.toJson());
    
    return res;
  }


}