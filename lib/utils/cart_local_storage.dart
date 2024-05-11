import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Cart.dart';

class CartLocalStorage {
  static const _cartKey = 'cart';

  // Menyimpan keranjang belanja ke penyimpanan lokal
  static Future<void> saveCart(List<Cart> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartString =
        jsonEncode(cartItems.map((cart) => cart.toJson()).toList());
    await prefs.setString(_cartKey, cartString);
  }

  // Mengambil keranjang belanja dari penyimpanan lokal
  static Future<List<Cart>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString(_cartKey);
    if (cartString != null) {
      final List<dynamic> cartJson = jsonDecode(cartString);
      return cartJson.map((item) => Cart.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
