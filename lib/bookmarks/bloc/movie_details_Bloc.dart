import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/bookmarks/resource/movie_details_api_repository.dart';
import 'package:movietest/home/model/genrsModel.dart';
import '../../database/database.dart';
import '../../details/model/save_data_model.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class BookmarkFetchBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkFetchBloc(DataBaseHelper dataBaseHelper) : super(BookmarkInitial()) {
    final BookmarkDataRepository bookmarkDataRepository =
        BookmarkDataRepository();

    on<GetBookmarkDetails>((event, emit) async {
      emit(BookmarkLoading());
      List<SaveDataModel> mList =
          await bookmarkDataRepository.fetchBookmarkData(dataBaseHelper);
      emit(BookmarkLoaded(mList));
    });
  }
}

class BookmarkFetchGenresBloc extends Bloc<BookmarkGenresEvent, BookmarkGenresState> {
  BookmarkFetchGenresBloc(DataBaseHelper dataBaseHelper) : super(BookmarkGenresInitial()) {
    final BookmarkDataRepository bookmarkDataRepository =
        BookmarkDataRepository();

    on<GetBookmarkGenresDetails>((event, emit) async {
      emit(BookmarkGenresLoading());
      List<GenreModel> mList =
          await bookmarkDataRepository.fetchGenresNameById(dataBaseHelper);
      emit(BookmarkGenresLoaded(mList));
    });
  }
}
