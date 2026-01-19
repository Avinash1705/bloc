import 'package:blocPlants/features/home/models/home_product_data.dart';

abstract class HomeEvent {}

class InitEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  //way of passing data to event
  final ProductDataModel clickedProduct;

  HomeProductWishlistButtonClickedEvent({required this.clickedProduct});

}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductCartButtonClickedEvent(this.clickedProduct);
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}

class HomeLoadMoreEvent extends HomeEvent {}
