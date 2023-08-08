import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../expenses/expenses.dart';

final oCcy = NumberFormat.currency(locale: "de_DE", symbol: "€");

class CostElementCompact extends StatelessWidget {
  final String projectId;
  final Transaction costElement;
  const CostElementCompact(this.projectId, this.costElement, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.airplanemode_inactive_sharp)),
      title: Text(costElement.name),
      subtitle: Text(costElement.source),
      trailing: Text(oCcy.format(costElement.amount)),
      onTap: () =>
          context.go("/projects/$projectId/elements/${costElement.id}"),
    ));
  }
}
