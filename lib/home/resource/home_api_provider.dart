import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movietest/Util/util.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popular_movie_model.dart';
import 'package:http/http.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchNowShowingMovieList(int page) async {
    final String _nowPlayingUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=${Utill.apiKey}&language=en-US&page=$page';
      try {
        final response = await get(Uri.parse(_nowPlayingUrl));
        return jsonDecode(response.body) as List<dynamic>;
      } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return [];
    }
  }

  Future<Object> fetchPopularMovieList(int page) async {
    final String _popularMovieUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${Utill.apiKey}&language=en-US&page=$page';

    try {
      final response = await get(Uri.parse(_popularMovieUrl));
      return jsonDecode(response.body) as List<dynamic>;
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return PopularMovieModel.withError("Data not found / Connection issue");
    }
  }
}
