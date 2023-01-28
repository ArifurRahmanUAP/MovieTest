import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popular_movie_model.dart';

import 'home_api_provider.dart';

class HomeApiRepository {
  final ApiProvider apiProvider;
  HomeApiRepository(this.apiProvider);

  Future<List<NowPlayingModel>> fetchNowShowingMovieList(int page) async {
    final posts = await apiProvider.fetchNowShowingMovieList(page);
    return posts.map((e) => NowPlayingModel.fromJson(e)).toList();
  }

  // Future<PopularMovieModel> fetchPopularMovieList() {
  //   return apiProvider.fetchPopularMovieList(1);
  // }
}

// class NetworkError extends Error {}
