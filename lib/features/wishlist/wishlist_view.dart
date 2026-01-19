import 'package:blocPlants/features/cart/bloc/cart_bloc.dart';
import 'package:blocPlants/features/cart/bloc/cart_state.dart';
import 'package:blocPlants/features/home/models/home_product_data.dart';
import 'package:blocPlants/features/wishlist/wishlist_bloc.dart';
import 'package:blocPlants/features/wishlist/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WishlistPage extends StatefulWidget {
  WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  //1st
  final WishlistBloc _wishlistBloc = WishlistBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal, title: Text("Wishlist"),),
      body: BlocConsumer<WishlistBloc, WishlistState>(bloc: _wishlistBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container();
        },
      ),);
  }
}

