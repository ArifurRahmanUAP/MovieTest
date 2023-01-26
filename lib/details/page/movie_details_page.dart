import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/details/bloc/movie_details_state.dart';
import 'package:movietest/details/model/movie_details_model.dart';
import 'package:movietest/home/bloc/home_state.dart';

import '../bloc/movie_details_Bloc.dart';
import '../bloc/movie_details_event.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<StatefulWidget> createState() => _MovieState();
}

class _MovieState extends State<MovieDetails> {
  final MovieDetailsBloc _movieDetailsBloc = MovieDetailsBloc();

  @override
  void initState() {
    _movieDetailsBloc.add(GetMovieDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMovieDetails(),
    );
  }

  Widget _buildMovieDetails() {
    return BlocProvider(
      create: (_) => _movieDetailsBloc,
      child: BlocListener<MovieDetailsBloc, MovieDetailsState>(
        listener: (context, state) {
          if (state is MovieDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              return _buildLoading();
            } else if (state is MovieDetailsLoading) {
              return _buildLoading();
            } else if (state is MovieDetailsLoaded) {
              return SizedBox(
                child: SizedBox(
                  child: _buildCard(context, state.movieDetailsModel),
                ),
              );
            } else if (state is HomeError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, MovieDetailsModel model) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Image(
            image: NetworkImage(
                "https://image.tmdb.org/t/p/w500${model.posterPath}"),
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration:  const BoxDecoration(
                  borderRadius:  BorderRadius.only(
                      topLeft:    Radius.circular(40.0),
                      topRight:   Radius.circular(40.0))
              ),
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Text(
                      model.originalTitle.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text("${model.voteAverage}/10")
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(8),
                          itemCount: model.genres!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                                child: Row(
                              children: [
                                Center(
                                    child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text("${model.genres![index].name}"),
                                )),
                                const SizedBox(
                                  width: 8,
                                )
                              ],
                            ));
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Length",
                                style: TextStyle(color: Colors.black38),
                              )
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                "Language",
                                style: TextStyle(color: Colors.black38),
                              )
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                "Rating",
                                style: TextStyle(color: Colors.black38),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                durationToString(model.runtime),
                                style: const TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                model.spokenLanguages![0].englishName!,
                                style: const TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                model.adult! ? "R" : "PG-13",
                                style: const TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(model.overview.toString(),
                        style: const TextStyle(color: Colors.black38)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  String durationToString(int? minutes) {
    var d = Duration(minutes: minutes!);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}min';
  }
}
