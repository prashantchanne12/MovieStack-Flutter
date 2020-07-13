import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/home_bloc.dart';
import 'package:movie_stack/src/models/movie_model.dart';
import 'package:movie_stack/src/models/trending_model.dart';
import 'package:movie_stack/src/models/tv_model.dart';
import 'package:movie_stack/src/resources/movies_api_provider.dart';

MoviesApiProvider moviesApiProvider = MoviesApiProvider();

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    homeBloc.fetchTrendingMovies();
//    homeBloc.fetchTrendingTV();
    homeBloc.fetchTrending();

    return Scaffold(
      body: StreamBuilder(
        stream: homeBloc.trending,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              TrendingModel trendingModel =
                  TrendingModel.fromJson(snapshot.data[index]);
              bool isMovie = trendingModel.media_type == 'movie';
              return ListTile(
                title: Text(isMovie ? trendingModel.title : trendingModel.name),
              );
            },
          );
        },
      ),
    );
  }
}
