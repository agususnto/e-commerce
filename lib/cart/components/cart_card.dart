import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/Cart.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
    required this.onQuantityChanged,
  }) : super(key: key);

  final Cart cart;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(cart.product.images[0]),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    onQuantityChanged(cart.numOfItem - 1);
                  },
                  icon: const Icon(Icons.remove),
                  color: Colors.red,
                ),
                Text(
                  '${cart.numOfItem}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                IconButton(
                  onPressed: () {
                    onQuantityChanged(cart.numOfItem + 1);
                  },
                  icon: const Icon(Icons.add),
                  color: Colors.red,
                ),
              ],
            ),
            Text(
              'Total: ${formatPrice(cart.product.priceIDR * cart.numOfItem)}',
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: kPrimaryColor),
            ),
          ],
        )
      ],
    );
  }
}
