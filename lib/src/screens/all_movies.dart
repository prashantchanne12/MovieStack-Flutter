import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/movies_bloc.dart';
import 'package:movie_stack/src/blocs/movies_provider.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/movie_model.dart';

var movies = [];
String position = '';
int page = 1;

class AllMovies extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final int which;

  AllMovies({@required this.which});

  @override
  Widget build(BuildContext context) {
    MoviesBloc moviesBloc = MoviesProvider.of(context);

    _scrollListener() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        page++;
        print('end...');
        moviesBloc.fetchMovies(page, which);
      }
    }

    _scrollController.addListener(_scrollListener);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: stream(moviesBloc),
    );
  }

  stream(MoviesBloc moviesBloc) {
    return StreamBuilder(
      stream: moviesBloc.movies,
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Text(
            'Loading',
            style: TextStyle(
              color: Colors.white,
            ),
          );
        }
        movies.addAll(snapshot.data);
        return ListView.builder(
          controller: _scrollController,
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            MovieModel model = MovieModel.fromJson(movies[index]);
            return Container(
              height: 120.0,
              child: Text(
                model.title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
