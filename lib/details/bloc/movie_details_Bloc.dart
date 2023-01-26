import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/details/resource/movie_details_api_provider.dart';
import 'package:movietest/details/resource/movie_details_api_repository.dart';

import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  int? movieId;
  MovieDetailsBloc(this.movieId) : super(MovieDetailsInitial()) {
    final MovieDetailsApiRepository movieDetailsApiRepository = MovieDetailsApiRepository();

    on<GetMovieDetails>((event, emit) async {
      try {
        emit(MovieDetailsLoading());
        final mList = await movieDetailsApiRepository.fetchMovieDetails(movieId);
        emit(MovieDetailsLoaded(mList));
        if (mList.error != null) {
          emit(MovieDetailsError(mList.error));
        }
      } on NetworkError {
        emit(const MovieDetailsError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
