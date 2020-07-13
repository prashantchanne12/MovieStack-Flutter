class TvModel {
  String original_name;
  int id;
  String name;
  int vote_count;
  double vote_average;
  String first_air_date;
  String poster_path;
  List<dynamic> genre_ids;
  String original_language;
  String backdrop_path;
  String overview;
  double popularity;
  String media_type;

  // Named Constructor
  TvModel.fromJson(Map<String, dynamic> parsedJson) {
    original_name = parsedJson['original_name'];
    id = parsedJson['id'];
    name = parsedJson['name'];
    vote_count = parsedJson['vote_count'];
    vote_average = parsedJson['vote_average'];
    first_air_date = parsedJson['first_air_date'];
    poster_path = parsedJson['poster_path'];
    genre_ids = parsedJson['genre_ids'];
    original_language = parsedJson['original_language'];
    backdrop_path = parsedJson['backdrop_path'];
    overview = parsedJson['overview'];
    popularity = parsedJson['popularity'];
    media_type = parsedJson['media_type'];
  }
}
