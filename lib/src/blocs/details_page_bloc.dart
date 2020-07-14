import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/models/cast_model.dart';
import 'package:movie_stack/src/models/movie_details_model.dart';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class DetailsBloc {
  final _details = PublishSubject<DetailsModel>();
  final _cast = PublishSubject<CastModel>();
  final _moviesApiProvider = MoviesApiProvider();

  // Add data to Stream
  fetchDetails(int id, String tvOrMovie) async {
    DetailsModel movieDetails =
        await _moviesApiProvider.fetchDetails(id, tvOrMovie);
    _details.sink.add(movieDetails);
  }

  fetchCast(int id, String tvOrMovie) async {
    CastModel castModel = await _moviesApiProvider.fetchCast(id, tvOrMovie);
    _cast.sink.add(castModel);
  }

  // Retrieve data from Stream
  Stream<DetailsModel> get details => _details.stream;
  Stream<CastModel> get cast => _cast.stream;

  dispose() {
    _details.close();
    _cast.close();
  }
}

DetailsBloc detailsBloc = DetailsBloc();
