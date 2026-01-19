import 'dart:async';

import 'package:blocPlants/data/cart_item.dart';
import 'package:blocPlants/data/wishlist_items.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/grocery_data.dart';
import '../../../constant/constant.dart';
import '../models/home_product_data.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //for test delay
  final bool enableDelay;
  // Pagination state
  int _currentIndex = 0;
  bool _isLoadingMore = false;

  // Full data (client-side)
  final List<ProductDataModel> _allProducts = [];

  HomeBloc({required this.enableDelay}) : super(HomeInitial()) {
    on<InitEvent>(_initEvent);
    on<HomeLoadMoreEvent>(_homeLoadMoreEvent);

    // Product actions
    on<HomeProductWishlistButtonClickedEvent>(
        _homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(
        _homeProductCartButtonClickedEvent);
       /* to show message only*/
    // on<HomeProductWishlistButtonClickedEvent>();
    // Navigation actions
    on<HomeWishlistButtonNavigateEvent>(_homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(_homeCartButtonNavigateEvent);
  }

  // ---------------- INIT ----------------
  Future<void> _initEvent(
      InitEvent event,
      Emitter<HomeState> emit,
      ) async {

    emit(HomeLoadingState());

    // Simulate API delay
    // ⏱ Delay ONLY if enabled
    if (enableDelay) {
      await Future.delayed(const Duration(seconds: 1));
    }

    _allProducts.clear();
    _allProducts.addAll(
      GroceryData.plants.map(
            (e) => ProductDataModel(
          id: e['id'],
          name: e['name'],
          description: e['description'],
          price: e['price'],
          imageUrl: e['imageUrl'],
        ),
      ),
    );

    _currentIndex = AppConstant.pageSize;

    emit(
      HomeLoadedSuccessState(
        _allProducts.take(_currentIndex).toList(),
        hasMore: _currentIndex < _allProducts.length,
      ),
    );
  }

  // ---------------- LOAD MORE ----------------
  Future<void> _homeLoadMoreEvent(
      HomeLoadMoreEvent event,
      Emitter<HomeState> emit,
      ) async {
    // 🔒 Guards (VERY IMPORTANT)
    if (_isLoadingMore) return;
    if (_currentIndex >= _allProducts.length) return;

    _isLoadingMore = true;

    // Optional delay for smoother UX
    // ⏱ Delay ONLY if enabled
    if (enableDelay) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    _currentIndex += AppConstant.pageSize;
    if (_currentIndex > _allProducts.length) {
      _currentIndex = _allProducts.length;
    }

    emit(
      HomeLoadedSuccessState(
        _allProducts.take(_currentIndex).toList(),
        hasMore: _currentIndex < _allProducts.length,
      ),
    );

    _isLoadingMore = false;
  }

  // ---------------- PRODUCT ACTIONS ----------------
  void _homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event,
      Emitter<HomeState> emit,
      ) {
    // handle wishlist add logic later
    print("wishlist me add");
    wishListItems.add(event.clickedProduct);
    emit(HomeProductItemWishListedState());
  }

  void _homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event,
      Emitter<HomeState> emit,
      ) {
    // handle cart add logic later
    print("cart me add");
    cartListItems.add(event.clickedProduct);
    emit(HomeProductItemCartedState());
  }

  // ---------------- NAVIGATION ----------------
  void _homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event,
      Emitter<HomeState> emit,
      ) {
    emit(HomeNavigationToWishlistPageActionState());
  }

  void _homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event,
      Emitter<HomeState> emit,
      ) {
    emit(HomeNavigationToCartPageActionState());

    testMy();


  }
}
void testMy(){
  print("will dod some");
}

