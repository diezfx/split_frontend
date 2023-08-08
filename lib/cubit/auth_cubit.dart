import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_frontend/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../pkg/logger/logger.dart';

sealed class AuthState {}

class LoggedOut extends AuthState {}

class LoggedIn extends AuthState {
  final Session session;

  LoggedIn(this.session);
}

class AuthCubit extends Cubit<AuthState> {
  final userStream = supabase.auth.onAuthStateChange;
  late StreamSubscription _sub;

  AuthCubit() : super(LoggedOut()) {
    final session = supabase.auth.currentSession;

    _sub = userStream.listen((event) {
      if (event.session == null) {
        emit(LoggedOut());
        return;
      }
      log.info("logged in user ${event.session}");
      emit(LoggedIn(event.session!));
    });

    if (session != null) {
      log.info("logged in user $session");
      emit(LoggedIn(session));
    }
  }
  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}
