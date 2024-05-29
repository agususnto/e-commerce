import 'package:flutter/material.dart';
import '../models/Product.dart';
import '../products/products_screen.dart';
import '../utils/wishlist_local_storage.dart';
import '../home/components/custom_search.dart';
import '../cart/cart.dart';
import '../home/components/recomended_product.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Discovery extends StatefulWidget {
  const Discovery({super.key});

  @override
  _DiscoveryState createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.apple, "text": "Apple", "category": "Buah-buahan"},
    {"icon": Icons.rice_bowl, "text": "Beras", "category": "Beras"},
    {"icon": Icons.favorite, "text": "Kesehatan", "category": "Kesehatan"},
    {"icon": Icons.directions_run, "text": "Olahraga", "category": "Olahraga"},
    {"icon": Icons.local_dining, "text": "Kuliner", "category": "Kuliner"},
    {"icon": Icons.brush, "text": "Hobi", "category": "Hobi"},
    {"icon": Icons.directions_car, "text": "Otomotif", "category": "Otomotif"},
    {"icon": Icons.menu_book, "text": "Buku", "category": "Buku"},
  ];

  final List<String> bannerImages = [
    // 'https://via.placeholder.com/400x200',
    'assets/images/voucher.png',
    'assets/images/voucher2.png',
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 200, // Tentukan tinggi banner sesuai kebutuhan
              child: PageView.builder(
                controller: _pageController,
                itemCount: bannerImages.length,
                onPageChanged: (index) {
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        bannerImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: bannerImages.length,
                effect: WormEffect(
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotColor: Colors.grey,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      final String? categoryText = category["category"];
                      if (categoryText != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              category: categoryText,
                              products: const [],
                            ),
                          ),
                        );
                      } else {
                        // Penanganan jika category bernilai null
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Category not available!'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            category["icon"],
                            size: 40.0,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            category["text"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const RecommendedProducts(),
          ],
        ),
      ),
    );
  }
}
