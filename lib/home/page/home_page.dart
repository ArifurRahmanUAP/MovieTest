import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/Util/helper.dart';
import 'package:movietest/Util/util.dart';
import 'package:movietest/app_drawer/app_drawer.dart';
import 'package:movietest/home/bloc/home_bloc.dart';
import 'package:movietest/home/bloc/home_event.dart';
import 'package:movietest/home/bloc/home_state.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popular_movie_model.dart';
import 'package:movietest/home/widgets/now_playing_widget.dart';
import '../use_case/movie_onClick.dart';
import '../widgets/popular_movie_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _pageNumber = 1;
  late final HomeBloc _homeBloc = HomeBloc();
  final Home1Bloc _home1Bloc = Home1Bloc();

  @override
  void initState() {
    _homeBloc.add(GetNowShowingMovieList(_pageNumber));
    _home1Bloc.add(GetPopularMovieList());
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
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_open_sharp,
              color: Colors.black,
            ),
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
            BlocProvider(
              create: (_) => _homeBloc,
              child: BlocListener<HomeBloc, HomeState>(
                  listener: (context, state) {
                    if (state is HomeError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message!),
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeInitial) {
                            return _buildLoading();
                          } else if (state is HomeLoading) {
                            return _buildLoading();
                          }
                          if (state is NowPlayingLoaded) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 25,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Now Showing",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: OutlinedButton(
                                                onPressed: () {},
                                                child: const Text(
                                                  'See More',
                                                  style: TextStyle(
                                                      color: Colors.black26),
                                                ),
                                              )),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 300,
                                    child: NowPlayingWidget(state.nowPlayingModel)
                                  ),
                                  const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Popular",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ))
                                ],
                              ),
                            );
                          } else if (state is HomeError) {
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  )),
            ),
            BlocProvider(
              create: (_) => _home1Bloc,
              child: BlocListener<Home1Bloc, Home1State>(
                listener: (context, state) {
                  if (state is Home1Error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message!),
                      ),
                    );
                  }
                },
                child: Expanded(
                  child: BlocBuilder<Home1Bloc, Home1State>(
                    builder: (context, state) {
                      if (state is Home1Initial) {
                        return _buildLoading();
                      } else if (state is Home1Loading) {
                        return _buildLoading();
                      }
                      if (state is PopularMovieLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            child: PopularMovieWidget(state.popularMovieModel)
                          ),
                        );
                      } else if (state is Home1Error) {
                        return Container();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
