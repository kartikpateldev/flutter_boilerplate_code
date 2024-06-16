// import '../../domain/entities/user.dart';
// import '../../domain/repositories/user_repository.dart';
// import '../models/user_model.dart';
// import '../services/api_service.dart';

// class UserRepositoryImpl implements UserRepository {
//   final ApiService apiService;

//   UserRepositoryImpl(this.apiService);

//   @override
//   Future<List<User>> getUsers() async {
//     return await apiService.getUsers();
//   }

//   @override
//   Future<User> getUser(int id) async {
//     return await apiService.getUser(id);
//   }

//   @override
//   Future<User> createUser(User user) async {
//     return apiService.createUser(
//       name: user.name,
//       email: user.email,
//     );
//   }

//   @override
//   Future<void> updateUser(User user) async {
//     await apiService.updateUser(UserModel(
//       id: user.id!,
//       name: user.name,
//       email: user.email,
//     ));
//   }

//   @override
//   Future<void> deleteUser(int id) async {
//     await apiService.deleteUser(id);
//   }
// }
