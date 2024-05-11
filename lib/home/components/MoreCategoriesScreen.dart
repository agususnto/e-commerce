import 'package:flutter/material.dart';
import 'package:ecommerce/products/products_screen.dart';

class MoreCategoriesScreen extends StatelessWidget {
  MoreCategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.apple, "text": "Apple", "category": "Buah-buahan"},
    {"icon": Icons.rice_bowl, "text": "Beras", "category": "Beras"},
    {"icon": Icons.favorite, "text": "Kesehatan", "category": "Kesehatan"},
    {"icon": Icons.directions_run, "text": "Olahraga", "category": "Olahraga"},
    {"icon": Icons.local_dining, "text": "Kuliner", "category": "Kuliner"},
    {"icon": Icons.brush, "text": "Hobi", "category": "Hobi"},
    {"icon": Icons.directions_car, "text": "Otomotif", "category": "Otomotif"},
    {"icon": Icons.menu_book, "text": "Buku", "category": "Buku"},
    {"icon": Icons.weekend, "text": "Furniture", "category": "Furniture"},
    {
      "icon": Icons.home,
      "text": "Alat Rumah Tangga",
      "category": "Alat Rumah Tangga"
    },
    {"icon": Icons.toys, "text": "Mainan Anak", "category": "Mainan Anak"},
    {
      "icon": Icons.card_giftcard,
      "text": "Tiket & Voucher",
      "category": "Tiket & Voucher"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More Categories"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              final String? category = categories[index]["category"];
              if (category != null) {
                // Navigasi ke halaman ProductsScreen dengan kategori yang sesuai
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(
                      category: category,
                      products: const [],
                    ),
                  ),
                );
              } else {
                // Penanganan jika category bernilai null
                // Misalnya, tampilkan pesan kesalahan atau lakukan tindakan lain
              }
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.red[700],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      categories[index]["icon"],
                      size: 40.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      categories[index]["text"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
