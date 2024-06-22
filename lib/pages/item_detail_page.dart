import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quero_comer/providers/cart_provider.dart';
import 'package:quero_comer/providers/favorites_provider.dart';

class ItemDetailPage extends StatefulWidget {
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  bool _isFavorite = false;
  bool _isInCart = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> item =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Verifica se o item está na lista de favoritos
    _isFavorite = Provider.of<FavoritesProvider>(context)
        .favoriteItems
        .any((element) => element['name'] == item['name']);

    // Verifica se o item está no carrinho
    _isInCart = Provider.of<CartProvider>(context)
        .cartItems
        .any((element) => element['name'] == item['name']);

    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  item['image'],
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                item['name'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'R\$ ${item['price'].toStringAsFixed(2).replaceAll('.', ',')}',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Breve descrição do item...',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                      if (_isFavorite) {
                        Provider.of<FavoritesProvider>(context, listen: false)
                            .addFavorite(item);
                      } else {
                        Provider.of<FavoritesProvider>(context, listen: false)
                            .removeFavorite(item);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: _isInCart ? Colors.green : null,
                    ),
                    onPressed: () {
                      setState(() {
                        _isInCart = !_isInCart;
                      });
                      if (_isInCart) {
                        Provider.of<CartProvider>(context, listen: false)
                            .addItemToCart(item);
                      } else {
                        Provider.of<CartProvider>(context, listen: false)
                            .removeItemFromCart(item);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
