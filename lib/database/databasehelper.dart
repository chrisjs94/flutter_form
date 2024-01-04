import 'dart:async';

import 'package:flutter_form/shared/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../model/record.dart';

class DatabaseHelper{
  late Database _database;

  Future<void> openDB() async{
    _database = await openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        return db.execute(
          Record.empty().toSql()
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS records');

        await db.execute(Record.empty().toSql());
      },
      version: dbVersion
    );
  }

  Future<int> insertRecord(Record record) async{
    await openDB();

    record.idRecord = const Uuid().v1();
    return await _database.insert('records', record.toMap());
  }

  Future<int> deleteRecord(int id) async{
    await openDB();

    return await _database.delete('records', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateRecord(Record record) async{
    await openDB();

    return await _database.update('records', 
      record.toMap(), where: 'id = ?', whereArgs: [record.idRecord]);
  }

  Future<List<Record>> getRecords() async{
    await openDB();

    final List<Map<String, dynamic>> maps = await _database.query('records');
    return List.generate(maps.length, (index) {
      return Record.fromMap(maps[index]);
    });
  }
}