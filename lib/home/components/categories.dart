import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Categories extends StatelessWidget {
  final Function(String) onCategoryTap;
  final Function() onMoreTap;

  const Categories(
      {Key? key, required this.onCategoryTap, required this.onMoreTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/milk.svg", "text": "Susu"},
      {"icon": "assets/icons/olive-oil.svg", "text": "Minyak"},
      {"icon": "assets/icons/apple.svg", "text": "Buah-buahan"},
      {"icon": "assets/icons/chocolate.svg", "text": "Cokelat"},
      {"icon": "assets/icons/drink.svg", "text": "Minuman"},
      {"icon": "assets/icons/rice.svg", "text": "Beras"},
      {"icon": "assets/icons/olive-oil.svg", "text": "Minyak"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];

    List<Map<String, dynamic>> firstRow =
        categories.sublist(0, categories.length ~/ 2);
    List<Map<String, dynamic>> secondRow =
        categories.sublist(categories.length ~/ 2);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              firstRow.length,
              (index) => Expanded(
                child: CategoryCard(
                  icon: firstRow[index]["icon"],
                  text: firstRow[index]["text"],
                  press: () {
                    if (firstRow[index]["text"] == "More") {
                      onMoreTap(); // Panggil fungsi onMoreTap jika kategori "More" diklik
                    } else {
                      onCategoryTap(firstRow[index]["text"]);
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20), // Spacer between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              secondRow.length,
              (index) => Expanded(
                child: CategoryCard(
                  icon: secondRow[index]["icon"],
                  text: secondRow[index]["text"],
                  press: () {
                    if (secondRow[index]["text"] == "More") {
                      onMoreTap(); // Panggil fungsi onMoreTap jika kategori "More" diklik
                    } else {
                      onCategoryTap(secondRow[index]["text"]);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
