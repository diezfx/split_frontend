import 'package:bloc/bloc.dart';

import '../expenses/expenses.dart';
import '../expenses/repository.dart';

enum ProjectStatus { initial, loading, loaded }

class CostProjectState {
  final String? projectId;
  final ProjectStatus status;
  final CostProject? costProject;

  CostProjectState(
      {this.projectId, this.status = ProjectStatus.initial, this.costProject});

  CostProjectState copyWith(
      {String? projectId, ProjectStatus? status, CostProject? costProject}) {
    return CostProjectState(
        projectId: projectId ?? this.projectId,
        status: status ?? this.status,
        costProject: costProject ?? this.costProject);
  }
}

// The bloc for when the project windows is open, which shows events for exactly one project.
class ProjectCubit extends Cubit<CostProjectState> {
  final IExpenseRepository expenseRepo;

  ProjectCubit(this.expenseRepo) : super(CostProjectState());

  addCostElement(Transaction element) async {
    var projectId = state.projectId;
    if (projectId == null) {
      return;
    }
    var newVal = await expenseRepo.addCostToProject(projectId, element);
    emit(state.copyWith(costProject: newVal));
  }

  fetchCostElements(String projectId) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    var newVal = await expenseRepo.getCostProjectById(projectId);
    emit(state.copyWith(
        projectId: projectId,
        costProject: newVal,
        status: ProjectStatus.loaded));
  }
}
