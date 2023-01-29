import 'package:equatable/equatable.dart';
import 'package:movietest/details/model/movie_details_model.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object?> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}


class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsModel movieDetailsModel;
  const MovieDetailsLoaded(this.movieDetailsModel);
}

class MovieDetailsError extends MovieDetailsState {
  final String? message;
  const MovieDetailsError(this.message);
}
