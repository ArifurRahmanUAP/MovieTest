import 'package:movietest/details/model/save_data_model.dart';

import '../../database/database.dart';

class SaveData {
  static onPress(SaveDataModel saveDataModel, DataBaseHelper dataBaseHelper) {
    dataBaseHelper.addTosaveData(saveDataModel);
  }
}
