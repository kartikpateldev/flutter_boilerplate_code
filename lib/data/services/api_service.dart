import 'package:bloc_sample_app/data/models/user_model.dart';
import 'package:dio/dio.dart';

// class ApiService {
//   final Dio dio;

//   ApiService(this.dio);

//   Future<List<UserModel>> getUsers() async {
//     final response = await dio.get('/users');
//     return (response.data as List)
//         .map((json) => UserModel.fromJson(json))
//         .toList();
//   }

//   Future<UserModel> getUser(int id) async {
//     final response = await dio.get('/users/$id');
//     return UserModel.fromJson(response.data);
//   }

//   Future<UserModel> createUser(UserModel user) async {
//     final response = await dio.post('/users', data: user.toJson());
//     return UserModel.fromJson(response.data);
//   }

//   Future<void> updateUser(UserModel user) async {
//     await dio.put('/users/${user.id}', data: user.toJson());
//   }

//   Future<void> deleteUser(int id) async {
//     await dio.delete('/users/$id');
//   }
// }

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<UserModel>> getUsers() async {
    final response = await dio.get('/users');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> createUser(String name, String email) async {
    final response = await dio.post(
      '/users',
      data: {'name': name, 'email': email},
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add user');
    }
  }

  Future<void> removeUser(String id) async {
    final response = await dio.delete('/users/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to add user');
    }
  }
}
