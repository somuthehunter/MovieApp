import 'package:equatable/equatable.dart';

class ChangeNavigationEvent extends Equatable {
  final int selectedIndex;

  ChangeNavigationEvent(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
