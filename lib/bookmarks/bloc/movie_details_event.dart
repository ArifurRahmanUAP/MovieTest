import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable{
  const BookmarkEvent();

  @override
  List<Object> get props =>[];
}

class GetBookmarkDetails extends BookmarkEvent {}
