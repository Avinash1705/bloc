import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocPlants/data/cart_item.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  // CartBloc(super.initialState);    old style
  CartBloc() :super(CartInitial()){
    //3rd -- told event
    on<CartInitEvent>(_cartInitEvent);
    on<CartRemoveFromCartEvent>(_cartRemoveFromCartEvent);
  }

  //4th
  FutureOr<void> _cartInitEvent(CartInitEvent event, Emitter<CartState> emit) {
    //what u want to do
    //5th  -- told state
    emit(CartSuccessState(cartItems: cartListItems));
  }

  FutureOr<void> _cartRemoveFromCartEvent(CartRemoveFromCartEvent event, Emitter<CartState> emit) async{
    emit(CartLoadingState());

    try{
      await Future.delayed(Duration(seconds: 2));
      //remove that event
      cartListItems.remove(event.cartItems);   /*obj removed*/
      emit(CartItemRemovedMessageState());
      emit(CartSuccessState(cartItems: cartListItems));
    }
    catch(ex){
      emit(CartErrorState(message: "Obj Error Catch"));
    }
  }
}