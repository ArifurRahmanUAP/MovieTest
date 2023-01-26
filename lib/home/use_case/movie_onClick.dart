import '../model/nowPlayingModel.dart';

class MovieClick {
  static onTap(NowPlayingModel movieId, int index){
    print(movieId.results![index].originalTitle);

  }

}

