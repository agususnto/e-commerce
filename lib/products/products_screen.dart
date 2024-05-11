import 'package:flutter/material.dart';
import 'package:ecommerce/components/product_card.dart';
import 'package:ecommerce/models/Product.dart';
import '../details/detail_screen.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:delayed_display/delayed_display.dart';

class ProductsScreen extends StatefulWidget {
  final String category;
  final List<Product> products;

  const ProductsScreen({
    Key? key,
    required this.category,
    required this.products,
  }) : super(key: key);

  @override
  createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late List<Product> filteredProducts;
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.products.isNotEmpty) {
      filteredProducts = widget.products;
    } else {
      loadProducts();
    }
  }

  Future<void> loadProducts() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        isLoading = false;
        filteredProducts = demoProducts
            .where((product) =>
                product.category.toLowerCase() == widget.category.toLowerCase())
            .toList();
      });
    }
  }

  void filterSearchResults(String query) {
    List<Product> dummySearchList = [];
    dummySearchList.addAll(filteredProducts);
    if (query.isNotEmpty) {
      List<Product> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.title.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredProducts.clear();
        filteredProducts.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredProducts.clear();
        filteredProducts.addAll(demoProducts
            .where((product) =>
                product.category.toLowerCase() == widget.category.toLowerCase())
            .toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                onChanged: filterSearchResults,
                decoration: const InputDecoration(
                  labelText: "Search products",
                  prefixIcon: Icon(Icons.search),
                  // border: OutlineInputBorder(),
                ),
              )
            : Text(widget.category),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  filteredProducts.clear();
                  filteredProducts.addAll(demoProducts
                      .where((product) =>
                          product.category.toLowerCase() ==
                          widget.category.toLowerCase())
                      .toList());
                  searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: GridView.builder(
                    itemCount: 6, // Example: Show 6 shimmering product cards
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 20,
                    ),
                    // itemBuilder: (context, index) => const DelayedDisplay(
                    //   delay: Duration(milliseconds: 200),
                    //   child: ProductCardShimmer(),
                    // ),
                    itemBuilder: (context, index) => const ProductCardShimmer(),
                  ),
                )
              : GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.7,
                    // mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    product: filteredProducts[index],
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            product: filteredProducts[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 200,
              height: 170,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              height: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              height: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
