import 'package:movie_app/movies/presentation/bloc/navigation/navigation_event.dart';
import 'package:movie_app/movies/presentation/bloc/navigation/navigation_state.dart';

import 'package:bloc/bloc.dart';

class NavigationBloc extends Bloc<ChangeNavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(0)) {
    on<ChangeNavigationEvent>((event, emit) {
      emit(NavigationState(event.selectedIndex));
    });
  }
}
