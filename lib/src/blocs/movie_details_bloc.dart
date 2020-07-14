import 'dart:async';
import 'package:movie_stack/src/models/movie_details_model.dart';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsBloc {
  final _movieDetails = PublishSubject<MovieDetailsModel>();
  final _moviesApiProvider = MoviesApiProvider();

  // Add data to Stream
  fetchMovieDetails(int id) async {
    MovieDetailsModel movieDetails =
        await _moviesApiProvider.fetchMovieDetails(id);
    _movieDetails.sink.add(movieDetails);
  }

  // Retrieve data from Stream
  Stream<MovieDetailsModel> get movie => _movieDetails.stream;

  dispose() {
    _movieDetails.close();
  }
}

MovieDetailsBloc movieDetailsBloc = MovieDetailsBloc();
