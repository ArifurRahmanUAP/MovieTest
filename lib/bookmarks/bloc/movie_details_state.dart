import 'package:equatable/equatable.dart';
import 'package:movietest/details/model/save_data_model.dart';
import 'package:movietest/home/model/genrsModel.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object?> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<SaveDataModel> saveDataModel;

  const BookmarkLoaded(this.saveDataModel);
}

class BookmarkError extends BookmarkState {
  final String? message;

  const BookmarkError(this.message);
}


abstract class BookmarkGenresState extends Equatable {
  const BookmarkGenresState();

  @override
  List<Object?> get props => [];
}

class BookmarkGenresInitial extends BookmarkGenresState {}

class BookmarkGenresLoading extends BookmarkGenresState {}

class BookmarkGenresLoaded extends BookmarkGenresState {
  final List<GenreModel> genresNameById;

  const BookmarkGenresLoaded(this.genresNameById);
}

class BookmarkGenresError extends BookmarkGenresState {
  final String? message;

  const BookmarkGenresError(this.message);
}
