import 'package:flutter/material.dart';
import 'package:quero_comer/data.dart';

class ItemListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String category =
        ModalRoute.of(context)!.settings.arguments as String;

    // Lista de itens importada do data.dart
    final List<Map<String, dynamic>> itemss = items;

    // Função para filtrar os itens com base na categoria
    List<Map<String, dynamic>> filteredItems(String category) {
      return itemss.where((item) {
        // Se o nome da categoria do item contiver a categoria selecionada
        return item['image'].toString().contains(category.toLowerCase());
      }).toList();
    }

    // Itens filtrados com base na categoria
    final List<Map<String, dynamic>> filteredItemList =
        filteredItems(category.toLowerCase());

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        itemCount: filteredItemList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  filteredItemList[index]['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                filteredItemList[index]['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'R\$ ${filteredItemList[index]['price'].toStringAsFixed(2).replaceAll('.', ',')}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/item_detail',
                  arguments: filteredItemList[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
