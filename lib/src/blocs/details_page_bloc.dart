import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/models/movie_details_model.dart';
import 'package:movie_stack/src/models/tv_details_model.dart';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsBloc {
  final _movieDetails = PublishSubject<MovieDetailsModel>();
  final _tvDetails = PublishSubject<TvDetailsModel>();
  final _moviesApiProvider = MoviesApiProvider();

  // Add data to Stream
  fetchMovieDetails(int id) async {
    MovieDetailsModel movieDetails =
        await _moviesApiProvider.fetchMovieDetails(id);
    _movieDetails.sink.add(movieDetails);
  }

  fetchTvDetails(int id) async {
    TvDetailsModel tvDetailsModel = await _moviesApiProvider.fetchTvDetails(id);
    _tvDetails.sink.add(tvDetailsModel);
  }

  // Retrieve data from Stream
  Stream<MovieDetailsModel> get movie => _movieDetails.stream;
  Stream<TvDetailsModel> get tv => _tvDetails.stream;

  dispose() {
    _movieDetails.close();
    _tvDetails.close();
  }
}

MovieDetailsBloc movieDetailsBloc = MovieDetailsBloc();