import 'package:flutter/material.dart';
import 'package:movietest/details/page/movie_details_page.dart';

class MovieClick {
  static onPress(BuildContext context, int? movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetails(movieId)),
    );

  }

}

