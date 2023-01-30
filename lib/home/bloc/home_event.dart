import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
   HomeEvent();

  @override
  List<Object> get props =>[];
}

class GetNowShowingMovieList extends HomeEvent {
int pageNumber;
  GetNowShowingMovieList(this.pageNumber);
}




abstract class Home1Event extends Equatable{
   Home1Event();

  @override
  List<Object> get props =>[];
}

class GetPopularMovieList extends Home1Event {}
