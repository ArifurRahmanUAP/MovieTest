import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popular_movie_model.dart';

import 'home_api_provider.dart';

class HomeApiRepository {
  final _provider = ApiProvider();

  Future<NowPlayingModel> fetchNowShowingMovieList(int page) {
    return _provider.fetchNowShowingMovieList(page);
  }

  Future<PopularMovieModel> fetchPopularMovieList() {
    return _provider.fetchPopularMovieList();
  }
}

class NetworkError extends Error {}
