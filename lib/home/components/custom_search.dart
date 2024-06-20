import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../details/detail_screen.dart';
import '../../models/Product.dart';
import '../../components/product_card.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Product> products;
  late SharedPreferences prefs;
  List<String> recentTexts = [];
  List<String> recentProductIds = [];

  CustomSearchDelegate({required this.products}) {
    loadRecentData();
  }

  Future<void> loadRecentData() async {
    prefs = await SharedPreferences.getInstance();
    recentTexts = prefs.getStringList('recentTexts') ?? [];
    recentProductIds = prefs.getStringList('recentProductIds') ?? [];
  }

  void saveRecentText(String query) {
    if (!recentTexts.contains(query)) {
      recentTexts.insert(0, query);
      prefs.setStringList('recentTexts', recentTexts);
    }
  }

  void saveRecentProductId(String productId) {
    if (!recentProductIds.contains(productId)) {
      recentProductIds.insert(0, productId);
      // Limit recent product IDs to 4 items
      if (recentProductIds.length > 4) {
        recentProductIds.removeLast();
      }
      prefs.setStringList('recentProductIds', recentProductIds);
    }
  }

  void removeRecentText(String text) {
    recentTexts.remove(text);
    prefs.setStringList('recentTexts', recentTexts);
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

    if (searchResults.isEmpty) {
      return Center(
        child: SvgPicture.asset(
          'assets/icons/camera-svgrepo-com.svg', // Path to your SVG asset
          width: 200,
          height: 200,
        ),
      );
    }

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
            saveRecentText(query);
            saveRecentProductId(searchResults[index].id.toString());
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

    List<Product> recentProducts = recentProductIds
        .map((id) =>
            products.firstWhere((product) => product.id.toString() == id))
        .toList();

    List<Product> limitedSuggestions = [];

    // Add recent products first
    limitedSuggestions.addAll(recentProducts);

    // Add suggested products until we have 4 items
    for (int i = 0; i < suggestedProducts.length; i++) {
      if (limitedSuggestions.length >= 4) break;
      final product = suggestedProducts[i];
      if (!limitedSuggestions.contains(product)) {
        limitedSuggestions.add(product);
      }
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
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Row(
                    children: limitedSuggestions
                        .map((product) => DelayedDisplay(
                              delay: const Duration(milliseconds: 200),
                              child: GestureDetector(
                                onTap: () {
                                  saveRecentProductId(product.id.toString());
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
                return Row(
                  children: limitedSuggestions
                      .map((product) => GestureDetector(
                            onTap: () {
                              saveRecentProductId(product.id.toString());
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
