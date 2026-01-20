abstract class WishlistEvent {}

class InitEvent extends WishlistEvent {}

class RemoveFromWishListEvent extends WishlistEvent {
  final item ;
  RemoveFromWishListEvent({required this.item});
}