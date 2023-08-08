import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_frontend/cubit/user.dart';
import 'package:split_frontend/widget/project_compact.dart';

class ProjectListWidget extends StatelessWidget {
  final String userId;

  const ProjectListWidget(this.userId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserStateInitial) {
        context.read<UserCubit>().loadUser(userId);
      }
      if (state is UserStateLoading) {
        return const CircularProgressIndicator();
      }
      if (state is UserStateLoaded) {
        return ListView(
          physics: const ScrollPhysics(),
          children: [
            for (final project in state.projects) ProjectCompactWidget(project)
          ],
        );
      }
      return const Text("error");
    });
  }
}
