import 'package:flutter/material.dart';

// import '../widgets/text_widget.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            true, // Menampilkan ikon back secara otomatis
        title: const Text('Order',
            style: TextStyle(color: Colors.white)), // Warna teks putih
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            const IconThemeData(color: Colors.white), // Warna ikon back putih
      ),
      body: Container(),
    );
  }
}
