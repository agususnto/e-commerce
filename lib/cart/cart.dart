import 'package:flutter/material.dart';
// import 'package:ecommerce/widgets/text_widget.dart';

import '../utils/cart_local_storage.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';
import '../models/Cart.dart';

class CartPage extends StatefulWidget {
  final List<Cart> cartItems;

  const CartPage({required this.cartItems, Key? key}) : super(key: key);

  @override
  createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Cart> _cartItems;
  late double _totalPrice;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.cartItems;
    _calculateTotalPrice();
    _loadCartItems();
  }

  void _calculateTotalPrice() {
    double totalPrice = 0;
    for (var cartItem in _cartItems) {
      totalPrice += cartItem.product.priceIDR * cartItem.numOfItem;
    }
    setState(() {
      _totalPrice = totalPrice;
    });
  }

  void _updateItemQuantity(int index, int quantity) {
    setState(() {
      _cartItems[index].numOfItem = quantity;
      _calculateTotalPrice();
      if (quantity == 0) {
        _removeCartItem(index);
      }
    });
  }

  void _loadCartItems() async {
    List<Cart> cartItems = await CartLocalStorage.getCart();
    setState(() {
      _cartItems = cartItems;
      _calculateTotalPrice();
    });
  }

  void _removeCartItem(int index) async {
    setState(() {
      _cartItems.removeAt(index);
      _calculateTotalPrice();
    });
    await CartLocalStorage.saveCart(_cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            true, // Menampilkan ikon back secara otomatis
        title: const Text('Cart',
            style: TextStyle(color: Colors.white)), // Warna teks putih
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            const IconThemeData(color: Colors.white), // Warna ikon back putih
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: _cartItems.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(_cartItems[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _calculateTotalPrice();
                _removeCartItem(index);
                setState(() {});
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 236, 4, 4),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Spacer(),
                    Icon(Icons.delete),
                  ],
                ),
              ),
              child: CartCard(
                cart: _cartItems[index],
                onQuantityChanged: (quantity) =>
                    _updateItemQuantity(index, quantity),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CheckoutCard(totalPrice: _totalPrice),
    );
  }
}
