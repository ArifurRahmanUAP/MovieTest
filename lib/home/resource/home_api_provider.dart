import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movietest/Util/util.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popular_movie_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _now_playing_url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=${Utill.apiKey}&language=en-US&page=1';
  final String _popular_movie_url = 'https://api.themoviedb.org/3/movie/popular?api_key=${Utill.apiKey}&language=en-US&page=1';

  Future<NowPlayingModel> fetchNowShowingMovieList() async {
    try {
      Response response = await _dio.get(_now_playing_url);
      return NowPlayingModel.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return NowPlayingModel.withError("Data not found / Connection issue");
    }
  }

  Future<PopularMovieModel> fetchPopularMovieList() async {
    try {
      Response response = await _dio.get(_popular_movie_url);
      return PopularMovieModel.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return PopularMovieModel.withError("Data not found / Connection issue");
    }
  }
}
