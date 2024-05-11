import 'package:flutter/material.dart';
import 'package:ecommerce/utils/wishlist_local_storage.dart';

import '../constants.dart';
import '../models/Product.dart';
import 'package:ecommerce/constants.dart' as constants;

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRatio;
  final Product product;
  final VoidCallback onPress;

  @override
  createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _loadIsLiked();
  }

  void _loadIsLiked() async {
    bool isInWishlist =
        await WishlistLocalStorage.isInWishlist(widget.product.id);
    setState(() {
      isLiked = isInWishlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onTap: widget.onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            AspectRatio(
              aspectRatio: widget.aspectRatio,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(widget.product.images[0]),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  constants.formatPrice(widget.product.priceIDR),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    if (isLiked) {
                      await WishlistLocalStorage.addToWishlist(
                          widget.product.id);
                    } else {
                      await WishlistLocalStorage.removeFromWishlist(
                          widget.product.id);
                    }
                  },
                  child: SizedBox(
                    // padding: const EdgeInsets.all(5),
                    height: 24,
                    width: 24,
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : kPrimaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
