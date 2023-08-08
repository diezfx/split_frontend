import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:split_frontend/cubit/cost_element_details.dart';

final oCcy = NumberFormat.currency(locale: "de_DE", symbol: "€");

class ExpenseDetailsWidget extends StatelessWidget {
  final String projectId;
  final String elementId;
  const ExpenseDetailsWidget(this.projectId, this.elementId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CostElementCubit, CostElementState>(
      builder: (context, state) {
        if (state is Initial) {
          context.read<CostElementCubit>().loadElement(projectId, elementId);
        }
        if (state is Loading) {
          return const CircularProgressIndicator();
        }

        if (state is CostElementStateLoaded) {
          return Column(children: [
            ListTile(
                title: const Text("Name"),
                trailing: Text(state.costElement.name)),
            ListTile(
                title: const Text("Spender"),
                trailing: Text(state.costElement.source)),
            ListTile(
                title: const Text("Cost"),
                trailing: Text(oCcy.format(state.costElement.amount))),
            ListTile(
                title: const Text("Creation Date"),
                trailing: Text(state.costElement.creationDate.toString()))
          ]);
        }

        return const Text("error");
      },
    );
  }
}
