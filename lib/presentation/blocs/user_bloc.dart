// // user_bloc.dart
// import 'dart:async';
// // import 'package:bloc/bloc.dart';
// import 'package:bloc_sample_app/data/services/api_service.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'user_event.dart';
// import 'user_state.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final ApiService apiService;

//   UserBloc({required this.apiService}) : super(UserInitial());

//   @override
//   Stream<UserState> mapEventToState(UserEvent event) async* {
//     if (event is LoadUsers) {
//       yield UserLoading();
//       try {
//         final users = await apiService.getUsers();
//         yield UserLoaded(users);
//       } catch (e) {
//         yield UserError('Failed to load users');
//       }
//     } else if (event is AddUser) {
//       yield UserLoading();
//       try {
//         await apiService.createUser(event.name, event.email);
//         final users = await apiService.getUsers();
//         yield UserLoaded(users);
//       } catch (e) {
//         yield UserError('Failed to add user');
//       }
//     }
//   }
// }

// blocs/user_bloc/user_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_sample_app/data/services/api_service.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;

  UserBloc({required this.apiService}) : super(UserInitial()) {
    on<LoadUsers>(_onFetchUsers);
    on<AddUser>(_onAddUser);
    on<RemoveUser>(_onRemoveUser);
  }

  Future<void> _onFetchUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await apiService.getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to load users'));
    }
  }

  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await apiService.createUser(event.name, event.email);
      final users = await apiService.getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to add user'));
    }
  }

  Future<void> _onRemoveUser(RemoveUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await apiService.removeUser(event.id);
      final users = await apiService.getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to add user'));
    }
  }
}

