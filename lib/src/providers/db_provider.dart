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
    final db  = await database;
    final res = await db.insert('Scans', scanModel.toJson());
    
    return res;
  }
   //SELECT ALL
  Future<List<ScanModel>>getAllScan() async {
    final db  = await database;
    final res = await db.query('Scans');
    
    List<ScanModel> list = res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
    return list;
  }
  //SELECT BY ID
  Future<ScanModel>getScanId(int id) async {
    final db  = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    
    
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }
  //SELECT BY TYPE
  Future<List<ScanModel>>getScanType(String type) async {
    final db  = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$type'");
    
    List<ScanModel> list = res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
    return list;
  }
  //UPDATE 
  updateScan(ScanModel scanModel) async {
    final db  = await database;
    final res = await db.update('Scans', scanModel.toJson(), where: 'id = ?', whereArgs: [scanModel.id]);

    return res;
  }
  //DELETE
  Future<int> deleteScan(int id) async{
    final db  = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }
  //DELETE ALL
  Future<int> deleteAllScan(int id) async{
    final db  = await database;
    final res = await db.rawDelete('DELETE FROM Scans');

    return res;
  }





}