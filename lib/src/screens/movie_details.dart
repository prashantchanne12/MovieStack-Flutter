import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/movie_details_bloc.dart';
import '../models/movie_details_model.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: movieDetailsBloc.movie,
        builder:
            (BuildContext context, AsyncSnapshot<MovieDetailsModel> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          MovieDetailsModel movieDetailsModel = snapshot.data;
          return Center(child: Text(movieDetailsModel.title));
        },
      ),
    );
  }
}
