
import 'package:sqflite/sqflite.dart';
import 'package:studentbook/controller/database_connection.dart';

class Repository {

  late DatabaseConnection databaseConnection;
  Repository() {
    databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await databaseConnection.setDatabase();
      return _database;
    }
  }

  // insert data
  Future insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  // Fetch data
  Future fetchData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  // Delete data
  Future deleteData(table, id) async {
    var connection = await database;
    return await connection?.delete(table,where: "id=?",whereArgs: [id]);
  }

  // Update data
  Future updateData(table, data, id) async {
    var connection = await database;
    return await connection?.update(table,data,where: "id=?",whereArgs: [id]);
  }

}
