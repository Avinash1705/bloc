import 'package:blocPlants/features/cart/bloc/cart_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../home/models/home_product_data.dart';
import '../../home/ui/product_tile_widget.dart';

class ProductTileCart extends StatelessWidget {
  final ProductDataModel product;
  final CartBloc cartBloc;

  const ProductTileCart({
    super.key,
    required this.product,
    required this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.green.shade50,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: AspectRatio(
              aspectRatio: 1,
              child: kIsWeb
                  ? CachedNetworkImage(
                imageUrl: product.imageUrl,
                cacheManager: CustomCacheManager.instance,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) =>
                const Icon(Icons.image_not_supported),
              )
                  : Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported),
              ),
            ),
          ),

          /// DETAILS
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 10),

                /// PRICE + ACTIONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "₹${product.price}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        _ActionIcon(
                          icon: Icons.favorite_border,
                          onTap: () {
                            // cartBloc.add(
                            //   HomeProductWishlistButtonClickedEvent(
                            //     clickedProduct: product,
                            //   ),
                            // );
                          },
                        ),
                        const SizedBox(width: 8),
                        _ActionIcon(
                          icon: Icons.shopping_bag,
                          onTap: () {

                            // cartBloc.add(
                            //   HomeProductCartButtonClickedEvent(product),
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
class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionIcon({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.green.shade800,
        ),
      ),
    );
  }
}

