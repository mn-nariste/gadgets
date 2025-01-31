import 'package:flutter/material.dart';
import '../models/product.dart';

class Product1 extends StatelessWidget {
  final Product product;

  const Product1({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(205, 17, 59, 164),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    child: SizedBox(
                      width: 343.0,
                      height: 300.0,
                      child: Image.network(
                          product.imageUrl ??
                              'https://i.ibb.co/4dr0v9x/no-image.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error)),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(205, 17, 59, 164),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                              fontSize: 21.0,
                              color: Colors.white,
                              fontFamily: 'Poppins Bold'),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          product.productDescription,
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontFamily: 'Poppins Regular'),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          '${product.price} руб.',
                          style: const TextStyle(
                              fontSize: 21.0,
                              color: Colors.white,
                              fontFamily: 'Poppins Medium'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
