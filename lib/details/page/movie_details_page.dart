import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/details/bloc/movie_details_state.dart';
import 'package:movietest/details/model/movie_details_model.dart';
import 'package:movietest/details/model/save_data_model.dart';
import 'package:movietest/home/bloc/home_state.dart';

import '../../Util/colors.dart';
import '../../Util/helper.dart';
import '../bloc/movie_details_Bloc.dart';
import '../bloc/movie_details_event.dart';
import '../resource/database/database.dart';
import '../use_case/save_data.dart';

class MovieDetails extends StatefulWidget {
  int? movieId;

  MovieDetails(this.movieId, {super.key});

  @override
  State<StatefulWidget> createState() => _MovieState();
}

class _MovieState extends State<MovieDetails> {
  late MovieDetailsBloc _movieDetailsBloc;
  late DataBaseHelper dataBaseHelper = DataBaseHelper();
  StringBuffer saveDatas = StringBuffer();

  @override
  void initState() {
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
                body: _buildCard(context, state.movieDetailsModel),
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
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: Helper.getScreenHeight(context) * 0.5,
                        width: Helper.getScreenWidth(context),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${model.posterPath}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: Helper.getScreenHeight(context) * 0.5,
                        width: Helper.getScreenWidth(context),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.0],
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Helper.getScreenHeight(context) * 0.25,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Container(
                                  height:
                                      Helper.getScreenHeight(context) * .631,
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              model.originalTitle.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  for (var value
                                                      in model.genres!) {
                                                    saveDatas.write("${value.name},");
                                                  }

                                                  SaveDataModel saveDataModel =
                                                      SaveDataModel(
                                                          movieId: model.id,
                                                          name: model
                                                              .originalTitle
                                                              .toString(),
                                                          rating: model
                                                              .voteAverage
                                                              .toString(),
                                                          genres: saveDatas.toString().substring(0, saveDatas.length - 1),
                                                          duration:
                                                              durationToString(
                                                                  model
                                                                      .runtime),
                                                          image: model
                                                              .posterPath
                                                              .toString());
                                                  SaveData.onPress(
                                                      context,
                                                      saveDataModel,
                                                      dataBaseHelper);
                                                },
                                                child:
                                                    const Icon(Icons.bookmark))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            Text(
                                              "${model.voteAverage}/10 IMDb",
                                              style: const TextStyle(
                                                  color: Colors.black38),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: SizedBox(
                                          height: 40,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              padding: const EdgeInsets.all(5),
                                              itemCount: model.genres!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(
                                                    child: Row(
                                                  children: [
                                                    Center(
                                                        child: OutlinedButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                          "${model.genres![index].name}"),
                                                    )),
                                                    const SizedBox(
                                                      width: 8,
                                                    )
                                                  ],
                                                ));
                                              }),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Length",
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  durationToString(
                                                      model.runtime),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Language",
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                ),
                                                Text(
                                                  model.spokenLanguages![0]
                                                      .englishName
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Rating",
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                ),
                                                Text(
                                                    model.adult!
                                                        ? "R"
                                                        : "PG-13",
                                                    style: const TextStyle(
                                                        color: Colors.black)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Description",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(model.overview.toString(),
                                            style: const TextStyle(
                                                color: Colors.black38)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  String durationToString(int? minutes) {
    var d = Duration(minutes: minutes!);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}min';
  }
}
