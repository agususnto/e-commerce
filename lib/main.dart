import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ecommerce/cart/cart.dart';
import 'package:ecommerce/discovery/discovery.dart';
import 'package:ecommerce/home/home.dart';
import 'package:ecommerce/order/order.dart';
import 'package:ecommerce/profile/profile.dart';
import 'package:ecommerce/utils/theme_provider.dart';
import 'package:flutter/material.dart';

List<Widget> pages = const [
  Cart(),
  Discovery(),
  Home(),
  Order(),
  Profile(),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Chandra',
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      debugShowCheckedModeBanner: true,
      home: const MyHomePage(title: 'My Chandra'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentPage = 2;
  late PageController pageController;
  late TabStyle _tabStyle;

  @override
  void initState() {
    super.initState();
    _tabStyle = TabStyle.titled;
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
          color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.purple.shade200,
          style: _tabStyle,
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
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
