import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'Lanche', 'image': 'assets/images/lanche/xtudo2.png'},
    {'name': 'Bebidas', 'image': 'assets/images/bebidas/pureza.png'},
    {'name': 'Combos', 'image': 'assets/images/combos/combomaster.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: categories.map((category) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/items',
                    arguments: category['name']);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Tooltip(
                  message: category['name']!,
                  child: ClipOval(
                    child: Image.asset(
                      category['image']!,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
