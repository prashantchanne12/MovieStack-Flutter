import 'dart:async';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class TvBloc {
  final _popularTv = BehaviorSubject<List<dynamic>>();
  final _airingTodayTv = BehaviorSubject<List<dynamic>>();
  final _topRatedTv = BehaviorSubject<List<dynamic>>();
  final _movieApiProvider = MoviesApiProvider();
  final _tvs = BehaviorSubject<List<dynamic>>();

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

  fetchTvs(int page, int which) async {
    var tvList;

    switch (which) {
      case 1:
        {
          tvList = await _movieApiProvider.fetchArrivingTodayTv(page);
          break;
        }
      case 2:
        {
          tvList = await _movieApiProvider.fetchPopularTv(page);
          break;
        }
      case 3:
        {
          tvList = await _movieApiProvider.fetchTopRatedTv(page);
          break;
        }
    }
    _tvs.sink.add(tvList);
  }

  // Retrieve data from stream
  Stream<List<dynamic>> get popularTv => _popularTv.stream;
  Stream<List<dynamic>> get arrivingTodayTv => _airingTodayTv.stream;
  Stream<List<dynamic>> get topRatedTv => _topRatedTv.stream;
  Stream<List<dynamic>> get tvs => _tvs.stream;

  dispose() {
    _popularTv.close();
    _airingTodayTv.close();
    _topRatedTv.close();
    _tvs.close();
  }
}
