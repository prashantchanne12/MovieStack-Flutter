class CastModel {
  int id;
  List<dynamic> cast;
  List<dynamic> crew;

  // Named Constructor
  CastModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    cast = parsedJson['cast'];
    crew = parsedJson['crew'];
  }
}
