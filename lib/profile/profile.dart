import 'package:flutter/material.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';
import 'page_profile/account.dart';
import 'package:ecommerce/products/products_screen.dart';
import '../utils/wishlist_local_storage.dart';
import '../models/Product.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            true, // Menampilkan ikon back secara otomatis
        title: const Text('Profile',
            style: TextStyle(color: Colors.white)), // Warna teks putih
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            const IconThemeData(color: Colors.white), // Warna ikon back putih
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/account.svg",
              press: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyAccountPage(),
                  ),
                ),
              },
            ),
            ProfileMenu(
              text: "Wishlist",
              icon: "assets/icons/Heart Icon.svg",
              press: () async {
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
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/help-center.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/logout.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
