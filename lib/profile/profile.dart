import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextView(text: 'Profile'),
      ),
      body: Container(),
    );
  }
}