class TvModel {
  String original_name;
  int id;
  String name;
  double vote_average;
  String poster_path;
  String original_language;
  String backdrop_path;
  double popularity;
  String media_type;

  // Named Constructor
  TvModel.fromJson(Map<String, dynamic> parsedJson) {
    original_name = parsedJson['original_name'];
    id = parsedJson['id'];
    name = parsedJson['name'];
    vote_average = parsedJson['vote_average'];
    poster_path = parsedJson['poster_path'];
    original_language = parsedJson['original_language'];
    backdrop_path = parsedJson['backdrop_path'];
    popularity = parsedJson['popularity'];
    media_type = parsedJson['media_type'];
  }
}
