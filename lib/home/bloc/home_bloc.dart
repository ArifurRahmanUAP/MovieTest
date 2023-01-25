import 'package:flutter_bloc/flutter_bloc.dart';

import '../resource/api_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc(): super(HomeInitial()){
    final ApiRepository _apiRepository = ApiRepository();

    on<GetNowShowingMovieList>((event, emit) async {
      try {
        emit(HomeLoading());
        final mList = await _apiRepository.fetchNowShowingMovieList();
        emit(NowPlayingLoaded(mList));
        if (mList.error != null) {
          emit(HomeError(mList.error));
        }
      } on NetworkError {
        emit(const HomeError("Failed to fetch data. is your device online?"));
      }
    });

    on<GetPopularMovieList>((event, emit) async {
      try {
        emit(HomeLoading());
        final mList = await _apiRepository.fetchPopularMovieList();
        emit(PopularMovieLoaded(mList));
        if (mList.error != null) {
          emit(HomeError(mList.error));
        }
      } on NetworkError {
        emit(const HomeError("Failed to fetch data. is your device online?"));
      }
    });

  }
}
