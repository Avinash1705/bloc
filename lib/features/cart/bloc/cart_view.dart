import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/product_tile_cart.dart';
import 'cart_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc _cartBloc = CartBloc();

  @override
  void initState() {
    _cartBloc.add(CartInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal, title: Text("Cart")),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: _cartBloc,
        listener: (context, state) {},
        listenWhen: (prev, curr) => curr is CartActionState,
        buildWhen: (prev, curr) => curr is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            // now finally use state
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                itemCount: successState.cartItems.length,
                itemBuilder: (context, index) => ProductTileCart(
                  product: successState.cartItems[index],
                  cartBloc: _cartBloc,
                ),
              );
          }
          return Container();
        },
      ),
    );
    ;
  }
}
