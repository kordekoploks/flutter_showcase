import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/router/app_router.dart';
import '../../../../domain/entities/product/product.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onClick;

  const ProductCard({
    Key? key,
    this.product,
    this.onFavoriteToggle,
    this.onClick,
  }) : super(key: key);

  bool get isLoading => product == null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.white,
              child: _buildBody(context),
            )
          : _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isLoading) {
          onClick?.call();
          Navigator.of(context).pushNamed(
            AppRouter.productDetails,
            arguments: product,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildImageCard()),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              height: 18,
              child: isLoading
                  ? _buildSkeleton(width: 120)
                  : Text(
                      product!.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              height: 18,
              child: isLoading
                  ? _buildSkeleton(width: 100)
                  : Text(
                      r'$' + product!.priceTags.first.price.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
          ),
        ],
      ),
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.all(4),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(24.0),
                child: ColoredBox(color: Colors.grey),
              )
            : Hero(
                tag: product!.id,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: CachedNetworkImage(
                    imageUrl: product!.images.first,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: Colors.white,
                      child: const ColoredBox(color: Colors.grey),
                    ),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildSkeleton({double width = double.infinity}) {
    return Container(
      width: width,
      height: 18,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
