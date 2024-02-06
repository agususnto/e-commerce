import 'package:flutter/material.dart';
import '../widgets/text_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          width: double.infinity,
          height: 42,
          child: Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 0),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: TextView(text: 'Search',colors: Colors.grey),
                )
              ],
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.qr_code_2_sharp)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark))
        ],
      ),
      body: Container(),
    );
  }
}
