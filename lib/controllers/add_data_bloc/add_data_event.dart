// add_data_event.dart
import 'package:equatable/equatable.dart';

abstract class AddDataEvent extends Equatable {
  const AddDataEvent();

  @override
  List<Object> get props => [];
}

class AddDataButtonPressed extends AddDataEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;

  const AddDataButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  @override
  List<Object> get props => [firstName, lastName, email, phoneNumber, address];
}
