// home_event.dart
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends HomeEvent {}
class LogoutEvent extends HomeEvent {}

class RemoveItemEvent extends HomeEvent {
  final int index;

  const RemoveItemEvent(this.index);

  @override
  List<Object> get props => [index];
}
