import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/bloc/cart_view.dart';
import '../../wishlist/wishlist_view.dart';
import '../ui/product_tile_widget.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc(enableDelay: false);
  //work on test case
  @override
  void initState() {
    homeBloc.add(InitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (prev, curr) => curr is HomeActionState,
      buildWhen: (prev, curr) {
        return curr is! HomeActionState;
      },
      listener: (context, state) {
        if (state is HomeNavigationToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WishlistPage()),
          );
        } else if (state is HomeNavigationToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.amber,
                title: const Text(
                  "Plants App 🌱",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  homeBloc.add(InitEvent());
                },
                child: (successState.items.isEmpty)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_florist,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text("No plants available"),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            successState.items.length +
                            (successState.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == successState.items.length) {
                            homeBloc.add(HomeLoadMoreEvent());
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }

                          return ProductTileWidget(
                            product: successState.items[index],
                          );
                        },
                      ),
              ),
            );
          case HomeErrorState:
            return Scaffold(body: Center(child: Text("Error")));
          default:
            return SizedBox();
        }
      },
    );
  }
}
