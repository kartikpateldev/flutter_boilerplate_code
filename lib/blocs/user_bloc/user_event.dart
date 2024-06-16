import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final String name;
  final String email;
  AddUser(this.name, this.email);

  @override
  List<Object> get props => [name, email];
}

class RemoveUser extends UserEvent {
  final String id;
  RemoveUser(this.id);

  @override
  List<Object> get props => [id];
}

// Implement other CRUD events similarly
