import 'dart:convert';

SaveDataModel saveDataModelFromJson(String str) => SaveDataModel.fromJson(json.decode(str));

String saveDataModelToJson(SaveDataModel data) => json.encode(data.toJson());

class SaveDataModel {
  SaveDataModel({
    required this.movieId,
    required this.name,
    required this.rating,
    required this.type,
    required this.duration,

  });

  int? movieId;
  String name;
  String rating;
  String type;
  String duration;


  factory SaveDataModel.fromJson(Map<dynamic, dynamic> json) => SaveDataModel(
    movieId: json["movieId"],
    name: json["name"],
    rating: json["rating"],
    type: json["type"],
    duration: json["duration"],

  );

  Map<String, dynamic> toJson() => {
    "movieId": movieId,
    "name": name,
    "rating": rating,
    "type": type,
    "duration": duration,
  };
}
