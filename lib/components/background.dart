import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String topImage;
  final String bottomImage;
  final Color color; // Mengubah tipe color menjadi Color
  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
    required this.color, // Menggunakan tipe Color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(bottomImage, width: 120),
            ),
            Container(
              // Tambahkan kontainer untuk latar belakang berwarna merah
              color: color, // Gunakan properti color untuk menetapkan warna
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
