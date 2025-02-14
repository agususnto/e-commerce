import 'package:intl/intl.dart';

class Product {
  final int id;
  final String title, description, category;
  final List<String> images;
  final String size;
  final String stock;
  final double rating, priceIDR;
  final bool isSpecial, isPopular, isRecomended;

  Product({
    required this.id,
    required this.images,
    this.rating = 0.0,
    // this.isSpecial = false,
    required this.isPopular,
    required this.isRecomended,
    required this.isSpecial,
    required this.title,
    required this.priceIDR,
    required this.description,
    required this.stock,
    required this.size,
    required this.category,
  });

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'priceIDR': priceIDR,
      'description': description,
      'stock': stock,
      'size': size,
      'category': category,
      'images': images,
      'rating': rating,
      'isFavourite': isSpecial,
      'isPopular': isPopular,
      'isRecomended': isRecomended,
    };
  }

  // Buat dari JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      priceIDR: json['priceIDR'],
      description: json['description'],
      stock: json['stock'],
      size: json['size'],
      category: json['category'],
      images: List<String>.from(json['images']),
      rating: json['rating'],
      isSpecial: json['isSpecial'] ?? false,
      isPopular: json['isPopular'],
      isRecomended: json['isRecomended'] ?? false,
    );
  }
}

// Our demo Products

List<Product> demoProducts = [
  Product(
      id: 1,
      images: [
        "assets/images/beras.png",
      ],
      title: "Beras",
      priceIDR: 80000,
      description:
          "Beras super dengan harga yang terjangkau Beras super dengan harga yang terjangkau Beras super dengan harga yang terjangkau Beras super dengan harga yang terjangkau sekali",
      rating: 4.1,
      size: "Medium",
      stock: "20",
      category: "Beras",
      isPopular: true,
      isRecomended: true,
      isSpecial: false),
  Product(
      id: 2,
      images: [
        "assets/images/beras2.png",
      ],
      // stocks: [
      //   const stock(0xFFF6625E),
      //   const stock(0xFF836DB8),
      //   const stock(0xFFDECB9C),
      //   stocks.20,
      // ],
      title: "Beras Pulen",
      priceIDR: 80000,
      description: "Deskripsi produk Nike Sport 20 - Man Pant",
      rating: 4.1,
      size: "Medium",
      stock: "20",
      category: "Beras",
      isSpecial: true,
      isPopular: false,
      isRecomended: true),
  Product(
      id: 3,
      images: [
        "assets/images/telur.png",
      ],
      // stocks: [
      //   const stock(0xFFF6625E),
      //   const stock(0xFF836DB8),
      //   const stock(0xFFDECB9C),
      //   stocks.20,
      // ],
      title: "Telur",
      priceIDR: 70000,
      description:
          "Deskripsi produk Gloves XC Omega - Polygon Deskripsi produk Gloves XC Omega - Polygon",
      rating: 4.1,
      size: "Medium",
      stock: "20",
      category: "Telur",
      // isFavourite: true,
      isPopular: true,
      isRecomended: false,
      isSpecial: false),
  Product(
    id: 4,
    images: [
      "assets/images/beras2.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Beras Larang",
    priceIDR: 70000,
    description: "Deskripsi produk Logitech Head",
    rating: 4.1,
    size: "Medium",
    stock: "20",
    category: "Beras",
    // isFavourite: true,
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 5,
    images: [
      "assets/images/beras2.png",
    ],
    title: "Beras Gajah Berdiri",
    priceIDR: 220000,
    description:
        "Beras gajah berdiri adalah beras berkualitas super yang dirawat seperti anak sendiri"
        " Beras gajah berdiri adalah beras berkualitas super yang dirawat seperti anak sendiri",
    rating: 8.0,
    size: "10 KG",
    stock: "20",
    category: "Beras",
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 6,
    images: [
      "assets/images/minyak.png",
      // "assets/images/ps4_console_20_2.png",
      // "assets/images/ps4_console_20_3.png",
      // "assets/images/ps4_console_20_4.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Minyak Rose Brand™",
    priceIDR: 70000,
    description: "Deskripsi produk Wireless Controller for PS4™",
    rating: 4.8,
    size: "Medium",
    stock: "20",
    category: "Minyak",
    // isFavourite: true,
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 7,
    images: [
      "assets/images/telur.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Telur Omega",
    priceIDR: 70000,
    description: "Deskripsi produk Nike Sport 20 - Man Pant",
    rating: 4.1,
    size: "Medium",
    stock: "20",
    category: "Telur",
    isPopular: false,
    isRecomended: true,
    isSpecial: false,
  ),
  Product(
    id: 8,
    images: [
      "assets/images/beras4.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Gula",
    priceIDR: 70000,
    description: "Deskripsi produk Gloves XC Omega - Polygon",
    rating: 4.1,
    size: "Medium",
    stock: "20",
    category: "Gula",
    // isFavourite: true,
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 9,
    images: [
      "assets/images/minyak.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Minyak Curah",
    priceIDR: 70000,
    description: "Deskripsi produk Logitech Head",
    rating: 4.1,
    size: "Medium",
    stock: "20",
    category: "Minyak",
    // isFavourite: true,
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 10,
    images: [
      "assets/images/minyak.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Bimoli",
    priceIDR: 70000,
    description: "Bimoli enak tauu",
    rating: 4.1,
    size: "Medium",
    stock: "20",
    category: "Minyak",
    // isFavourite: true,
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 11,
    images: [
      "assets/images/ps4_console_white_4.png",
      // "assets/images/ps4_console_20_2.png",
      // "assets/images/ps4_console_20_3.png",
      // "assets/images/ps4_console_20_4.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Susu Vanila",
    priceIDR: 70000,
    description: "Deskripsi produk Wireless Controller for PS4™",
    rating: 4.8,
    size: "Medium",
    stock: "20",
    category: "Susu",
    // isFavourite: true,
    isPopular: false,
    isRecomended: true,
    isSpecial: false,
  ),
  Product(
    id: 12,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Susu putih",
    priceIDR: 70000,
    description: "Deskripsi produk Wireless Controller for PS4™",
    rating: 4.8,
    size: "Medium",
    stock: "10",
    category: "Susu",
    // isFavourite: true,
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 13,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Susu Bendera",
    priceIDR: 70000,
    description: "Deskripsi produk Wireless Controller for PS4™",
    rating: 4.8,
    size: "Medium",
    stock: "20",
    category: "Susu",
    // isFavourite: true,
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 14,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Frisian Fleg",
    priceIDR: 70000,
    description: "Deskripsi produk Wireless Controller for PS4™",
    rating: 4.8,
    size: "Medium",
    stock: "20",
    category: "Susu",
    // isFavourite: true,
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 15,
    images: [
      "assets/images/ps4_console_white_2.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Susu Stroberi",
    priceIDR: 70000,
    description: "Deskripsi produk Nike Sport 20 - Man Pant",
    rating: 4.1,
    size: "Medium",
    stock: "20",
    category: "Susu",
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 16,
    images: [
      "assets/images/ps4_console_white_1.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Susu Cokelat",
    priceIDR: 70000,
    description: "Deskripsi produk Gloves XC Omega - Polygon",
    rating: 4.1,
    size: "Medium",
    stock: "20",
    category: "Susu",
    // isFavourite: true,
    isPopular: true,
    isRecomended: false,
    isSpecial: false,
  ),
  Product(
    id: 17,
    images: [
      "assets/images/glap.png",
    ],
    // stocks: [
    //   const stock(0xFFF6625E),
    //   const stock(0xFF836DB8),
    //   const stock(0xFFDECB9C),
    //   stocks.20,
    // ],
    title: "Susu Murni",
    priceIDR: 70000,
    description: "Deskripsi produk Logitech Head",
    rating: 4.1,
    size: "Medium",
    stock: "20",
    category: "Susu",
    // isFavourite: true,
    isPopular: false,
    isRecomended: true,
    isSpecial: false,
  ),
  Product(
    id: 18,
    images: [
      "assets/images/glap.png",
    ],
    title: "Dancow",
    priceIDR: 70000,
    description: "Deskripsi produk Logitech Head",
    rating: 4.1,
    size: "Medium",
    stock: "20",
    category: "Susu",
    // isFavourite: true,
    isPopular: false,
    isRecomended: true,
    isSpecial: false,
  ),
];

String formatPrice(double price) {
  final formatCurrency =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
  return formatCurrency.format(price);
}
