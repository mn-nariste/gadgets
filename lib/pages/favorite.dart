import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteItems;
  const FavoriteScreen({super.key, required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favoriteItems.isEmpty
          ? const Center(child: Text('Нет избранных товаров'))
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return ListTile(
                  leading: Image.asset(
                    item['imagePath'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['title']),
                  subtitle: Text(item['price']),
                );
              },
            ),
    );
  }
}
