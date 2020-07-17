import 'dart:async';
import 'package:movie_stack/src/models/cast_model.dart';
import 'package:movie_stack/src/models/movie_details_model.dart';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class DetailsBloc {
  final _details = PublishSubject<DetailsModel>();
  final _cast = PublishSubject<CastModel>();
  final _reviews = PublishSubject<List<dynamic>>();
  final _similar = PublishSubject<List<dynamic>>();
  final _moviesApiProvider = MoviesApiProvider();

  // Add data to Stream
  fetchDetails(int id, String tvOrMovie) async {
    DetailsModel movieDetails =
        await _moviesApiProvider.fetchDetails(id, tvOrMovie);
    _details.sink.add(movieDetails);
  }

  fetchCast(int id, String tvOrMovie) async {
    CastModel castModel = await _moviesApiProvider.fetchCast(id, tvOrMovie);
    print(castModel.cast.length);
    _cast.sink.add(castModel);
  }

  fetchReviews(int id) async {
    final reviewsList = await _moviesApiProvider.fetchReviews(id);
    _reviews.sink.add(reviewsList);
  }

  fetchSimilar(int id, String tvOrMovie) async {
    final similarList = await _moviesApiProvider.fetchSimilar(id, tvOrMovie);
    _similar.sink.add(similarList);
  }

  // Retrieve data from Stream
  Stream<DetailsModel> get details => _details.stream;
  Stream<CastModel> get cast => _cast.stream;
  Stream<List<dynamic>> get reviews => _reviews.stream;
  Stream<List<dynamic>> get similar => _similar.stream;

  dispose() {
    _details.close();
    _cast.close();
    _reviews.close();
    _similar.close();
  }
}
