import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocPlants/data/wishlist_items.dart';

import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(InitWishListState()){
    on<InitEvent>(_initEvent);
    on<RemoveFromWishListEvent> (_removeFromWishListEvent);
  }





  FutureOr<void> _initEvent(InitEvent event, Emitter<WishlistState> emit) async{
    //lets load data
    emit(LoadingWishListState());
    try{
     await Future.delayed(Duration(seconds: 1));
     //all logic will go here
     if(wishListItems.isEmpty){
       emit(EmptyWishListState());
     }
      else {
       emit(SuccessState(wishListData: wishListItems));
     }
    }
    catch(ex){

    }
  }

  FutureOr<void> _removeFromWishListEvent(RemoveFromWishListEvent event, Emitter<WishlistState> emit) {
   // wishListItems.remove(event.item);   /*remove by id */
    wishListItems.removeWhere((item) => item.id == event.item.id);
    if(wishListItems.isEmpty){
      emit(EmptyWishListState());
    }
    else {
      emit(SuccessState(wishListData: wishListItems));
    }
  }
}
