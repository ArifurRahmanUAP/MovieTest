import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  List<Object> get props =>[];
}

class GetNowShowingMovieList extends HomeEvent {}
class GetPopularMovieList extends HomeEvent {}
