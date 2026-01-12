// class HomeState {
//   HomeState init() {
//     return HomeState();
//   }
//
//   HomeState clone() {
//     return HomeState();
//   }
// }

//base state
import '../models/home_product_data.dart';

abstract class HomeState {}

//ui state
 class HomeInitial  extends HomeState{}

 class HomeLoadingState extends HomeState{}
 class HomeLoadedSuccessState extends HomeState{
  final List<ProductDataModel> items;
  final bool hasMore;
  HomeLoadedSuccessState(this.items,{required this.hasMore});
 }
 class HomeErrorState extends HomeState{
  final String message;
  HomeErrorState(this.message);
 }

//action state(one time event)
abstract class HomeActionState extends HomeState{}
 class HomeNavigationToWishlistPageActionState extends HomeActionState{}
 class HomeNavigationToCartPageActionState extends HomeActionState{}