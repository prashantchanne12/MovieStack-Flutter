import 'dart:async';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _topMovies = BehaviorSubject<List<dynamic>>();
  final _popularMovies = BehaviorSubject<List<dynamic>>();
  final _moviesApiProvider = MoviesApiProvider();

  // Add data to the stream
  fetchTopRatedMovies(int page) async {
    final moviesList = await _moviesApiProvider.fetchTopRatedMovies(page);
    _topMovies.sink.add(moviesList);
  }

  fetchPopularMovies(int page) async {
    final moviesList = await _moviesApiProvider.fetchPopularMovies(page);
    _popularMovies.sink.add(moviesList);
  }

  // Retrieve data from stream
  Stream<List<dynamic>> get topRatedMovies => _topMovies.stream;
  Stream<List<dynamic>> get popularMovies => _popularMovies.stream;

  dispose() {
    _topMovies.close();
    _popularMovies.close();
  }
}
