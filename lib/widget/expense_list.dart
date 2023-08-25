import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_frontend/cubit/expenses.dart';
import 'expense_compact.dart';

class ExpenseList extends StatelessWidget {
  final String projectId;
  const ExpenseList(this.projectId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, CostProjectState>(
        builder: (context, state) {
      var costElements = state.costProject?.costElements;
      if (costElements == null) {
        context.read<ProjectCubit>().fetchCostElements(projectId);
        return ListView(
          children: const [Text("Loading")],
        );
      }
      return RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () {
          return context.read<ProjectCubit>().fetchCostElements(projectId);
        },
        child: ListView(
          children: [
            for (final element in costElements)
              CostElementCompact(projectId, element),
          ],
        ),
      );
    });
  }
}
