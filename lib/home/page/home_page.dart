import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/home/bloc/home_bloc.dart';
import 'package:movietest/home/bloc/home_event.dart';
import 'package:movietest/home/bloc/home_state.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';

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
    _homeBloc.add(GetPopularMovieList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Movie List')),
      body: _buildListHome(),
    );
  }

  Widget _buildListHome() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
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
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeInitial) {
                return _buildLoading();
              } else if (state is HomeLoading) {
                return _buildLoading();
              } else if (state is NowPlayingLoaded) {
                return Column(
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
                      height: 270,
                      child: _buildCard(context, state.nowPlayingModel),
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Popular",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ))
                  ],
                );
              } else if (state is HomeError) {
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

  Widget _buildCard(BuildContext context, NowPlayingModel model) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: model.results!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            // MovieClick.onTap(model.results![index].id);
            MovieClick.onTap(model, index);
          },
          child: Container(
            width: 150,
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    height: 160,
                    child: Image.network("https://image.tmdb.org/t/p/w500${model.results![index].posterPath}"),),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  model.results![index].originalTitle.toString(),
                  softWrap: true,
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
