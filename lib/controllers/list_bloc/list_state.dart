import 'package:equatable/equatable.dart';
import '../../models/api_response_schema.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object?> get props => [];
}

class ListInitial extends ListState {}

class ListLoading extends ListState {}

class ListLoaded extends ListState {
  final ResponseSchema responseSchema;

  const ListLoaded({required this.responseSchema});

  @override
  List<Object?> get props => [responseSchema];
}

class ListError extends ListState {
  final String message;

  const ListError({required this.message});

  @override
  List<Object?> get props => [message];
}
