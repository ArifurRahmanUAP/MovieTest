import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/details/bloc/movie_details_state.dart';
import 'package:movietest/home/bloc/home_state.dart';
import '../bloc/movie_details_Bloc.dart';
import '../bloc/movie_details_event.dart';
import '../resource/database/database.dart';
import '../widgets/movie_details_widget.dart';

class MovieDetails extends StatefulWidget {
  int? movieId;
  MovieDetails(this.movieId, {super.key});

  @override
  State<StatefulWidget> createState() => _MovieState();
}

class _MovieState extends State<MovieDetails> {
  late bool isSaved;
  late MovieDetailsBloc _movieDetailsBloc;
  late DataBaseHelper dataBaseHelper = DataBaseHelper();

  Future isSavedMovie() async {
    await dataBaseHelper.init();
    isSaved = await dataBaseHelper.fetchIsBookmarked(widget.movieId);
  }

  @override
  void initState() {
    isSavedMovie();
    isSaved = false;
    _movieDetailsBloc = MovieDetailsBloc(widget.movieId);
    _movieDetailsBloc.add(GetMovieDetails());
    dataBaseHelper.init();
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
              return Scaffold(
                body: MovieDetailsWidget(state.movieDetailsModel, isSaved, dataBaseHelper),
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


  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
