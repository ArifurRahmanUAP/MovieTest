import '../../details/resource/database/database.dart';
import '../../details/model/save_data_model.dart';

class BookmarkDataRepository {
  Future<List<SaveDataModel>> fetchBookmarkData(DataBaseHelper dataBaseHelper) async {
    await dataBaseHelper.init();
    return dataBaseHelper.fetchBookmark();
  }
}
class NetworkError extends Error {}
