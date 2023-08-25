import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:split_frontend/cubit/user.dart';

import '../expenses/expenses.dart';

final format = NumberFormat.decimalPattern(Platform.localeName);

class CreateProjectScreen extends StatefulWidget {
  final String userId;
  const CreateProjectScreen(this.userId, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  late String userId;

  _CreateProjectScreenState() {
    userId = widget.userId;
  }

  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Name"),
              controller: _nameTextController,
            ),
            Container(
                padding: const EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      var newProject = CostProject(
                          CostProject.getRandomId(),
                          _nameTextController.text,
                          Currency.euro, const [], const []);
                      context.read<UserCubit>().addProject(newProject);
                      context.pop();
                    })),
          ])),
    );
  }
}
