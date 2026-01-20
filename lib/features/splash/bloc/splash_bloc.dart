import 'package:bloc/bloc.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState().init());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<SplashState> init() async {
    return state.clone();
  }
}
