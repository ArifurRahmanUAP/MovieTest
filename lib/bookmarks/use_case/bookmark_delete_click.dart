import 'package:flutter/material.dart';
import '../../database/database.dart';

class BookmarkDeleteClick {
  static onPress(
      BuildContext context, DataBaseHelper dataBaseHelper, int? movieId) {
    dataBaseHelper.deletesaveDataItem(movieId);
  }
}
