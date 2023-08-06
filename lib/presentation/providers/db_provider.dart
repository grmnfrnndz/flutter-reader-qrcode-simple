import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../infrastructure/models/models.dart';


class DBProvider {

  final String _databaseName = 'scans';
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  // Future<Database> get database async {
  //   if (_database != null) return _database;
  //   _database = await initDB();
  //   return _database;
  // }

  Future<Database> get database async => _database ??= await _initDB();

  
  Future<Database> _initDB() async {

    // path storage databas
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'scansdb.db');

    // create database
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $_databaseName (
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          );
        ''');
      }
    );
  }


  Future<int> addScanRaw(ScanModel scanModel) async {

    final ScanModel(:id, :type, :value) = scanModel;

    // check database
    final db = await database;

    final record = await db.rawInsert('''
      INSERT INTO $_databaseName (id, type, value) VALUES ($id, '$type', '$value');
    ''');

    return record;
  }

  Future<int> addScan(ScanModel scanModel) async {
    final db = await database;
    final record = await db.insert(_databaseName, scanModel.toJson());
    return record;    
  }

  Future<ScanModel?> getScanById(int scanId) async {

    final db = await database;
    final record = await db.query(_databaseName, where: 'id = ?', whereArgs: [scanId]);

    return record.isNotEmpty
      ? ScanModel.fromJson(record.first)
      : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final record = await db.query(_databaseName);

    return record.isNotEmpty
      ? record.map((rec) => ScanModel.fromJson(rec)).toList()
      : [];
  }


  Future<List<ScanModel>> getScansByType(ScanType type) async {
    final db = await database;
    final record = await db.query(_databaseName, where: 'type = ?', whereArgs: [type.value]);
    // final record = await db.rawQuery('''
    //   SELECT * FROM $_databaseName WHERE type = '${type.value}'
    // ''');

    return record.isNotEmpty
      ? record.map((rec) => ScanModel.fromJson(rec)).toList()
      : [];
  }

  Future<int> updateScan(ScanModel scanModel) async {

    final db = await database;
    final record = await db.update(_databaseName, scanModel.toJson(), where: 'id = ?', whereArgs: [scanModel.id]);
    return record;

  }

  Future<int> deleteScan(int scanId) async {

    final db = await database;
    final record = await db.delete(_databaseName, where: 'id = ?', whereArgs: [scanId]);
    return record;

  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final record = await db.delete(_databaseName);
    return record;
  }


}