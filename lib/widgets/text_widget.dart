import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  final String text;
  final Color? colors;
  const TextView({
    super.key,
    required this.text,
    this.colors,
  });

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return Text(
        widget.text,
        style: TextStyle(fontFamily: 'squad', color: widget.colors ?? Colors.black),
      );
  }
}
