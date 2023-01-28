import 'package:equatable/equatable.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popular_movie_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];}

class HomeLoading extends HomeState {
  final List<NowPlayingModel> oldPosts;
  final bool isFirstFetch;

  const HomeLoading(this.oldPosts, {this.isFirstFetch=false});
}

class NowPlayingLoaded extends HomeState {
  final List<NowPlayingModel> posts;

  const NowPlayingLoaded(this.posts);
}


class HomeError extends HomeState {
  final String? message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [];
}


abstract class Home1State extends Equatable {
  const Home1State();

  @override
  List<Object?> get props => [];
}

class Home1Initial extends Home1State {}

class Home1Loading extends Home1State {}

class PopularMovieLoaded extends Home1State {
  final PopularMovieModel popularMovieModel;
  const PopularMovieLoaded(this.popularMovieModel);
}

class Home1Error extends Home1State {
  final String? message;
  const Home1Error(this.message);
}
