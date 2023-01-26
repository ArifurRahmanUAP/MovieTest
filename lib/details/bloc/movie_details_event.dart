import 'package:equatable/equatable.dart';

abstract class MovieDetailsEvent extends Equatable{
  const MovieDetailsEvent();

  @override
  List<Object> get props =>[];
}

class GetMovieDetails extends MovieDetailsEvent {}
