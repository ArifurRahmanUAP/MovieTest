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
    return SafeArea(
        child: Stack(
      children: [
        Image(
          image: NetworkImage(
              "https://image.tmdb.org/t/p/w500${model.posterPath}"),
          fit: BoxFit.cover,
          height: 300,
          width: double.infinity,
        ),
        Container(
          alignment: Alignment.topLeft,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 310),
          child: Expanded(
              child: Column(
            children: [
              Text(
                model.originalTitle.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              Text("${model.voteAverage}/10")
            ],
          )),
        ),
      ],
    ));
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
