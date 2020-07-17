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
        homeBloc.fetchTrendingMovies();
        homeBloc.fetchTrendingTV();
        homeBloc.fetchTrending();
        return Home();
      });
    }
  }
}
