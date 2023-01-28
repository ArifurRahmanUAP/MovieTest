import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/home/bloc/home_state.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/resource/home_api_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(HomeInitial());

  int page = 1;
  final HomeApiRepository repository;

  void loadPosts() {
    if (state is HomeLoading) return;

    final currentState = state;

    var oldPosts = <NowPlayingModel>[];
    if (currentState is NowPlayingLoaded) {
      oldPosts = currentState.posts;
    }

    emit(HomeLoading(oldPosts, isFirstFetch: page == 1));

    repository.fetchNowShowingMovieList(page).then((newPosts) {
      page++;

      final posts = (state as HomeLoading).oldPosts;
      posts.addAll(newPosts);

      emit(NowPlayingLoaded(posts));
    });
  }

}
