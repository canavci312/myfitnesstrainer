import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      print("DBHelper nulldi oluşturuldu");
      return _databaseHelper;
    } else {
      print("DBHelper null değildi var olan kullanılacak");
      return _databaseHelper;
    }
  }
  DatabaseHelper._internal();
  Future<Database> _getDatabase() async {
    if (_database == null) {
      print("DB nulldi oluşturulacak");
      _database = await _initializeDatabase();

      return _database;
    } else {
      print("DB null değildi var olan kullanılacak");
      return _database;
    }
  }

  Future _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "gymapp.db");
    var exists = await databaseExists(path);
    if (!exists) {
      print("Creating new copy from asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join("db", "gymapp.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path, readOnly: false);
  }

  Future<List<Map<String, dynamic>>> getWorkouts() async {
    var db = await _getDatabase();
    var sonuc = await db.query("workout");
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> getExercises() async {
    var db = await _getDatabase();
    var sonuc = await db.query("exercises", orderBy: 'name asc');
    return sonuc;
  }

  Future<int> addExercise(Exercise exercise) async {
    var db = await _getDatabase();
    var sonuc = await db.insert("exercises", exercise.toMap());
    return sonuc;
  }

  Future<Exercise> getExercise(int exerciseID) async {
    var db = await _getDatabase();
    List<Map> results = (await db.query('exercises',
        where: "exerciseID=?", whereArgs: [exerciseID], limit: 1));
    Exercise exercise = Exercise.fromMap(results[0]);
    return exercise;
  }

  Future<List<Exercise>> loadExercises() async {
    List<Exercise> allExercises;
    allExercises = List<Exercise>();
    await _databaseHelper.getExercises().then((exerciseMapList) {
      for (Map okunanMap in exerciseMapList) {
        allExercises.add(Exercise.fromMap(okunanMap));
      }
    });
    return allExercises;
  }
}
