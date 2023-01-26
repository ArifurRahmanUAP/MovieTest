import 'package:flutter/widgets.dart';

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
    // TODO: implement build
    throw UnimplementedError();
  }
}
