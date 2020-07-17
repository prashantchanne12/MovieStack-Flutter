import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/home_provider.dart';
import 'package:movie_stack/src/blocs/movies_provider.dart';
import 'package:movie_stack/src/blocs/tv_provider.dart';
import 'package:movie_stack/src/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application

  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      child: DetailsPageProvider(
        child: MoviesProvider(
          child: TvProvider(
            child: MaterialApp(
              title: 'MovieStack',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'mont',
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              onGenerateRoute: routes,
            ),
          ),
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (BuildContext context) {
        final homeBloc = HomeProvider.of(context);
        final moviesBloc = MoviesProvider.of(context);
        final tvBloc = TvProvider.of(context);
        homeBloc.fetchTrendingMovies();
        homeBloc.fetchTrendingTV();
        homeBloc.fetchTrending();
        moviesBloc.fetchTopRatedMovies(1);
        moviesBloc.fetchPopularMovies(1);
        moviesBloc.fetchUpcomingMovies(1);
        tvBloc.fetchPopularTv(1);
        tvBloc.fetchArrivingTodayTv(1);
        tvBloc.fetchTopRatedTv(1);
        return Home();
      });
    }
  }
}
