
import 'package:equatable/equatable.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popularMoviwModel.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class NowPlayingLoaded extends HomeState {
  final NowPlayingModel nowPlayingModel;
  const NowPlayingLoaded(this.nowPlayingModel);
}

class PopularMovieLoaded extends HomeState {
  final PopularMovieModel popularMovieModel;
  const PopularMovieLoaded(this.popularMovieModel);
}

class HomeError extends HomeState {
  final String? message;
  const HomeError(this.message);
}
