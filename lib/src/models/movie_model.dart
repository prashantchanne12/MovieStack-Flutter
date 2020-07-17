class MovieModel {
  int id;
  int vote_count;
  var vote_average;
  String title;
  String release_date;
  String original_language;
  String original_title;
  List<dynamic> genre_ids;
  String backdrop_path;
  String overview;
  String poster_path;
  double popularity;
  String media_type;

  // Named Constructor
  MovieModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    vote_count = parsedJson['vote_count'];
    vote_average = parsedJson['vote_average'];
    title = parsedJson['title'];
    release_date = parsedJson['release_date'];
    original_language = parsedJson['original_language'];
    original_title = parsedJson['original_title'];
    genre_ids = parsedJson['genre_ids'];
    backdrop_path = parsedJson['backdrop_path'];
    overview = parsedJson['overview'];
    poster_path = parsedJson['poster_path'];
    popularity = parsedJson['popularity'];
    media_type = parsedJson['media_type'];
  }
}
