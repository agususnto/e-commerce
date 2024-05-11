import 'package:shared_preferences/shared_preferences.dart';
import '../models/Product.dart';

class WishlistLocalStorage {
  static const String _wishlistKey = 'wishlist';

  static Future<void> addToWishlist(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList(_wishlistKey) ?? [];
    if (!wishlist.contains(productId.toString())) {
      wishlist.add(productId.toString());
      await prefs.setStringList(_wishlistKey, wishlist);
    }
  }

  static Future<void> removeFromWishlist(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList(_wishlistKey) ?? [];
    if (wishlist.contains(productId.toString())) {
      wishlist.remove(productId.toString());
      await prefs.setStringList(_wishlistKey, wishlist);
    }
  }

  static Future<List<Product>> getWishlistProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wishlistIds = prefs.getStringList(_wishlistKey) ?? [];
    List<Product> wishlistProducts = demoProducts
        .where((product) => wishlistIds.contains(product.id.toString()))
        .toList();
    return wishlistProducts;
  }

  static Future<void> clearWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_wishlistKey);
  }

  static Future<bool> isInWishlist(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<int> wishlist = prefs
            .getStringList(_wishlistKey)
            ?.map((id) => int.parse(id))
            .toList() ??
        [];
    return wishlist.contains(productId);
  }
}
