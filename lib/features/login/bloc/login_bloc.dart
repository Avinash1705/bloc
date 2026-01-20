import 'dart:async';

import 'package:bloc/bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() :super(LoginInitState()){

    on<LoginRedirectionToHomeEvent>(_loginRedirectionToHomeEvent);
  }

  FutureOr<void> _loginRedirectionToHomeEvent(LoginRedirectionToHomeEvent event, Emitter<LoginState> emit) {
    print("emitted state art logn");
    emit(LoginRedirectionToHomeState());
  }
}
