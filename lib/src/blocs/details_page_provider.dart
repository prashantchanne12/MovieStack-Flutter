import 'package:flutter/material.dart';
import 'details_page_bloc.dart';
export 'details_page_bloc.dart';

class DetailsPageProvider extends InheritedWidget {
  final DetailsBloc bloc;

  DetailsPageProvider({Key key, Widget child})
      : bloc = DetailsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static DetailsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DetailsPageProvider)
            as DetailsPageProvider)
        .bloc;
  }
}
