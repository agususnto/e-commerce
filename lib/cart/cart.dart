import 'package:ecommerce/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextView(text: 'Cart'),
      ),
      body: Container(),
    );
  }
}