import 'package:bloc/bloc.dart';

import '../expenses/expenses.dart';
import '../expenses/repository.dart';

sealed class UserState {}

class UserStateInitial extends UserState {}

class UserStateLoading extends UserState {
  final String userId;

  UserStateLoading(this.userId);
}

class UserStateLoaded extends UserState {
  final String userId;

  final List<CostProject> projects;

  UserStateLoaded(this.userId, this.projects);
}

class UserCubit extends Cubit<UserState> {
  final IExpenseRepository expensesRepository;
  UserCubit(this.expensesRepository) : super(UserStateInitial());

  loadUser(String userId) async {
    emit(UserStateLoading(userId));
    var projects = await expensesRepository.getCostProjectsByUser(userId);

    emit(UserStateLoaded(userId, projects));
  }

  addProject(CostProject project) async {
    if (state is! UserStateLoaded) {
      return;
    }
    var loadedState = state as UserStateLoaded;
    await expensesRepository.addnewProject(project);

    await loadUser(loadedState.userId);
  }
}
