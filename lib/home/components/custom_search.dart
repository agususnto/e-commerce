import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:delayed_display/delayed_display.dart';

import '../../details/detail_screen.dart';
import '../../models/Product.dart';
import '../../components/product_card.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Product> products;
  late SharedPreferences prefs;
  Product? lastViewedProduct;
  List<String> recentTexts = [];

  CustomSearchDelegate({required this.products}) {
    loadRecentTexts();
  }

  Future<void> loadRecentTexts() async {
    prefs = await SharedPreferences.getInstance();
    recentTexts = prefs.getStringList('recentTexts') ?? [];
  }

  void saveRecentTexts(String query) {
    if (!recentTexts.contains(query)) {
      recentTexts.insert(0, query);
      prefs.setStringList('recentTexts', recentTexts);
    }
  }

  void removeRecentText(String text) {
    recentTexts.remove(text);
    prefs.setStringList('recentTexts', recentTexts);
    // showSuggestions(context); // Refresh the UI after removing recent text
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Product> searchResults = query.isEmpty
        ? []
        : products
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: searchResults.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.7,
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) => ProductCard(
          product: searchResults[index],
          onPress: () {
            lastViewedProduct = searchResults[index];
            saveRecentTexts(query);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  product: searchResults[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Product> suggestedProducts = products
        .where((product) =>
            product.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    List<Product> limitedSuggestions = [];
    if (lastViewedProduct != null) {
      limitedSuggestions.add(lastViewedProduct!);
    }

    while (limitedSuggestions.length < 4) {
      final additionalProduct = products.firstWhere(
          (product) =>
              !limitedSuggestions.contains(product) &&
              product != lastViewedProduct,
          orElse: () => suggestedProducts.isNotEmpty
              ? suggestedProducts.first
              : products.first);
      limitedSuggestions.add(additionalProduct);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Anda Mungkin Juga Suka',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 3)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Jika masih menunggu, tampilkan efek shimmer
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Row(
                    children: limitedSuggestions
                        .map((product) => DelayedDisplay(
                              delay: const Duration(milliseconds: 200),
                              child: GestureDetector(
                                onTap: () {
                                  lastViewedProduct = product;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsScreen(product: product),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(
                                          product.images[0],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                );
              } else {
                // Jika sudah selesai menunggu, tampilkan produk
                return Row(
                  children: limitedSuggestions
                      .map((product) => GestureDetector(
                            onTap: () {
                              lastViewedProduct = product;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(product: product),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage(
                                      product.images[0],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Pencarian Terbaru',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: recentTexts.isEmpty
              ? [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              height: 24,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              : recentTexts
                  .map((text) => DelayedDisplay(
                        delay: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time, color: Colors.grey),
                              const SizedBox(width: 8),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    query = text;
                                    showResults(context);
                                  },
                                  child: Text(
                                    text,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.grey),
                                onPressed: () {
                                  removeRecentText(text);
                                },
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
        ),
      ],
    );
  }
}
