import 'dart:io';

import 'package:blocPlants/features/home/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../bloc/home_event.dart';
import '../models/home_product_data.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel product;
  HomeBloc homeBloc;

   ProductTileWidget({
    super.key,
    required this.product,
    required this.homeBloc
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Product Image

            (kIsWeb)?AspectRatio(
            aspectRatio: 1,
             child:  CachedNetworkImage(
               imageUrl: product.imageUrl,
               cacheManager: CustomCacheManager.instance,
               fit: BoxFit.cover,
               placeholder: (context, url) =>
               const Center(child: CircularProgressIndicator()),
               errorWidget: (context, url, error) {
                 debugPrint("Image error: $error");
                 return const Icon(Icons.image_not_supported);
               },
             )
          ):Platform.isAndroid ?
             Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.image_not_supported),
            ):Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
        const Icon(Icons.image_not_supported),
      ),

          // 🔹 Product Info
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
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

                // Description
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 6),

                // Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${product.price}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),

                     Row(
                       children: [
                         IconButton(
                           onPressed: () {
                             homeBloc.add(HomeProductWishlistButtonClickedEvent(clickedProduct: product));
                           },
                           icon: Icon(Icons.favorite_border),
                         ),
                         IconButton(
                           onPressed: () {
                             homeBloc.add(HomeProductCartButtonClickedEvent(product));
                           },
                           icon: Icon(Icons.shopping_bag_outlined),
                         ),
                       ],
                     )
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

class CustomCacheManager {
  static const key = 'customImageCache';

  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );
}