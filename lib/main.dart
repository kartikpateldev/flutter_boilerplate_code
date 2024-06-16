import 'package:bloc_sample_app/data/services/api_service.dart';
import 'package:bloc_sample_app/presentation/blocs/user_bloc.dart';
import 'package:bloc_sample_app/presentation/pages/user_list_screen.dart';
import 'package:bloc_sample_app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(apiService: ApiService(callWithAccessToken())),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const UserListScreen(),
      ),
    );
  }
}


// // dio interceptors required for api calls
Dio callWithAccessToken() {
  Dio dio = Dio(BaseOptions(
      baseUrl: "https://crudcrud.com/api/79531878607b40e9a4aa63ba99e091cf",
      receiveTimeout: 1000 * 60 * 2,
      connectTimeout: 1000 * 60 * 2,
      headers: {
        "Authorization": "",
      }));
  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
    // add internet connection
    options.extra['start_time'] = DateTime.now();
    // options.headers['content-type'] = 'application/json';
    logger.i("Request:: " + options.method + " " + options.baseUrl + options.path);
    return handler.next(options); //continue

    // return handler.next(options); //continue
  }, onResponse: (Response response, handler) {
    final startTime = response.requestOptions.extra['start_time'] as DateTime;
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMilliseconds;
    logger.d(
        "Response::  ${response.statusCode} ${duration}ms ${response.toString()}");
    return handler.next(response); //continue
  }, onError: (DioError e, handler) {
    return handler.next(e); //continue
  }));
  return dio;
}