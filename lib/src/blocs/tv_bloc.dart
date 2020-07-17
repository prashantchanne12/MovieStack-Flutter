import 'dart:async';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class TvBloc {
  final _popularTv = BehaviorSubject<List<dynamic>>();
  final _arrivingTodayTv = BehaviorSubject<List<dynamic>>();
  final _movieApiProvider = MoviesApiProvider();

  // Add data to stream
  fetchPopularTv(int page) async {
    final tvList = await _movieApiProvider.fetchPopularTv(page);
    _popularTv.sink.add(tvList);
  }

  fetchArrivingTodayTv(int page) async {
    final tvList = await _movieApiProvider.fetchArrivingTodayTv(page);
    _arrivingTodayTv.sink.add(tvList);
  }

  // Retrieve data from stream
  Stream<List<dynamic>> get popularTv => _popularTv.stream;
  Stream<List<dynamic>> get arrivingTodayTv => _arrivingTodayTv.stream;

  dispose() {
    _popularTv.close();
    _arrivingTodayTv.close();
  }
}
