import 'package:flutter/material.dart';

class RecommendedWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  RecommendedWidget({required this.items}); // Defina os itens como parâmetro

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0), // Espaço entre os cards
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/item_detail',
                  arguments: items[index],
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Borda arredondada
                  side: BorderSide(
                      color: Colors.grey.shade300, width: 1), // Borda
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Espaço dentro do card
                  child: Column(
                    children: [
                      Image.asset(
                        items[index]['image']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8), // Espaço entre a imagem e o texto
                      Text(items[index]['name']!),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
