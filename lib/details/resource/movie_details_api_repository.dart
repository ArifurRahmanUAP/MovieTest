import 'package:movietest/details/model/movie_details_model.dart';

import 'movie_details_api_provider.dart';

class MovieDetailsApiRepository {
  final _provider = MovieDetailsApiProvider();

  Future<MovieDetailsModel> fetchMovieDetails() {
    return _provider.fetchMovieDetails();
  }
}

class NetworkError extends Error {}
