import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextView(text: 'Order'),
      ),
      body: Container(),
    );
  }
}