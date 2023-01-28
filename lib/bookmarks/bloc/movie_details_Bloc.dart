import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/bookmarks/resource/movie_details_api_repository.dart';
import '../../details/resource/database/database.dart';
import '../../details/model/save_data_model.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc(DataBaseHelper dataBaseHelper) : super(BookmarkInitial()) {
    final BookmarkDataRepository bookmarkDataRepository = BookmarkDataRepository();

    on<GetBookmarkDetails>((event, emit) async {
        emit(BookmarkLoading());
        List<SaveDataModel> mList = await bookmarkDataRepository.fetchBookmarkData(dataBaseHelper);
        emit(BookmarkLoaded(mList));
    });
    //
    // on<DeleteBookmarks>((event, emit) async {
    //     emit(BookmarkLoading());
    //      bookmarkDataRepository.deleteBookmarkData(dataBaseHelper);
    // });
  }
}
