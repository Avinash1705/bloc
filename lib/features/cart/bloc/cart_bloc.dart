import 'package:bloc/bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState().init());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<CartState> init() async {
    return state.clone();
  }
}
