import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movietest/home/model/popular_movie_model.dart';

import '../../Util/helper.dart';
import '../../Util/util.dart';
import '../use_case/movie_onClick.dart';

class PopularMovieWidget extends StatefulWidget {
  PopularMovieModel model;

  PopularMovieWidget(this.model, {super.key});

  @override
  State<StatefulWidget> createState() => PopularMovieWidgetState();
}

class PopularMovieWidgetState extends State<PopularMovieWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: SafeArea(
        child: ListView.builder(
            itemCount: widget.model.results!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  MovieClick.onPress(context, widget.model.results![index].id);
                },
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/loading.gif',
                            image:
                                "${Utill.imageUrl}${widget.model.results![index].posterPath}",
                            height: 135,
                            width: 100,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: Helper.getScreenWidth(context) * .55,
                                    child: Text(
                                      widget.model.results![index].originalTitle
                                          .toString(),
                                      softWrap: true,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                      "${widget.model.results![index].voteAverage}/10 IMDb"),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.timer_outlined,
                                    color: Colors.black,
                                  ),
                                  Text(widget.model.results![index].toString())
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
