import 'dart:async';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class TvBloc {
  final _popularTv = BehaviorSubject<List<dynamic>>();
  final _movieApiProvider = MoviesApiProvider();

  // Add data to stream
  fetchPopularTv(int page) async {
    final tvList = await _movieApiProvider.fetchPopularTv(page);
    _popularTv.sink.add(tvList);
  }

  // Retrieve data from stream
  Stream<List<dynamic>> get popularTv => _popularTv.stream;

  dispose() {
    _popularTv.close();
  }
}
