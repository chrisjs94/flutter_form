import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  late Database _database;

  Future<void> openDb() async{
    _database = await openDatabase(
      join(await getDatabasesPath(), 'records_database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE TBL_RECORDS()')
      },
    )
  }
}