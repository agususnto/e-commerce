import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color.fromARGB(255, 245, 6, 6);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

String formatPrice(double price) {
  String priceString =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(price);

  if (priceString.endsWith(',00')) {
    // Hapus ",00" jika harga merupakan bilangan bulat
    priceString = priceString.substring(0, priceString.length - 3);
  }

  return priceString;
}

const defaultDuration = Duration(milliseconds: 250);

const double defaultPadding = 16.0;
