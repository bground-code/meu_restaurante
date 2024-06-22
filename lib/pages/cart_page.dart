import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quero_comer/providers/cart_provider.dart';
import 'package:quero_comer/providers/favorites_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final initialTabIndex = args != null && args.containsKey('initialTabIndex')
        ? args['initialTabIndex']
        : 0;
    return DefaultTabController(
      length: 2,
      initialIndex: initialTabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carrinho de Compras'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Carrinho'),
              Tab(text: 'Favoritos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CartTab(),
            FavoritesTab(),
          ],
        ),
      ),
    );
  }
}

class CartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartProvider.cartItems.length,
            itemBuilder: (context, index) {
              final item = cartProvider.cartItems[index];
              final price = item['price'];
              return ListTile(
                leading: Image.asset(item['image']),
                title: Text(item['name']),
                subtitle: Text('R\$${price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    cartProvider.removeItemFromCart(item);
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Total: R\$${cartProvider.totalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return ListView.builder(
      itemCount: favoritesProvider.favoriteItems.length,
      itemBuilder: (context, index) {
        final item = favoritesProvider.favoriteItems[index];
        final price = item['price'];
        return ListTile(
          leading: Image.asset(item['image']),
          title: Text(item['name']),
          subtitle: Text('R\$${price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () {
              favoritesProvider.removeFavorite(item);
            },
          ),
        );
      },
    );
  }
}
