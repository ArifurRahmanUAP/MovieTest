import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/app_drawer/app_drawer.dart';
import 'package:movietest/home/bloc/home_bloc.dart';
import 'package:movietest/home/bloc/home_event.dart';
import 'package:movietest/home/bloc/home_state.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popular_movie_model.dart';

import '../../Util/helper.dart';
import '../use_case/movie_onClick.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(GetNowShowingMovieList());
    Future.delayed(const Duration(milliseconds: 200))
        .then((valueFuture) => _homeBloc.add(GetPopularMovieList()));
    // _homeBloc.add(GetNowShowingMovieList());
    // _homeBloc.add(GetPopularMovieList());
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
      child: Stack(
        children: [
          BlocProvider(
            create: (_) => _homeBloc,
            child:
                BlocListener<HomeBloc, HomeState>(listener: (context, state) {
              if (state is HomeError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            }, child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeInitial) {
                  return _buildLoading();
                } else if (state is HomeLoading) {
                  return _buildLoading();
                }
                if (state is NowPlayingLoaded) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 25,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Now Showing",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'See More',
                                        style: TextStyle(color: Colors.black26),
                                      ),
                                    )),
                              ],
                            )),
                        SizedBox(
                          height: 300,
                          child:
                              _buildNowPlaying(context, state.nowPlayingModel),
                        ),
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Popular",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ))
                      ],
                    ),
                  );
                }
                if (state is PopularMovieLoaded) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        _buildPopular(context, state.popularMovieModel),
                      ],
                    ),
                  );
                } else if (state is HomeError) {
                  return Container();
                } else {
                  return Container();
                }
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildNowPlaying(BuildContext context, NowPlayingModel model) {
    return ListView.builder(
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
      margin: EdgeInsets.only(top: 300),
      height: 300,
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
                              // SizedBox(
                              //   height: 25,
                              //   child: Expanded(
                              //     child: ListView.builder(
                              //         physics: const ClampingScrollPhysics(),
                              //         shrinkWrap: true,
                              //         scrollDirection: Axis.horizontal,
                              //         itemCount: split.length,
                              //         itemBuilder: (context, index) {
                              //           return Row(
                              //             children: [
                              //               OutlinedButton(
                              //                   onPressed: () {},
                              //                   child: Text(
                              //                     split[index],
                              //                     style: const TextStyle(
                              //                         color: Colors.black),
                              //                   )),
                              //               const SizedBox(
                              //                 width: 3,
                              //               )
                              //             ],
                              //           );
                              //         }),
                              //   ),
                              // ),
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
}
