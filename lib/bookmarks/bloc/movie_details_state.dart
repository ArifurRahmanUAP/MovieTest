import 'package:equatable/equatable.dart';
import 'package:movietest/details/model/save_data_model.dart';

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
