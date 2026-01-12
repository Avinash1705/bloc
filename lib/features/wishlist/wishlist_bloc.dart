import 'package:bloc/bloc.dart';

import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistState().init());

  @override
  Stream<WishlistState> mapEventToState(WishlistEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<WishlistState> init() async {
    return state.clone();
  }
}
