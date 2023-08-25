import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_frontend/widget/expense_list.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final String? projectId;

  const ProjectDetailsScreen(this.projectId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go("/"),
            ),
            title: const Text("ElementDetails")),
        body: ExpenseList(projectId!),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => context.push("/projects/$projectId/create-element"),
        ));
  }
}
