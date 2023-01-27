import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/Util/helper.dart';
import 'package:movietest/bookmarks/bloc/movie_details_Bloc.dart';
import 'package:movietest/bookmarks/bloc/movie_details_event.dart';
import 'package:movietest/bookmarks/bloc/movie_details_state.dart';
import 'package:movietest/details/resource/database/save_data_model.dart';

import '../../details/resource/database/database.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<StatefulWidget> createState() => BookmarkPageState();
}

class BookmarkPageState extends State<BookmarkPage> {
  late BookmarkBloc _bookmarkBloc;
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  late var split;

  @override
  void initState() {
    split = [];
    _bookmarkBloc = BookmarkBloc(dataBaseHelper);
    _bookmarkBloc.add(GetBookmarkDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text("Bookmark"),
        elevation: 0,
      ),
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

  Widget buildCard(BuildContext context, List<SaveDataModel> model) {
    return SizedBox(
      height: Helper.getScreenHeight(context),
      child: SafeArea(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: model.length,
            itemBuilder: (context, index) {
              split = model[index].genres?.split(",");

              return Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60))),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${model[index].image}",
                          height: 140,
                          width: 100,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  model[index].name.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text("${model[index].rating}/10 IMDb"),
                                const Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 25,
                              child: Expanded(
                                child: ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: split.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {},
                                              child: Text(
                                                split[index],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              )),
                                          const SizedBox(
                                            width: 3,
                                          )
                                        ],
                                      );
                                    }),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  color: Colors.black,
                                ),
                                Text(model[index].duration.toString())
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _buildLoading() => const Center(
          child: CircularProgressIndicator(
        color: Colors.red,
      ));
}
