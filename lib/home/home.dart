import 'package:flutter/material.dart';
import 'components/categories.dart';
import '../models/Product.dart';
import '../products/products_screen.dart';
import '../utils/wishlist_local_storage.dart';
import '../cart/cart.dart';
import 'components/custom_search.dart';
import 'components/discount_banner.dart';
import 'components/special_offers.dart';
import 'components/popular_product.dart';
import 'components/MoreCategoriesScreen.dart';
// import 'components/barcode.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          width: double.infinity,
          height: 42,
          child: InkWell(
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(products: demoProducts),
              );
            },
            child: const Card(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const BarcodeScannerScreen()),
              // );
            },
            icon: const Icon(Icons.qr_code_2_sharp),
          ),
          IconButton(
            onPressed: () {
              // Navigasi ke halaman keranjang
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
          ),
          IconButton(
            onPressed: () async {
              List<Product> wishlistProducts =
                  await WishlistLocalStorage.getWishlistProducts();
              Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsScreen(
                    category: "Wishlist",
                    products: wishlistProducts,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.bookmark),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DiscountBanner(),
            Categories(
              onCategoryTap: (category) {
                // Navigasi ke halaman ProductsScreen dengan kategori yang dipilih
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(
                      category: category,
                      products: const [],
                    ),
                  ),
                );
              },
              onMoreTap: () {
                // Navigasi ke halaman MoreCategoriesScreen saat kategori "More" diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoreCategoriesScreen(),
                  ),
                );
              },
            ),
            const SpecialOffers(),
            const SizedBox(height: 20),
            const PopularProducts(),
            const SizedBox(height: 20),
            // Widget lainnya
          ],
        ),
      ),
    );
  }
}
