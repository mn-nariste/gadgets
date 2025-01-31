import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const CategoryTile({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(image, height: 50, width: 50),
      ),
    );
  }
}
