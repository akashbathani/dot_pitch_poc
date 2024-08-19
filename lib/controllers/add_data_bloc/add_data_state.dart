import 'package:equatable/equatable.dart';

abstract class AddDataState extends Equatable {
  const AddDataState();

  @override
  List<Object> get props => [];
}

class AddDataInitial extends AddDataState {}

class AddDataLoading extends AddDataState {}

class AddDataSuccess extends AddDataState {}

class AddDataFailure extends AddDataState {
  final String error;

  const AddDataFailure({required this.error});

  @override
  List<Object> get props => [error];
}
