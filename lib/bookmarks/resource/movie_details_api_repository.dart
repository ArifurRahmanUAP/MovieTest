import 'package:movietest/home/model/genrsModel.dart';

import '../../database/database.dart';
import '../../details/model/save_data_model.dart';

class BookmarkDataRepository {
  Future<List<SaveDataModel>> fetchBookmarkData(DataBaseHelper dataBaseHelper) async {
    await dataBaseHelper.init();
    return dataBaseHelper.fetchBookmark();
  }

  Future<List<GenreModel>> fetchGenresNameById(DataBaseHelper dataBaseHelper) async {
    await dataBaseHelper.init();
    return dataBaseHelper.fetchGenresNameById();
  }
}
class NetworkError extends Error {}
