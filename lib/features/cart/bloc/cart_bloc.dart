import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocPlants/data/cart_item.dart';

import 'cart_event.dart';
import 'cart_state.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(CartState().init());
//
//   @override
//   Stream<CartState> mapEventToState(CartEvent event) async* {
//     if (event is InitEvent) {
//       yield await init();
//     }
//   }
//
//   Future<CartState> init() async {
//     return state.clone();
//   }
// }

class CartBloc extends Bloc<CartEvent,CartState>{
  // CartBloc(super.initialState);    old style
  CartBloc() :super(CartInitial()){
    //3rd -- told event
    on<CartInitEvent>(_cartInitEvent);
  }

  //4th
  FutureOr<void> _cartInitEvent(CartInitEvent event, Emitter<CartState> emit) {
    //what u want to do
    //5th  -- told state
    emit(CartSuccessState(cartItems: cartListItems));
  }
}