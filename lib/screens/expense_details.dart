import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widget/expense_details.dart';

class ExpensesDetailsScreen extends StatelessWidget {
  final String? projectId;
  final String? elementId;

  const ExpensesDetailsScreen(this.projectId, this.elementId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go("/projects/$projectId"),
          ),
          title: const Text("ElementDetails")),
      body: ExpenseDetailsWidget(projectId!, elementId!),
    );
  }
}
