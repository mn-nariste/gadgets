import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widget/product_card.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final List<Product> products;

  const CategoryScreen(
      {super.key, required this.categoryName, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: products.isEmpty
          ? const Center(child: Text('Нет товаров в этой категории'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              }),
    );
  }
}
