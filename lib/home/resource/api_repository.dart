import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popularMoviwModel.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<NowPlayingModel> fetchNowShowingMovieList() {
    return _provider.fetchNowShowingMovieList();
  }

  Future<PopularMovieModel> fetchPopularMovieList() {
    return _provider.fetchPopularMovieList();
  }
}

class NetworkError extends Error {}
