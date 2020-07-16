class DetailsModel {
  int id;
  String backdrop_path;
  int budget;
  List<dynamic> genres;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  List<dynamic> production_companies;
  String release_date;
  int revenue;
  String tagline;
  String title;
  double vote_average;
  int vote_count;
  int runtime;
  String first_air_date;
  String last_air_date;
  String name;
  String original_language;
  int number_of_episodes;
  int number_of_seasons;
  List<dynamic> origin_country;
  List<dynamic> seasons;
  List<dynamic> episode_run_time;

  // Named constructor
  DetailsModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    backdrop_path = parsedJson['backdrop_path'];
    budget = parsedJson['budget'];
    genres = parsedJson['genres'];
    original_title = parsedJson['original_title'];
    overview = parsedJson['overview'];
    popularity = parsedJson['popularity'];
    poster_path = parsedJson['poster_path'];
    production_companies = parsedJson['production_companies'];
    release_date = parsedJson['release_date'];
    revenue = parsedJson['revenue'];
    tagline = parsedJson['tagline'];
    title = parsedJson['title'];
    vote_average = parsedJson['vote_average'];
    vote_count = parsedJson['vote_count'];
    first_air_date = parsedJson['first_air_date'];
    last_air_date = parsedJson['last_air_date'] ?? 'not available';
    name = parsedJson['name'];
    number_of_episodes = parsedJson['number_of_episodes'] ?? 0;
    number_of_seasons = parsedJson['number_of_seasons'] ?? 0;
    origin_country = parsedJson['origin_country'];
    runtime = parsedJson['runtime'];
    seasons = parsedJson['seasons'];
    episode_run_time = parsedJson['episode_run_time'] ?? ['N/A'];
    original_language = parsedJson['original_language'];
  }
}
