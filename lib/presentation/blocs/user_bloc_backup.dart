// import 'package:bloc_sample_app/presentation/blocs/user_event.dart';
// import 'package:bloc_sample_app/presentation/blocs/user_state.dart';
// import 'package:bloc_sample_app/utils/logger.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/repositories/user_repository.dart';


// class UserBloc extends Bloc<UserEvent, UserState> {
//   final UserRepository userRepository;

//   UserBloc(this.userRepository) : super(UserInitial()) {
//     on<LoadUsers>((event, emit) async {
//       emit(UserLoading());
//       try {
//         final users = await userRepository.getUsers();
//         emit(UserLoaded(users));
//       } catch (_) {
//         emit(UserError("Failed to fetch users"));
//       }
//     });

//     on<CreateUser>((event, emit) async {
//       emit(UserLoading());
//       try {
//         final user = await userRepository.createUser(event.user);
//         emit(UserCreated([user]));
//         // add(LoadUsers());
//       } catch (_, stackTrace) {
//         logger.e("Here 1::::");
//         print(_);
//         print('Stack trace: $stackTrace');
//         emit(UserError("Failed to fetch users"));
//       }
//     });

//     // Implement other CRUD operations similarly

//     // @override
//     // Stream<UserState> mapEventToState(UserEvent event) async* {
//     //   if (event is SubmitPost) {
//     //     yield PostLoading();
//     //     try {
//     //       // Call your API or repository method to add post data
//     //       await repository.addPost(event.data);
//     //       yield PostSuccess();
//     //     } catch (e) {
//     //       yield PostFailure("Failed to add post: $e");
//     //     }
//     //   }
//     // }
//   }
// }

