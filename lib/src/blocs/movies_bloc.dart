import 'dart:async';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _topMovies = BehaviorSubject<List<dynamic>>();
  final _popularMovies = BehaviorSubject<List<dynamic>>();
  final _upcomingMovies = BehaviorSubject<List<dynamic>>();
  final _loader = BehaviorSubject<bool>();
  final _movies = BehaviorSubject<List<dynamic>>();
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

  fetchUpcomingMovies(int page) async {
    final moviesList = await _moviesApiProvider.fetchUpcomingMovies(page);
    _upcomingMovies.sink.add(moviesList);
  }

  fetchMovies(int page, int which) async {
    var movieList;

    switch (which) {
      case 1:
        {
          movieList = await _moviesApiProvider.fetchPopularMovies(page);
          break;
        }
      case 2:
        {
          movieList = await _moviesApiProvider.fetchTopRatedMovies(page);
          break;
        }
      case 3:
        {
          movieList = await _moviesApiProvider.fetchUpcomingMovies(page);
          break;
        }
    }

    _movies.sink.add(movieList);
  }

  Function(bool) get changeLoader => _loader.sink.add;

  // Retrieve data from stream
  Stream<List<dynamic>> get topRatedMovies => _topMovies.stream;
  Stream<List<dynamic>> get popularMovies => _popularMovies.stream;
  Stream<List<dynamic>> get upcomingMovies => _upcomingMovies.stream;
  Stream<bool> get loader => _loader.stream;
  Stream<List<dynamic>> get movies => _movies.stream;

  dispose() {
    _topMovies.close();
    _popularMovies.close();
    _upcomingMovies.close();
    _movies.close();
    _loader.close();
  }
}
