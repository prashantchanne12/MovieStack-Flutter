class TrendingModel {
  int id;
  double vote_average;
  String title;
  String original_title;
  String backdrop_path;
  String poster_path;
  String original_name;
  String name;
  String media_type;

  // Named constructor
  TrendingModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    vote_average = parsedJson['vote_average'];
    title = parsedJson['title'];
    original_title = parsedJson['original_title'];
    backdrop_path = parsedJson['backdrop_path'];
    poster_path = parsedJson['poster_path'];
    original_name = parsedJson['original_name'];
    name = parsedJson['name'];
    media_type = parsedJson['media_type'];
  }
}
