import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widget/support_widget.dart';

class SearchResultsScreen extends StatelessWidget {
  final String searchTerm;
  final List<Product> allProducts;

  const SearchResultsScreen(
      {super.key, required this.searchTerm, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = allProducts
        .where((product) =>
            product.title.toLowerCase().contains(searchTerm.toLowerCase()) ||
            product.productDescription
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты поиска для "$searchTerm"'),
        backgroundColor: const Color(0xfff2f2f2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: filteredProducts.isEmpty
            ? Center(
                child: Text("Ничего не найдено",
                    style: AppWidget.semiBoldTextFeildStyle()))
            : ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                      key: UniqueKey(), product: filteredProducts[index]);
                }),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(8.0)),
            child: Image.network(
              product.imageUrl ?? '',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      fontFamily: 'Poppins Regular',
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${product.price} руб.',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(205, 17, 59, 164),
                      fontFamily: 'Poppins Medium',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
