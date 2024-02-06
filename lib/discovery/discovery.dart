import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class Discovery extends StatelessWidget {
  const Discovery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextView(text: 'Discovery'),
      ),
      body: Container(),
    );
  }
}