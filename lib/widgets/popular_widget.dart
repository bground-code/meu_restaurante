import 'package:flutter/material.dart';

class PopularWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  PopularWidget({required this.items});

  @override
  Widget build(BuildContext context) {
    // Função para filtrar os itens que são combos
    List<Map<String, dynamic>> filteredCombos(
        List<Map<String, dynamic>> items) {
      return items.where((item) {
        // Verifica se o nome da categoria do item contém a palavra "combo"
        return item['name'].toString().toLowerCase().contains('combo');
      }).toList();
    }

    // Itens populares filtrados apenas para combos
    final List<Map<String, dynamic>> filteredComboItems = filteredCombos(items);

    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredComboItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/item_detail',
                    arguments: filteredComboItems[index],
                  );
                },
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        filteredComboItems[index]['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(filteredComboItems[index]['name']!),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
