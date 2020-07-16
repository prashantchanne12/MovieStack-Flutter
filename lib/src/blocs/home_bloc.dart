import 'dart:async';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _trending = BehaviorSubject<List<dynamic>>();
  final _trendingMovies = BehaviorSubject<List<dynamic>>();
  final _trendingTv = BehaviorSubject<List<dynamic>>();
  final _search = BehaviorSubject<List<dynamic>>();
  final _moviesApiProvider = MoviesApiProvider();

  // Add data to Stream
  fetchTrendingMovies() async {
    final movieList = await _moviesApiProvider.fetchTrendingMovies();
    _trendingMovies.sink.add(movieList);
  }

  fetchTrendingTV() async {
    final tvList = await _moviesApiProvider.fetchTrendingTv();
    _trendingTv.sink.add(tvList);
  }

  fetchTrending() async {
    final trendingList = await _moviesApiProvider.fetchTrending();
    _trending.sink.add(trendingList);
  }

  fetchSearchResults(String query) async {
    final searchList = await _moviesApiProvider.fetchSearchResults(query);
    _search.sink.add(searchList);
  }

  // Stream to retrieve data
  Stream<List<dynamic>> get movies => _trendingMovies.stream;
  Stream<List<dynamic>> get tv => _trendingTv.stream;
  Stream<List<dynamic>> get trending => _trending.stream;
  Stream<List<dynamic>> get search => _search.stream;

  dispose() {
    _trendingMovies.close();
    _trendingTv.close();
    _trending.close();
    _search.close();
  }
}
