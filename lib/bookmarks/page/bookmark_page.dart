import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/bookmarks/bloc/movie_details_Bloc.dart';
import 'package:movietest/bookmarks/bloc/movie_details_event.dart';
import 'package:movietest/bookmarks/bloc/movie_details_state.dart';
import 'package:movietest/details/model/save_data_model.dart';
import 'package:movietest/home/page/home_page.dart';
import '../../Util/helper.dart';
import '../../Util/util.dart';
import '../../database/database.dart';
import '../use_case/bookMark_onClick.dart';
import '../use_case/bookmark_delete_click.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<StatefulWidget> createState() => BookmarkPageState();
}

class BookmarkPageState extends State<BookmarkPage> {
  late BookmarkFetchBloc _bookmarkBloc;
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  late var split;

  @override
  void initState() {
    split = [];
    _bookmarkBloc = BookmarkFetchBloc(dataBaseHelper);
    _bookmarkBloc.add(GetBookmarkDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Bookmark",
          style: TextStyle(color: Colors.black),
        ),
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
        child: BlocListener<BookmarkFetchBloc, BookmarkState>(
          listener: (context, state) {
            if (state is BookmarkError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<BookmarkFetchBloc, BookmarkState>(
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
      child: SafeArea(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: model.length,
            itemBuilder: (context, index) {
              split = model[index].genres?.split(",");
              return GestureDetector(
                onTap: () {
                  BookmarkClick.onPress(context, model[index].movieId);
                },
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/loading.gif',
                                image: "${Utill.imageUrl}${model[index].image}",
                                height: 140,
                                width: 100,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 8,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Helper.getScreenWidth(context) *
                                            .55,
                                        child: Text(
                                          model[index].name.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
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
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ListView.builder(
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
                                                        color: Colors.blue),
                                                  )),
                                              const SizedBox(
                                                width: 3,
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                (BookmarkDeleteClick.onPress(context,
                                    dataBaseHelper, model[index].movieId));

                                model.remove(model[index]);
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 35,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
