class SimilarContentModel {
  int id;
  double vote_average;
  String title;
  String name;
  String original_title;
  String poster_path;

  // Named Constructor
  SimilarContentModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    vote_average = parsedJson['vote_average'];
    title = parsedJson['title'];
    name = parsedJson['name'];
    original_title = parsedJson['original_title'];
    poster_path = parsedJson['poster_path'];
  }
}
