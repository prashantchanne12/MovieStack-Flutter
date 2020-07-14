import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/models/movie_details_model.dart';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class DetailsBloc {
  final _details = PublishSubject<DetailsModel>();
  final _moviesApiProvider = MoviesApiProvider();

  // Add data to Stream
  fetchDetails(int id, String tvOrMovie) async {
    DetailsModel movieDetails =
        await _moviesApiProvider.fetchDetails(id, tvOrMovie);
    _details.sink.add(movieDetails);
  }

  // Retrieve data from Stream
  Stream<DetailsModel> get details => _details.stream;

  dispose() {
    _details.close();
  }
}

DetailsBloc detailsBloc = DetailsBloc();
