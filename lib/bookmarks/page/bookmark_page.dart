import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/bookmarks/bloc/movie_details_Bloc.dart';
import 'package:movietest/bookmarks/bloc/movie_details_event.dart';
import 'package:movietest/bookmarks/bloc/movie_details_state.dart';

import '../../details/resource/database/database.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<StatefulWidget> createState() => BookmarkPageState();
}

class BookmarkPageState extends State<BookmarkPage> {
  late BookmarkBloc _bookmarkBloc;
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  @override
  void initState() {
    _bookmarkBloc = BookmarkBloc(dataBaseHelper);
    _bookmarkBloc.add(GetBookmarkDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBookmark(),
    );
  }

  Widget _buildBookmark() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _bookmarkBloc,
        child: BlocListener<BookmarkBloc, BookmarkState>(
          listener: (context, state) {
            if (state is BookmarkError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (context, state) {
              if (state is BookmarkInitial) {
                return _buildLoading();
              } else if (state is BookmarkLoading) {
                return _buildLoading();
              } else if (state is BookmarkLoaded) {
                return buildCard(context, state.saveDataModel);
              } else if (state is BookmarkError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, dynamic model) {
    print(model);
    return Container(
      child: Text(model[0]["id"]),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator(color: Colors.red,));
}
