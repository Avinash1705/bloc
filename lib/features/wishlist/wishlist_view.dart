import 'package:blocPlants/features/cart/bloc/cart_bloc.dart';
import 'package:blocPlants/features/cart/bloc/cart_state.dart';
import 'package:blocPlants/features/home/models/home_product_data.dart';
import 'package:blocPlants/features/wishlist/widgets/product_tile_wishlist.dart';
import 'package:blocPlants/features/wishlist/animation/professional_fab.dart';
import 'package:blocPlants/features/wishlist/wishlist_bloc.dart';
import 'package:blocPlants/features/wishlist/wishlist_event.dart';
import 'package:blocPlants/features/wishlist/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/bloc/cart_view.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WishlistBloc()..add(InitEvent()),

      // 🔑 THIS BUILDER IS THE KEY
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text("Wishlist"),
          ),

          body: BlocConsumer<WishlistBloc, WishlistState>(
            listenWhen: (prev, curr) => curr is WishlistActionState,
            buildWhen: (prev, curr) => curr is! WishlistActionState,

            listener: (context, state) {
              if (state is NavigateToCartPageActionState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartPage()),
                );
              }
            },

            builder: (context, state) {
              if (state is LoadingWishListState) {
                return const Center(
                    child: CircularProgressIndicator());
              }

              if (state is EmptyWishListState) {
                return const Center(
                  child: Text("Your wishlist is empty ❤️"),
                );
              }

              if (state is SuccessState) {
                return ListView.builder(
                  itemCount: state.wishListData.length,
                  itemBuilder: (context, index) =>
                      ProductTileWishlist(
                        product: state.wishListData[index],
                      ),
                );
              }

              return const SizedBox();
            },
          ),

          floatingActionButton: ProfessionalFab(
            onPressed: () {
              // ✅ ALSO WORKS HERE
              context
                  .read<WishlistBloc>()
                  .add(NavigateToCartPageEvent());
            },
          ),
        );
      },) 
    );
  }
}


