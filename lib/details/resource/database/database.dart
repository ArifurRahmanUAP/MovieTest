
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:movietest/details/resource/database/save_data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io' as io;

class DataBaseHelper {
  late Database _db;


  Future<void> init() async {
    Directory applicationDirectory = await getApplicationDocumentsDirectory();

    String dbPathEnglish =
    path.join(applicationDirectory.path, "movielist.db");

    bool isExists = await io.File(dbPathEnglish).exists();

    if (!isExists) {
      // Copy from asset
      ByteData data =
      await rootBundle.load(path.join("assets", "movielist.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }

    this._db = await openDatabase(dbPathEnglish);

  }



  Future<void> deletesaveDataItem(int? id) async {

    await _db.delete('movielist', where: "id = ?", whereArgs: [id],
    );
  }



  Future<List<SaveDataModel>> fetchBookmark() async {

    if (_db == null) {
      throw "bd is not initiated, initiate using [init(db)] function";
    }
    List<Map<String, dynamic>> maps = await _db.query('movielist');

    var s = List.generate(maps.length, (i) {

      return SaveDataModel(
          movieId: maps[i]['movieId'],
          name:  maps[i]['name'],
          rating:  maps[i]['rating'],
          type: maps[i]['type'],
          duration: maps[i]['duration'],
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
