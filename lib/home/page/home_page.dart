import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietest/home/bloc/home_bloc.dart';
import 'package:movietest/home/bloc/home_event.dart';
import 'package:movietest/home/bloc/home_state.dart';
import 'package:movietest/home/model/nowPlayingModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(GetNowShowingMovieList());
    _homeBloc.add(GetPopularMovieList());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Movie List')),
      body: _buildListHome(),
    );
  }

  Widget _buildListHome() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _homeBloc,
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeInitial) {
                return _buildLoading();
              } else if (state is HomeLoading) {
                return _buildLoading();
              } else if (state is NowPlayingLoaded) {
                return Column(
                  children: [
                    Container(
                      height: 20,
                      child: Text("Now Showing"),
                    ),
                    Container(
                      height: 300,
                      child: _buildCard(context, state.nowPlayingModel),
                    )
                  ],
                );
              } else if (state is HomeError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, NowPlayingModel model) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: model.results!.length,
      itemBuilder: (context, index) {
        return Container(
          width: 300,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 196, 193, 193), width: 0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Original Title: ${model.results![index].originalTitle}"
                    .toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "OverView: ${model.results![index].overview}".toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "Title: ${model.results![index].title}".toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "Vote: ${model.results![index].voteCount}".toUpperCase(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
