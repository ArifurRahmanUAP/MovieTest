import 'dart:convert';

SaveDataModel saveDataModelFromJson(String str) => SaveDataModel.fromJson(json.decode(str));

String saveDataModelToJson(SaveDataModel data) => json.encode(data.toJson());

class SaveDataModel {
  SaveDataModel({
     this.movieId,
     this.name,
     this.rating,
     this.genres,
     this.duration,
     this.image,

  });

  int? movieId;
  String? name;
  String? rating;
  String? genres;
  String? duration;
  String? image;


  factory SaveDataModel.fromJson(Map<dynamic, dynamic> json) => SaveDataModel(
    movieId: json["movieId"],
    name: json["name"],
    rating: json["rating"],
    genres: json["genres"],
    duration: json["duration"],
    image: json["image"],

  );

  Map<String, dynamic> toJson() => {
    "movieId": movieId,
    "name": name,
    "rating": rating,
    "genres": genres,
    "duration": duration,
    "image": image
  };
}
