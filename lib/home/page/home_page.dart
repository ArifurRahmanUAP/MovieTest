import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/app_drawer/app_drawer.dart';
import 'package:movietest/home/bloc/home_bloc.dart';
import 'package:movietest/home/bloc/home_event.dart';
import 'package:movietest/home/bloc/home_state.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popular_movie_model.dart';
import '../bloc/cubit/home_cubit.dart';
import '../use_case/movie_onClick.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  // final HomeBloc _homeBloc = HomeBloc();
  // final Home1Bloc _home1Bloc = Home1Bloc();

  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<HomeCubit>(context).loadPosts();
        }
      }
    });
  }

  @override
  void initState() {
    // _homeBloc.add(GetNowShowingMovieList());
    // _homeBloc.add(GetNowShowingMovieList());
    // _home1Bloc.add(GetPopularMovieList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Movie List',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_open_sharp),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(13),
            child: Image.asset(
              "assets/notification.png",
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: _buildListHome(),
      drawer: AppDrawer(),
    );
  }

  Widget _buildListHome() {
    return Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              if (state is HomeLoading && state.isFirstFetch) {
                return _buildLoading();
              }

              List<NowPlayingModel> posts = [];
              bool isLoading = false;

              if (state is HomeLoading) {
                posts = state.oldPosts;
                isLoading = true;
              } else if (state is NowPlayingLoaded) {
                posts = state.posts;
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < posts.length)
                    return _post(posts[index], context);
                  else {
                    Timer(Duration(milliseconds: 30), () {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    });

                    return _buildLoading();
                  }
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey[400],
                  );
                },
                itemCount: posts.length + (isLoading ? 1 : 0),
              );
            }),
            // Expanded(
            //   child: BlocBuilder<Home1Bloc, Home1State>(
            //     builder: (context, state) {
            //       if (state is Home1Initial) {
            //         return _buildLoading();
            //       } else if (state is Home1Loading) {
            //         return _buildLoading();
            //       }
            //       if (state is PopularMovieLoaded) {
            //         return Padding(
            //           padding: const EdgeInsets.all(5),
            //           child: SizedBox(
            //             child:
            //             _buildPopular(context, state.popularMovieModel),
            //           ),
            //         );
            //       } else if (state is Home1Error) {
            //         return Container();
            //       } else {
            //         return Container();
            //       }
            //     },
            //   ),
            // ),
          ],
        ));
  }

  Widget _buildNowPlaying(BuildContext context, NowPlayingModel model) {
    return ListView.builder(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: model.results!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // MovieClick.onTap(model.results![index].id);
            MovieClick.onPress(context, model.results![index].id);
          },
          child: Container(
            width: 180,
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${model.results![index].posterPath}",
                      fit: BoxFit.cover,
                      width: 180,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  model.results![index].originalTitle.toString(),
                  softWrap: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text("${model.results![index].voteAverage} /10")
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopular(BuildContext context, PopularMovieModel model) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: SafeArea(
        child: ListView.builder(
            itemCount: model.results!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  MovieClick.onPress(context, model.results![index].id);
                },
                child: Card(
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
                            "https://image.tmdb.org/t/p/w500${model.results![index].posterPath}",
                            height: 135,
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
                                    model.results![index].originalTitle
                                        .toString(),
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
                                  Text(
                                      "${model.results![index].voteAverage}/10 IMDb"),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
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
                                  Text(model.results![index].toString())
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _post(NowPlayingModel post, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${post.results}. ${post.dates}",
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(post.totalPages.toString())
        ],
      ),
    );
  }
}
