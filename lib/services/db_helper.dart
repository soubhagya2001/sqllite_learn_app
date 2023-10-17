import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static const dbName = "myDatabse.db";
  static const dbVersion = 1;
  static const dbTable = "myTable";
  static const columnId = "id";
  static const columnName = "name";

  //constructor
  static final DatabaseHelper instance = DatabaseHelper();

  //database initialize
   static Database? _database;

  Future<Database?> get database async{
    _database ??= await initDB();
    return _database;

  }


  Future<Database?> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }
  
  Future onCreate(Database db, int version) async{
    db.execute(
      '''
      CREATE TABLE $dbTable(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL
      
      )
      '''
    );
  }

  //insert
  insertRecord(Map<String, dynamic> row) async{
    Database? db = await instance.database;
    return await db!.insert(dbTable, row);
  }

  //read/query
  Future<List<Map<String,dynamic>>> queryDatabase() async{
    Database? db = await instance.database;
    return await db!.query(dbTable);
  }

  //update
  Future<int> updateRecord(Map<String,dynamic> row) async{
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(dbTable, row , where: '$columnId=?', whereArgs: [id]);
  }

  //delete
  Future<int> deleteRecord(int id) async{
    Database? db = await instance.database;
    return await db!.delete(dbTable, where: '$columnId = ?', whereArgs: [id]);
}
}