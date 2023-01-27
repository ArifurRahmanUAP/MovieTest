import 'package:flutter/material.dart';
import 'package:movietest/details/resource/database/database.dart';
import 'package:movietest/details/resource/database/save_data_model.dart';

class SaveData {
  static onPress(BuildContext context, SaveDataModel saveDataModel, DataBaseHelper dataBaseHelper) {
    dataBaseHelper.addTosaveData(saveDataModel);
  }
}
