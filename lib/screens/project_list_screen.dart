import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:split_frontend/cubit/auth_cubit.dart';
import 'package:split_frontend/widget/project_list.dart';

class ProjectListScreen extends StatelessWidget {
  late String userId;
  ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.read<AuthCubit>().state as LoggedIn;

    userId = user.session.user.id;

    return Scaffold(
        appBar: AppBar(title: const Text("Projects")),
        body: ProjectListWidget(userId),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.push("/create-project")));
  }
}
