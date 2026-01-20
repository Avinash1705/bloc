import 'package:blocPlants/features/cart/bloc/cart_bloc.dart';
import 'package:blocPlants/features/cart/bloc/cart_state.dart';
import 'package:blocPlants/features/home/models/home_product_data.dart';
import 'package:blocPlants/features/wishlist/widgets/product_tile_wishlist.dart';
import 'package:blocPlants/features/wishlist/wishlist_bloc.dart';
import 'package:blocPlants/features/wishlist/wishlist_event.dart';
import 'package:blocPlants/features/wishlist/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistPage extends StatefulWidget {
  WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal, title: Text("Wishlist")),
      body: BlocProvider(
        create: (context) => WishlistBloc()..add(InitEvent()),
        child: BlocConsumer<WishlistBloc, WishlistState>(
          listenWhen: (prev, curr) => curr is WishlistActionState,
          buildWhen: (prev, curr) =>
              curr is InitWishListState ||
              curr is LoadingWishListState ||
              curr is SuccessState||
              curr is RemoveFromWishListEvent||
              curr is EmptyWishListState,
          listener: (context, state) {

          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingWishListState: return Center(child: CircularProgressIndicator());
              case EmptyWishListState :   return const Center(
                child: Text(
                  "Your wishlist is empty ❤️",
                  style: TextStyle(fontSize: 16),
                ),
              );
              case SuccessState:
                final successState = state as SuccessState;
                return ListView.builder(
                  itemCount: successState.wishListData.length,
                  itemBuilder: (context, index) => ProductTileWishlist(
                    product: successState.wishListData[index],
                  ),
                );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
