import 'package:equatable/equatable.dart';

class ChangeNavigationEvent extends Equatable {
  final int selectedIndex;

  const ChangeNavigationEvent(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
