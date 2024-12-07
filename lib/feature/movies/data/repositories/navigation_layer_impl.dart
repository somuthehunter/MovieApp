import 'package:movie_app/feature/movies/domain/repository/navigation_repository.dart';

class NavigationLayerImpl extends NavigationRepository {
  @override
  int getInitialTab() {
    return 0; //set as initial 
  }
}
