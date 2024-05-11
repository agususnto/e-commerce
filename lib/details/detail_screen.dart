import 'package:flutter/material.dart';

import '../cart/cart.dart';
import '../utils/cart_local_storage.dart';
import '../models/Product.dart';
import '../models/Cart.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({required this.product, Key? key}) : super(key: key);

  @override
  createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(14),
                // ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Navigasi ke halaman keranjang di sini
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(
                              cartItems: [],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_checkout),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(product: widget.product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: widget.product,
                  pressOnSeeMore: () {},
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // Recommend Products
          TopRoundedContainer(
            color: Colors.white,
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: demoProducts.length > 8 ? 8 : demoProducts.length,
                itemBuilder: (context, index) {
                  final recommendedProduct = demoProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(product: recommendedProduct),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              recommendedProduct.images[0],
                              height: 100,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            recommendedProduct.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatPrice(recommendedProduct.priceIDR),
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: const Text('Add to Cart'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Select quantity:'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                    color: Colors.red,
                                  ),
                                  Text(quantity.toString()),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // Tambahkan produk ke dalam keranjang dengan jumlah yang dipilih
                                Cart cartItem = Cart(
                                  product: widget.product,
                                  numOfItem: quantity,
                                );

                                // Tampilkan pesan konfirmasi
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Added $quantity ${widget.product.title} to cart',
                                    ),
                                  ),
                                );

                                // Kirim item keranjang ke halaman CartPage
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CartPage(cartItems: [cartItem]),
                                  ),
                                );

                                List<Cart> cartItems =
                                    await CartLocalStorage.getCart();
                                cartItems.add(cartItem);

                                // Save updated cart items
                                await CartLocalStorage.saveCart(cartItems);
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}
