import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';
import 'package:ecommerce/utils/wishlist_local_storage.dart';
import 'package:ecommerce/models/Product.dart' as product_model;

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool showFullDescription = false;
  bool isLiked = false; // Inisialisasi dengan nilai default false

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : kPrimaryColor,
                ),
                onPressed: () async {
                  setState(() {
                    isLiked = !isLiked;
                  });
                  if (isLiked) {
                    await WishlistLocalStorage.addToWishlist(widget.product.id);
                  } else {
                    await WishlistLocalStorage.removeFromWishlist(
                        widget.product.id);
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            product_model.formatPrice(widget.product.priceIDR),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Size: ${widget.product.size}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Stock: ${widget.product.stock}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            showFullDescription || widget.product.description.length <= 100
                ? widget.product.description
                : "${widget.product.description.substring(0, 100)}...",
            maxLines: showFullDescription ? null : 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            onTap: () {
              if (widget.product.description.length > 100) {
                setState(() {
                  showFullDescription = !showFullDescription;
                });
                if (widget.pressOnSeeMore != null) {
                  widget.pressOnSeeMore!();
                }
              }
            },
            child: Row(
              children: [
                Text(
                  widget.product.description.length > 100
                      ? showFullDescription
                          ? "See Less Detail"
                          : "See More Detail"
                      : "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  widget.product.description.length > 100
                      ? Icons.arrow_forward_ios
                      : null,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
