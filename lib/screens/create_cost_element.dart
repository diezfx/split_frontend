import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:split_frontend/cubit/expenses.dart';

import '../expenses/expenses.dart';

class CreateCostElementScreen extends StatefulWidget {
  final String projectId;
  final String userId;
  const CreateCostElementScreen(this.userId, this.projectId, {super.key});

  @override
  _CreateCostElementScreenState createState() =>
      _CreateCostElementScreenState(userId, projectId);
}

class _CreateCostElementScreenState extends State<CreateCostElementScreen> {
  final String projectId;
  final String userId;

  _CreateCostElementScreenState(this.userId, this.projectId);

  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _costTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text("Create Cost")),
      body: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Name"),
              controller: _nameTextController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Cost")),
              controller: _costTextController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9.,]")),
              ],
              validator: (value) {
                if (value == null || double.tryParse(value) == null) {
                  return "Enter a valid number";
                }
                return null;
              },
            ),
            Container(
                padding: const EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      var costElement = Transaction(
                          Transaction.getRandomId(),
                          _nameTextController.text,
                          CostType.expense,
                          double.parse(_costTextController.text),
                          userId,
                          const [],
                          DateTime.now());
                      context.read<ProjectCubit>().addCostElement(costElement);
                      context.pop();
                    })),
          ])),
    );
  }
}
