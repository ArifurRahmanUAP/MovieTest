import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/home/bloc/home_bloc.dart';
import 'package:movietest/home/bloc/home_event.dart';
import 'package:movietest/home/bloc/home_state.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';
import 'package:movietest/home/model/popular_movie_model.dart';
import 'package:movietest/home/use_case/movie_onClick.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc()..add(GetNowShowingMovieList()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Test'),
          ),
          body: Stack(
            children: [
              Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () =>
                              context.read<HomeBloc>().add( GetNowShowingMovieList()),
                          child: const Text("Event1")),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () => context
                              .read<HomeBloc>()
                              .add(GetPopularMovieList()),
                          child: const Text("Event2")),
                      const SizedBox(width: 10),
                    ],
                  ),
                );
              }),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is NowPlayingLoaded) {
                    return const Center(child: Text("I am state 1"));
                  }
                  return const SizedBox.shrink();
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is PopularMovieLoaded) {
                        return Center(
                            child: Text("I am state 2 state.message"));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
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
      margin: const EdgeInsets.only(top: 300),
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
}