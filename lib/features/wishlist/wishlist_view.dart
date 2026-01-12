import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'wishlist_bloc.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

// class WishlistPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => WishlistBloc()..add(InitEvent()),
//       child: Builder(builder: (context) => _buildPage(context)),
//     );
//   }
//
//   Widget _buildPage(BuildContext context) {
//     final bloc = BlocProvider.of<WishlistBloc>(context);
//
//     return Scaffold(appBar: AppBar(title: Text("Wishlist"),),);
//   }
// }
class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.teal,title: Text("Wishlist"),),);
  }
}

