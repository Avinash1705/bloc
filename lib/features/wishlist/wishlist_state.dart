// class WishlistState {
//   WishlistState init() {
//     return WishlistState();
//   }
//
//   WishlistState clone() {
//     return WishlistState();
//   }
// }

import 'package:blocPlants/features/home/models/home_product_data.dart';

class WishlistState {}
class WishlistActionState extends WishlistState {}

//ui
class InitWishListState extends WishlistState {}
class LoadingWishListState extends WishlistState{}
class SuccessState extends WishlistState{
  final List<ProductDataModel> wishListData;
  SuccessState({required this.wishListData});
}
class EmptyWishListState extends WishlistState {
  final message ;
  EmptyWishListState({this.message = "No item in Cart"});
}


//action
class NavigateToCartPage extends WishlistActionState{}