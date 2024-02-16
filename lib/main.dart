import 'package:flutter/material.dart';
import 'package:ecommerce/welcome/welcome_page.dart';
import 'package:ecommerce/constants.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ecommerce/cart/cart.dart';
import 'package:ecommerce/discovery/discovery.dart';
import 'package:ecommerce/home/home.dart';
import 'package:ecommerce/order/order.dart';
import 'package:ecommerce/profile/profile.dart';
import 'package:ecommerce/utils/theme_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: MyTheme.lightTheme.copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 2;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,

        items: const [
          TabItem(icon: Icons.shopping_cart_checkout, title: 'Cart'),
          TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.shopping_basket_outlined, title: 'Order'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: currentPage, //optional, default as 0
        onTap: (int i) {
          setState(() {
            currentPage = i;
          });
          pageController.jumpToPage(i);
        },
      ),
    );
  }
}

List<Widget> pages = const [
  Cart(),
  Discovery(),
  Home(),
  Order(),
  Profile(),
];
