import 'dart:convert';
import 'package:http/http.dart' show get;
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/movie_details_model.dart';

class MoviesApiProvider {
  Future<List<dynamic>> fetchTrendingMovies() async {
    final response = await get(kTrendingMovies);
    final jsonBody = json.decode(response.body);
    return jsonBody['results'];
  }

  Future<List<dynamic>> fetchTrendingTv() async {
    final response = await get(kTrendingTv);
    final jsonBody = json.decode(response.body);
    return jsonBody['results'];
  }

  Future<List<dynamic>> fetchTrending() async {
    final response = await get(kTrending);
    final jsonBody = json.decode(response.body);
    return jsonBody['results'];
  }

  Future<MovieDetailsModel> fetchMovieDetails(int id) async {
    final response = await get(
        'https://api.themoviedb.org/3/movie/$id?api_key=$kApiKey&language=en-US');
    final jsonBody = json.decode(response.body);
    return MovieDetailsModel.fromJson(jsonBody);
  }
}
