import 'dart:io';
import 'package:flutter/services.dart';
import 'package:movietest/details/model/save_data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io' as io;

class DataBaseHelper {
  late Database _db;

  Future<void> init() async {
    Directory applicationDirectory = await getApplicationDocumentsDirectory();

    String dbPath = path.join(applicationDirectory.path, "movielist.db");

    bool isExists = await io.File(dbPath).exists();

    if (!isExists) {
      // Copy from asset
      ByteData data =
          await rootBundle.load(path.join("assets", "movielist.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPath).writeAsBytes(bytes, flush: true);
    }
    _db = await openDatabase(dbPath);
  }

  Future<void> deletesaveDataItem(int? id) async {
    await _db.delete(
      'movielist',
      where: "movieId = ?",
      whereArgs: [id],
    );
  }

  Future<bool> fetchIsBookmarked(int? id) async {
    var list = await _db.rawQuery("Select * from movielist where movieId=$id");
    if (list.isEmpty) {
      return false;
    } else
      return true;
  }

  Future<List<SaveDataModel>> fetchBookmark() async {
    if (_db == null) {
      throw "bd is not initiated, initiate using [init(db)] function";
    }
    List<Map<String, dynamic>> maps = await _db.query('movielist');

    var s = List.generate(maps.length, (i) {
      return SaveDataModel(
        movieId: maps[i]['movieId'],
        name: maps[i]['name'],
        rating: maps[i]['rating'],
        genres: maps[i]['genres'],
        duration: maps[i]['duration'],
        image: maps[i]['image'],
      );
    });

    return s;
  }

  Future<void> addTosaveData(SaveDataModel saveDataModel) async {
    if (_db == null) {
      throw "bd is not initiated, initiate using [init(db)] function";
    }
    await _db.insert("movielist", saveDataModel.toJson());
  }
}
