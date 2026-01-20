// class CartState {
//   CartState init() {
//     return CartState();
//   }
//
//   CartState clone() {
//     return CartState();
//   }
// }


import 'package:blocPlants/features/home/models/home_product_data.dart';

class CartState {}

//base
class CartInitial extends CartState{}

//widgets
class CartSuccessState extends CartState{
  //product which were card me added
  final List<ProductDataModel> cartItems ;

  CartSuccessState({required this.cartItems});
}

class CartLoadingState extends CartState{}
class CartErrorState  extends CartState{
  final message ;
  CartErrorState({this.message = "Items didn't remove"});
}


//action
class CartActionState extends CartState{}

class CartItemRemovedMessageState extends CartActionState {}