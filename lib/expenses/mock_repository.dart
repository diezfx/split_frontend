import 'package:split_frontend/expenses/repository.dart';
import 'package:split_frontend/pkg/user/user.dart';

import '../pkg/logger/logger.dart';
import 'exceptions.dart';
import 'expenses.dart';

class ExpensesMockRepository implements IExpenseRepository {
  List<CostProject> projects = [
    CostProject("test-1", "TestProject1", Currency.euro, [
      Transaction("elementId", "lala", CostType.expense, 100, "user1", const [],
          DateTime.now())
    ], const [
      "user1"
    ])
  ];

  @override
  Future<List<CostProject>> getCostProjectsByUser(UserId user) async {
    return projects;
  }

  @override
  Future<CostProject?> getCostProjectById(String id) async {
    log.info("get Project $id");
    return projects.where((p) => p.id == id).firstOrNull;
  }

  @override
  Future addCostToProject(String projectId, Transaction element) async {
    var projectIndex =
        projects.indexWhere((element) => element.id == projectId);
    if (projectIndex == -1) {
      throw ElementNotFoundException();
    }
    var project = projects[projectIndex];
    projects[projectIndex] = project.copyWith(
      elements: [...project.costElements, element],
    );

    return projects[projectIndex];
  }

  @override
  Future<CostProject> addnewProject(CostProject project) async {
    projects.add(project);
    return project;
  }
}
