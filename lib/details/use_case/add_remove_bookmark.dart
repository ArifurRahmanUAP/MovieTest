import 'package:flutter/cupertino.dart';
import 'package:movietest/Util/duration.dart';
import 'package:movietest/details/model/movie_details_model.dart';
import 'package:movietest/details/resource/database/database.dart';
import 'package:movietest/details/model/save_data_model.dart';
import 'package:movietest/details/use_case/save_data.dart';

class SaveDeleteData {
  static onPress(BuildContext context, MovieDetailsModel model,
      DataBaseHelper dataBaseHelper, bool isSaved, StringBuffer saveDatas) {
    if (isSaved) {
      dataBaseHelper.deletesaveDataItem(model.id);
    } else {
      for (var value
      in model.genres!) {
        saveDatas.write(
            "${value.name},");
      }

      SaveDataModel
      saveDataModel =
      SaveDataModel(
          movieId: model.id,
          name: model
              .originalTitle
              .toString(),
          rating: model
              .voteAverage!.toStringAsFixed(2).toString(),
          genres: saveDatas
              .toString()
              .substring(
              0,
              saveDatas
                  .length -
                  1),
          duration:
          DurationCalculate.durationToString(
              model
                  .runtime),
          image: model
              .posterPath
              .toString());
      SaveData.onPress(
          saveDataModel,
          dataBaseHelper);
    }
  }
}