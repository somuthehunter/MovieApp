import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/navigation/navigation_event.dart';
import 'package:movie_app/movies/presentation/bloc/navigation/navigation_state.dart';


class NavigationBloc extends Bloc<ChangeNavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(0)) {
    on<ChangeNavigationEvent>((event, emit) {
      emit(NavigationState(event.selectedIndex));
    });
  }
}
