import 'package:flutter/material.dart';
import 'package:movietest/details/page/movie_details_page.dart';
import 'package:movietest/details/resource/database/database.dart';
import 'package:movietest/details/resource/movie_details_api_provider.dart';

class BookmarkDeleteClick {
  static onPress(
      BuildContext context, DataBaseHelper dataBaseHelper, int? movieId) {
    dataBaseHelper.deletesaveDataItem(movieId);
  }
}
