// user_list_screen.dart
import 'package:bloc_sample_app/presentation/blocs/user_bloc.dart';
import 'package:bloc_sample_app/presentation/blocs/user_event.dart';
import 'package:bloc_sample_app/presentation/blocs/user_state.dart';
import 'package:bloc_sample_app/presentation/pages/user_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(LoadUsers());
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Container(
                  decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(4))
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red,
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context).add(RemoveUser(user.id!));
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserFormScreen()),
          );
          if (result == true) {
            BlocProvider.of<UserBloc>(context).add(LoadUsers());
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
