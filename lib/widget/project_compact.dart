import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../expenses/expenses.dart';

class ProjectCompactWidget extends StatelessWidget {
  final CostProject project;

  const ProjectCompactWidget(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(project.name),
      onTap: () => context.go("/projects/${project.id}"),
    ));
  }
}
