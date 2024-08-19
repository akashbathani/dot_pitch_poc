// home_state.dart
import 'package:dot_pitch_poc/models/user_data_schema.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<UserData> items;

  const HomeLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
class LogoutState extends HomeState {}
