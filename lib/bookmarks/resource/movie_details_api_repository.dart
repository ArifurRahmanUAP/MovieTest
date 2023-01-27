
import '../../details/resource/database/database.dart';
import '../../details/resource/database/save_data_model.dart';

class BookmarkDataRepository {
  Future<List<SaveDataModel>> fetchBookmarkData(DataBaseHelper dataBaseHelper) {
    dataBaseHelper.init();
    return dataBaseHelper.fetchBookmark();
  }
}

class NetworkError extends Error {}
