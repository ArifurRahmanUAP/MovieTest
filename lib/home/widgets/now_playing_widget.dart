import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Util/util.dart';
import '../model/nowPlayingModel.dart';
import '../use_case/movie_onClick.dart';

class NowPlayingWidget extends StatefulWidget {
  NowPlayingModel model;

  NowPlayingWidget(this.model);

  @override
  State<StatefulWidget> createState() => NowPlayingState();

}

class NowPlayingState extends State<NowPlayingWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.model.results!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // MovieClick.onTap(model.results![index].id);
            MovieClick.onPress(context, widget.model.results![index].id);
          },
          child: Container(
            width: 180,
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.gif',
                      image:
                      "${Utill.imageUrl}${widget.model.results![index].posterPath}",
                      width: 140,
                      height: 160,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  widget.model.results![index].originalTitle.toString(),
                  softWrap: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text("${widget.model.results![index].voteAverage} /10")
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}