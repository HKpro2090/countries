import 'dart:io';
import 'package:countries/src/models/data_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Country table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Country_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Country('
              'name TEXT PRIMARY KEY,'
              'alpha3Code TEXT,'
              'region TEXT,'
              'capital TEXT,'
              'flag TEXT'
              ')');
        });
  }

  // Insert Country on database
  createCountry(Country newCountry) async {
    await deleteAllCountrys();
    final db = await database;
    final res = await db.insert('Country', newCountry.toJson());

    return res;
  }

  // Delete all Countrys
  Future<int> deleteAllCountrys() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Country');

    return res;
  }

  Future<List<Country>> getAllCountrys() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Country");

    List<Country> list =
    res.isNotEmpty ? res.map((c) => Country.fromJson(c)).toList() : [];
    res.forEach((element) => print(element));

    return list;
  }

  Future<List<Map>> getallregion() async{
    final db = await database;
    List <Map> res1 = await db.rawQuery("SELECT DISTINCT region FROM Country ORDER BY region ASC");
    res1.remove(0);
    return res1;
  }
  Future <List<Map>> countriesinregion(String regionname) async{
    final db  = await database;
    String dbsearch = "SELECT * FROM Country WHERE region = "+regionname +" ORDER BY name ASC";
    List <Map> res = await db.rawQuery(dbsearch);
    return res;
  }
  Future <List<Map>> countrydetails(String countryname) async{
    final db  = await database;
    print(countryname);
    String dbsearch = "SELECT * FROM Country WHERE name = "+countryname;
    List <Map> res1 = await db.rawQuery(dbsearch);
    res1.forEach((element) => print(element));
    return res1;
  }
}