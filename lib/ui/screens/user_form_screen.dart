// user_form_screen.dart
import 'package:bloc_sample_app/blocs/user_bloc/user_bloc.dart';
import 'package:bloc_sample_app/blocs/user_bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UserFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<UserBloc>(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add User'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: InputDecoration(labelText: 'Name'),
                  // validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(labelText: 'Email'),
                  // validator: FormBuilderValidators.compose([
                  //   FormBuilderValidators.required(),
                  //   FormBuilderValidators.email(),
                  // ]),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final name = _formKey.currentState?.value['name'];
                      final email = _formKey.currentState?.value['email'];
                      BlocProvider.of<UserBloc>(context).add(AddUser(name, email));
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
