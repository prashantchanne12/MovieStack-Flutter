class TrendingModel {
  int id;
  int vote_count;
  double vote_average;
  String title;
  String release_date;
  String original_language;
  String original_title;
  List<dynamic> genre_ids;
  String backdrop_path;
  String overview;
  String poster_path;
  double popularity;
  String original_name;
  String name;
  String first_air_date;
  String media_type;

  // Named constructor
  TrendingModel.fromJson(Map<String, dynamic> parsedJson) {
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
    original_name = parsedJson['original_name'];
    name = parsedJson['name'];
    first_air_date = parsedJson['first_air_date'];
    media_type = parsedJson['media_type'];
  }
}
