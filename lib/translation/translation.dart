import 'dart:io' as io;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;

class TranslationDB {
  String german;
  String english;
  String id;
  TranslationDB(
      {required this.english, required this.german, required this.id});
}

class DatabaseSingleton {
  static DatabaseSingleton? _instance = null;
  late final sqlite3.Database _database;

  DatabaseSingleton._();

  static Future<DatabaseSingleton> getInstance() async {
    if (_instance == null) {
      final directory = await getApplicationDocumentsDirectory();
      final dbFile = io.File('${directory.path}/foods.db');
      if (!dbFile.existsSync()) {
        final data = await rootBundle.load('database/foods2.db');
        await dbFile.create(recursive: true);
        await dbFile.writeAsBytes(data.buffer.asUint8List());
      }
      final db = sqlite3.sqlite3.open(dbFile.path);
      _instance = DatabaseSingleton._();
      _instance!._database = db;
    }
    return _instance!;
  }

  Future<TranslationDB> getTranslation(String id) async {
    final rows = _database.select(
        "SELECT food_id, english, known_as, german FROM foods where food_id = '$id'");

    if (rows.length == 0) {
      return TranslationDB(english: id, german: "", id: id);
    }

    final ele = rows.rows[0];
    return TranslationDB(
      english: ele[1].toString(),
      german: "",
      id: id,
    );
  }

  Future<TranslationDB> findTranslation(String foodName) async {
    final rows = _database.select(
        "SELECT food_id, english, known_as, german FROM foods where english like '%spinach%'");
    print("object");
    print(rows);
    print("object");

    if (rows.length == 0) {
      return TranslationDB(english: foodName, german: "", id: foodName);
    }

    final ele = rows.rows[0];
    return TranslationDB(
      english: ele[1].toString(),
      german: "",
      id: ele[0].toString(),
    );
  }

  void close() {
    _database.dispose();
  }
}

Future<TranslationDB> getTranslation(String id) async {
  final db = await DatabaseSingleton.getInstance();
  print(id);
  final translation = await db.getTranslation(id);
  print(translation.german);
  return translation;
}

Future<TranslationDB> findTranslation(String foodName) async {
  final db = await DatabaseSingleton.getInstance();
  final translation = await db.findTranslation(foodName);
  print(translation.german);
  print("findTranslation");
  return translation;
}
