import 'package:flutter/material.dart';
import 'dart:async';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  int _currentImageIndex = 0;
  final List<String> _imagePaths = [
    'assets/images/voucher.png',
    'assets/images/voucher2.png',
    'assets/images/retail.png',
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Stop the timer when the widget is disposed
    _timer.cancel();
  }

  void _nextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + _imagePaths.length) % _imagePaths.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              _previousImage();
            } else if (details.primaryVelocity! < 0) {
              _nextImage();
            }
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 6, 6).withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                  _imagePaths[_currentImageIndex],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    return _imagePaths.map((path) {
      int index = _imagePaths.indexOf(path);
      return Container(
        width: 8.0,
        height: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentImageIndex == index ? Colors.black : Colors.grey,
        ),
      );
    }).toList();
  }
}
