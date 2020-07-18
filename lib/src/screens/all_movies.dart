import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_bloc.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/movies_bloc.dart';
import 'package:movie_stack/src/blocs/movies_provider.dart';
import 'package:movie_stack/src/blocs/tv_bloc.dart';
import 'package:movie_stack/src/blocs/tv_provider.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/movie_model.dart';
import 'package:movie_stack/src/models/tv_model.dart';
import 'package:movie_stack/src/resources/open_details_screen.dart';
import 'package:movie_stack/src/widgets/all_movies_shows_loading_placeholder.dart';

var movies = [];
String position = '';
int page = 1;
var model;
String title;

class AllMovies extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final int which;
  final bool isMovie;
  final String title;

  AllMovies(
      {@required this.which, @required this.isMovie, @required this.title});

  @override
  Widget build(BuildContext context) {
    movies = [];
    MoviesBloc moviesBloc = MoviesProvider.of(context);
    TvBloc tvBloc = TvProvider.of(context);
    DetailsBloc detailsBloc = DetailsPageProvider.of(context);

    _scrollListener() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
//        moviesBloc.changeLoader(true);
        page++;
        print('end...');
        isMovie
            ? moviesBloc.fetchMovies(page, which)
            : tvBloc.fetchTvs(page, which);
//        moviesBloc.changeLoader(false);
      }
    }

    _scrollController.addListener(_scrollListener);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Text(
          '$title',
          style: TextStyle(fontWeight: FontWeight.bold, color: kLightGrey),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: allData(moviesBloc, tvBloc, detailsBloc),
    );
  }

  allData(MoviesBloc moviesBloc, TvBloc tvBloc, DetailsBloc detailsBloc) {
    return StreamBuilder(
      stream: isMovie ? moviesBloc.movies : tvBloc.tvs,
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return seeAllLoadingPlaceholder();
        }
        movies.addAll(snapshot.data);
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            model = isMovie
                ? MovieModel.fromJson(movies[index])
                : TvModel.fromJson(movies[index]);
            return GestureDetector(
              onTap: () {
                openDetailsScreen(
                    context, movies[index]['id'], isMovie, detailsBloc);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildPoster(model),
                        buildDetails(model, isMovie),
                      ],
                    ),
                    Divider(),
//                    StreamBuilder(
//                      stream: moviesBloc.loader,
//                      builder: (BuildContext context, snap) {
//                        if (!snap.hasData) {
//                          return Container(
//                            height: 0.0,
//                          );
//                        }
//                        bool loading = snap.data;
//                        bool isLast = true;
//                        bool okay = loading && isLast;
//                        print(okay);
//                        return okay
//                            ? Text(
//                                'Loading...',
//                                style: TextStyle(color: Colors.white),
//                              )
//                            : Container(
//                                height: 0.0,
//                              );
//                      },
//                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Container buildPoster(var model) {
    return Container(
      height: 150.0,
      width: 100.0,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: FadeInImage.assetNetwork(
          image: '$kImageUrl${model.poster_path}',
          fit: BoxFit.fill,
          placeholder: 'assets/images/img.png',
        ),
      ),
    );
  }

  Widget buildDetails(var model, bool isMovie) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0),
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  isMovie
                      ? '${model.title.toString().length < 15 ? model.title : model.title.toString().substring(0, 15) + '..'}'
                      : '${model.name.toString().length < 15 ? model.name : model.name.toString().substring(0, 15) + '..'}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Text(
                  isMovie
                      ? ' (${model.release_date.toString().substring(0, 4)})'
                      : ' (${model.first_air_date.toString().substring(0, 4)})',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.stars,
                color: kAccentColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Container(
                child: Text(
                  '${model.vote_average}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
