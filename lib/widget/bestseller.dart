import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Bestseller extends StatefulWidget {
  final Function(Map<String, dynamic> item) toggleFavorite;
  final List<Map<String, dynamic>> favoriteItems;
  final bool Function(Map<String, dynamic> item) isItemFavorite;

  const Bestseller(
      {super.key,
        required this.toggleFavorite,
        required this.favoriteItems,
        required this.isItemFavorite});

  @override
  State<Bestseller> createState() => _BestsellerState();
}

class _BestsellerState extends State<Bestseller> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            _buildBestsellerItem(
              index: 0,
              imagePath: "images/best_1.jpg",
              title: "Apple Iphone 15 Plus \n128 ГБ зеленый",
              price: "₽99899",
            ),
            _buildBestsellerItem(
              index: 1,
              imagePath: "images/best_2.jpg",
              title: "Tecno Spark 20 \n256 ГБ белый",
              price: "₽13499",
            ),
            _buildBestsellerItem(
              index: 2,
              imagePath: "images/best_3.jpg",
              title: "Apple iPhone 14 \n128 ГБ голубой",
              price: "₽73799",
            ),
            _buildBestsellerItem(
              index: 3,
              imagePath: "images/best_4.jpg",
              title: "Смартфон HUAWEI P60 Pro \n256 ГБ черный",
              price: "₽59999",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestsellerItem({
    required int index,
    required String imagePath,
    required String title,
    required String price,
  }) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
    width: 380,
    height: 110,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
    BoxShadow(
    color: Colors.grey,
    spreadRadius: 3,
    blurRadius: 10,
    offset: Offset(0, 3),
    )
    ],
    ),
    child: Row(
    children: [
    InkWell(
    onTap: () {},
    child: Container(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    ),
    ),
      const SizedBox(
        width: 30,
      ),
      Expanded(
        // Wrap the text column with Expanded
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded( // Wrap the Column with Expanded
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(205, 17, 59, 164),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 18,
                      itemPadding:
                      const EdgeInsets.symmetric(horizontal: 1),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color.fromARGB(205, 17, 59, 164),
                      ),
                      onRatingUpdate: (index) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                widget.toggleFavorite({
                  'imagePath': imagePath,
                  'title': title,
                  'price': price
                });
                setState(() {});
              },
              child: Icon(
                widget.isItemFavorite({
                  'imagePath': imagePath,
                  'title': title,
                  'price': price
                })
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: const Color.fromARGB(205, 17, 59, 164),
                size: 26,
              ),
            ),
          ],
        ),
      )
    ],
    ),
    ),
    );
  }
}