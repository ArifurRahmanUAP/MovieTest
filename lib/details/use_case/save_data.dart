import 'package:flutter/material.dart';
import 'package:movietest/details/resource/database/database.dart';
import 'package:movietest/details/model/save_data_model.dart';

class SaveData {
  static onPress(SaveDataModel saveDataModel, DataBaseHelper dataBaseHelper) {
    dataBaseHelper.addTosaveData(saveDataModel);
  }
}
