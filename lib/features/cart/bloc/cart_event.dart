abstract class CartEvent {}

class CartInitEvent extends CartEvent {}

//2nd
class CartRemoveFromCartEvent extends CartEvent{
  final cartItems ;

  CartRemoveFromCartEvent({required this.cartItems});
}

class CartItemRemovedMessageEvent extends CartEvent{}