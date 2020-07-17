import 'dart:async';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class TvBloc {
  final _popularTv = BehaviorSubject<List<dynamic>>();
  final _airingTodayTv = BehaviorSubject<List<dynamic>>();
  final _topRatedTv = BehaviorSubject<List<dynamic>>();
  final _movieApiProvider = MoviesApiProvider();

  // Add data to stream
  fetchPopularTv(int page) async {
    final tvList = await _movieApiProvider.fetchPopularTv(page);
    _popularTv.sink.add(tvList);
  }

  fetchArrivingTodayTv(int page) async {
    final tvList = await _movieApiProvider.fetchArrivingTodayTv(page);
    _airingTodayTv.sink.add(tvList);
  }

  fetchTopRatedTv(int page) async {
    final tvList = await _movieApiProvider.fetchTopRatedTv(page);
    _topRatedTv.sink.add(tvList);
  }

  // Retrieve data from stream
  Stream<List<dynamic>> get popularTv => _popularTv.stream;
  Stream<List<dynamic>> get arrivingTodayTv => _airingTodayTv.stream;
  Stream<List<dynamic>> get topRatedTv => _topRatedTv.stream;

  dispose() {
    _popularTv.close();
    _airingTodayTv.close();
    _topRatedTv.close();
  }
}
