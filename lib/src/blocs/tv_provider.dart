import 'package:flutter/material.dart';
import 'tv_bloc.dart';
export 'tv_bloc.dart';

class TvProvider extends InheritedWidget {
  final TvBloc bloc;

  TvProvider({Key key, Widget child})
      : bloc = TvBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static TvBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TvProvider) as TvProvider)
        .bloc;
  }
}
