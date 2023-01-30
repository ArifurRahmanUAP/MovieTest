class GenreModel {
  int? genreId;
  String? genreName;

  GenreModel({this.genreId, this.genreName});

  GenreModel.fromJson(Map<String, dynamic> json) {
    genreId = json['genre_id'];
    genreName = json['genre_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genre_id'] = genreId;
    data['genre_name'] = genreName;
    return data;
  }
}