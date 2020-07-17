import 'dart:ui';

const kApiKey = 'e4c41ae3e8578a454aa7575f144a0f14';

const kImageUrl = 'https://image.tmdb.org/t/p/w500';
const kTopRated =
    'https://api.themoviedb.org/3/movie/top_rated?api_key=$kApiKey'
    '&language=en-US&page=';
const kPopular = 'https://api.themoviedb.org/3/movie/popular?api_key=$kApiKey'
    '&language=en-US&page=';
const kNowPlaying =
    'https://api.themoviedb.org/3/movie/now_playing?api_key=$kApiKey'
    '&language=en-US&page=';
const kUpcoming = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$kApiKey'
    '&language=en-US&page=';
const kLatest = 'https://api.themoviedb.org/3/movie/latest?api_key=$kApiKey'
    '&language=en-US&page=';
const kTrending =
    'https://api.themoviedb.org/3/trending/all/day?api_key=$kApiKey';
const kTrendingMovies =
    'https://api.themoviedb.org/3/trending/movie/day?api_key=$kApiKey';
const kTrendingTv =
    'https://api.themoviedb.org/3/trending/tv/day?api_key=$kApiKey';
const kTVPopular =
    'https://api.themoviedb.org/3/tv/popular?api_key=$kApiKey&language=en-US&page=';
const kTVTopRated =
    'https://api.themoviedb.org/3/tv/top_rated?api_key=$kApiKey&language=en-US&page=';
const kDefaultImage =
    'https://icon-library.com/images/default-user-icon/default-user-icon-8.jpg';
const kTvArrivingToday =
    'https://api.themoviedb.org/3/tv/airing_today?api_key=$kApiKey&language=en-US&page=1';
const kImageBlueUrl = 'https://www.beautycolorcode.com/253250-2880x1800.png';

const kPrimaryColor = const Color(0xff05070c);
const kAccentColor = const Color(0xff4B97C5);
const kBlue = const Color(0xff0984e3);
const kDarkBlue1 = const Color(0xff314665);
const kDarkBlue2 = const Color(0xff253250);
const kLightGrey = const Color(0xffb5b6bf);
