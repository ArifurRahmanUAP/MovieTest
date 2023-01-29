import 'package:flutter_bloc/flutter_bloc.dart';
import '../resource/home_api_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    final HomeApiRepository _apiRepository = HomeApiRepository();

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
  }
}

class Home1Bloc extends Bloc<Home1Event, Home1State> {
  Home1Bloc() : super(Home1Initial()) {
    final HomeApiRepository _apiRepository = HomeApiRepository();

    on<GetPopularMovieList>((event, emit) async {
      try {
        emit(Home1Loading());
        final mList = await _apiRepository.fetchPopularMovieList();
        emit(PopularMovieLoaded(mList));
        if (mList.error != null) {
          emit(Home1Error(mList.error));
        }
      } on NetworkError {
        emit(const Home1Error("Failed to fetch data. is your device online?"));
      }
    });
  }
}
