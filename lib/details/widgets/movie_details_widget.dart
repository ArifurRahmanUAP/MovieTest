import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Util/duration.dart';
import '../../Util/helper.dart';
import '../../Util/util.dart';
import '../../database/database.dart';
import '../model/movie_details_model.dart';
import '../use_case/add_remove_bookmark.dart';

class MovieDetailsWidget extends StatefulWidget {
  MovieDetailsModel model;
  int? movieId;

  MovieDetailsWidget(this.model, this.movieId, {super.key});

  @override
  State<StatefulWidget> createState() => MovieDetailsWidgetState();
}

class MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  StringBuffer saveDatas = StringBuffer();
  late DataBaseHelper dataBaseHelper = DataBaseHelper();
  late bool isSaved;

  Future isSavedMovie() async {
    await dataBaseHelper.init();
    isSaved = await dataBaseHelper.fetchIsBookmarked(widget.movieId);
  }

  @override
  void initState() {
    dataBaseHelper.init();
    isSaved = false;
    isSavedMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          Utill.imageUrl + widget.model.posterPath!,
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
                            stops: const [0.0, 0.0],
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
                                              widget.model.originalTitle
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  SaveDeleteData.onPress(
                                                      context,
                                                      widget.model,
                                                      dataBaseHelper,
                                                      isSaved,
                                                      saveDatas);
                                                  isSaved = !isSaved;

                                                  setState(() {});
                                                },
                                                child: isSaved
                                                    ? const Icon(Icons.bookmark)
                                                    : const Icon(
                                                        Icons.bookmark_border))
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
                                              "${widget.model.voteAverage!.toStringAsFixed(2)}/10 IMDb",
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
                                              itemCount:
                                                  widget.model.genres!.length,
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
                                                          "${widget.model.genres![index].name}"),
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
                                                  DurationCalculate
                                                      .durationToString(
                                                          widget.model.runtime),
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
                                                  widget
                                                      .model
                                                      .spokenLanguages![0]
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
                                                    widget.model.adult!
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
                                        child: Text(
                                            widget.model.overview.toString(),
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
}
