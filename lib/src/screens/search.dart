import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/home_bloc.dart';
import 'package:movie_stack/src/blocs/home_provider.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/trending_model.dart';

class Search extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = HomeProvider.of(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        automaticallyImplyLeading: false,
        title: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          onChanged: (String query) {
            homeBloc.fetchSearchResults(query);
          },
          autofocus: true,
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            hintText: 'Search Movie / Tv',
            hintStyle: TextStyle(
              color: kLightGrey,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 28.0,
            ),
            suffix: IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: clearSearch,
            ),
          ),
        ),
      ),
      body: buildSearchResults(homeBloc),
    );
  }

  buildSearchResults(HomeBloc homeBloc) {
    return StreamBuilder(
      stream: homeBloc.search,
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: kDarkBlue2,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  Container(
                    height: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: kDarkBlue2,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: kDarkBlue2,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            bool isMovie = snapshot.data[index]['media_type'] == 'movie';
            bool isMovieOrTv = snapshot.data[index]['media_type'] == 'movie' ||
                snapshot.data[index]['media_type'] == 'tv';
            return isMovieOrTv
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 150.0,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                child: FadeInImage.assetNetwork(
                                  image: snapshot.data[index]['poster_path']
                                              .toString()
                                              .length >
                                          0
                                      ? '$kImageUrl${snapshot.data[index]['poster_path']}'
                                      : '$kImageBlueUrl',
                                  fit: BoxFit.fill,
                                  placeholder: 'assets/images/img.png',
                                ),
                              ),
                            ),
                            Container(
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
                                              ? '${snapshot.data[index]['title'].toString().length < 15 ? snapshot.data[index]['title'] : snapshot.data[index]['title'].toString().substring(0, 15) + '..'}'
                                              : '${snapshot.data[index]['name']}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          isMovie
                                              ? ' (${snapshot.data[index]['release_date'].toString().substring(0, 4)})'
                                              : ' (${snapshot.data[index]['first_air_date'].toString().substring(0, 4)})',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
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
                                          '${snapshot.data[index]['vote_average']}',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  )
                : Text('');
          },
        );
      },
    );
  }

  clearSearch() {
    searchController.clear();
  }
}
