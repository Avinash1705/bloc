import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/models/home_product_data.dart';
import '../../home/ui/product_tile_widget.dart';
import '../wishlist_bloc.dart';
import '../wishlist_event.dart';
import 'glass_action_icon.dart';

class ProductTileWishlist extends StatelessWidget {
  final ProductDataModel product;


  const ProductTileWishlist({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 90,
              height: 90,
              child: kIsWeb
                  ? CachedNetworkImage(
                imageUrl: product.imageUrl,
                cacheManager: CustomCacheManager.instance,
                fit: BoxFit.cover,
              )
                  : Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.teal,
                      ),
                    ),

                    Row(
                      children: [
                        /// REMOVE FROM WISHLIST
                        GlassActionIcon(
                          icon: Icons.favorite,
                          color: Colors.red,
                          onTap: () {
                            context.read<WishlistBloc>().add(RemoveFromWishListEvent(item: product));
                          },
                        ),

                        const SizedBox(width: 8),

                        /// ADD TO CART
                        GlassActionIcon(
                          icon: Icons.shopping_bag_outlined,
                          color: Colors.green,
                          onTap: () {
                            // context.read<CartBloc>().add(
                            //   CartAddItemEvent(cartItems: product),
                            // );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

