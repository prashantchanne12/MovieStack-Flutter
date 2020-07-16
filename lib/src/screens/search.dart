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
          return Text('Loading...');
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            bool isMovie = snapshot.data[index]['media_type'] == 'movie';
            return Text(
              isMovie
                  ? '${snapshot.data[index]['title']}'
                  : '${snapshot.data[index]['name']}',
              style: TextStyle(
                color: Colors.white,
              ),
            );
          },
        );
      },
    );
  }

  clearSearch() {
    searchController.clear();
  }
}
