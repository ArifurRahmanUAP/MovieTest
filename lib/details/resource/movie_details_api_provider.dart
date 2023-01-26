import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movietest/Util/util.dart';
import 'package:movietest/details/model/movie_details_model.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popularMoviwModel.dart';

class MovieDetailsApiProvider {
  final Dio _dio = Dio();
  final String _now_playing_url = 'https://api.themoviedb.org/3/movie/315162?api_key=98f3908014410fc8a0a0393df1b060af&language=en-US';
  Future<MovieDetailsModel> fetchMovieDetails() async {
    try {
      Response response = await _dio.get(_now_playing_url);
      return MovieDetailsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return MovieDetailsModel.withError("Data not found / Connection issue");
    }
  }
}
