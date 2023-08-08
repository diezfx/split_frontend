import 'package:flutter_bloc/flutter_bloc.dart';

import '../expenses/expenses.dart';
import '../expenses/repository.dart';

enum CostElementStatus {
  initial,
  loading,
  loaded,
  failed,
}

sealed class CostElementState {}

class Initial extends CostElementState {}

class Error extends CostElementState {}

class Loading extends CostElementState {
  String projectId;
  String elementId;

  Loading(this.projectId, this.elementId);
}

class CostElementStateLoaded extends CostElementState {
  final String projectId;
  final String elementId;
  Transaction costElement;

  CostElementStateLoaded(this.projectId, this.elementId, this.costElement);
}

class CostElementCubit extends Cubit<CostElementState> {
  final IExpenseRepository _expensesRepository;

  CostElementCubit(this._expensesRepository) : super(Initial());

  loadElement(String projectId, String elementId) async {
    emit(Loading(projectId, elementId));
    var project = await _expensesRepository.getCostProjectById(projectId);
    var element = project?.costElements
        .where((element) => element.id == elementId)
        .firstOrNull;
    if (element == null) {
      emit(Error());
      return;
    }
    emit(CostElementStateLoaded(projectId, elementId, element));
  }
}
