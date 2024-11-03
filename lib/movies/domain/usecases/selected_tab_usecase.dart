import 'package:movie_app/movies/domain/repository/navigation_repository.dart';

class SelectedTabUsecase {
  final NavigationRepository _navigationRepository;

  SelectedTabUsecase(this._navigationRepository);

  int execute(int index) {
    return index;
  }

  int getInitialTab() {
    return _navigationRepository.getInitialTab();
  }
}
