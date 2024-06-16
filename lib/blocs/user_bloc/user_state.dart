
import 'package:bloc_sample_app/data/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

// class UserCreated extends UserState {
//   final List<User> users;

//   UserCreated(this.users);

//   @override
//   List<Object> get props => [users];
// }

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object> get props => [message];
}

// class UserAdded extends UserState {}
