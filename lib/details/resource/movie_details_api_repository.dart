import 'package:movietest/details/model/movie_details_model.dart';
import 'movie_details_api_provider.dart';

class MovieDetailsApiRepository {
  final _provider = MovieDetailsApiProvider();
  int? movieId;

  Future<MovieDetailsModel> fetchMovieDetails(movieId) {
    return _provider.fetchMovieDetails(movieId);
  }
}

class NetworkError extends Error {}
