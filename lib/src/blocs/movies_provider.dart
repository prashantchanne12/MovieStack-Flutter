import 'package:flutter/material.dart';
import 'movies_bloc.dart';
export 'movies_bloc.dart';

class MoviesProvider extends InheritedWidget {
  final MoviesBloc bloc;

  MoviesProvider({Key key, Widget child})
      : bloc = MoviesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static MoviesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MoviesProvider)
            as MoviesProvider)
        .bloc;
  }
}
