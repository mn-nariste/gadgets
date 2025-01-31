import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/product.dart';
import '../widget/support_widget.dart';
import '../widget/bestseller.dart';
import 'all_products_screen.dart';
import 'search_results_screen.dart';
import '../widget/category_tile.dart';
import 'category_products_screen.dart';
import '../pages/product_continus.dart';

class Home extends StatefulWidget {
  final Function(Map<String, dynamic> item) toggleFavorite;
  final List<Map<String, dynamic>> favoriteItems;
  final bool Function(Map<String, dynamic> item) isItemFavorite;

  const Home(
      {super.key,
      required this.toggleFavorite,
      required this.favoriteItems,
      required this.isItemFavorite});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Product>> _productsFuture;
  List<Map<String, dynamic>> categories = [
    {'image': 'images/phone_icon.jpg', 'type': 'Смартфон'},
    {'image': 'images/laptop_icon.jpg', 'type': 'Ноутбук'},
    {'image': 'images/tv_icon.png', 'type': 'Телевизор'},
  ];
  final TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService().fetchProductDetails();
  }

  void _performSearch(List<Product> allProducts) {
    final searchTerm = _searchController.text;
    if (searchTerm.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(
              searchTerm: searchTerm, allProducts: allProducts),
        ),
      );
    }
  }

  void _openCategory(String categoryType, List<Product> allProducts) {
    final filteredProducts = allProducts
        .where((product) =>
            product.title.toLowerCase().contains(categoryType.toLowerCase()))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryName: categoryType,
          products: filteredProducts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Хей, Наристе",
                      style: AppWidget.boldTextFeildStyle(),
                    ),
                    Text(
                      "Удачной покупки!",
                      style: AppWidget.lightTextFeildStyle(),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "images/me.jpg",
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Поиск товаров",
                  hintStyle: AppWidget.lightTextFeildStyle(),
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      final products = await _productsFuture;
                      _performSearch(products);
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Категории", style: AppWidget.semiBoldTextFeildStyle()),
              ],
            ),
            const SizedBox(height: 10.0),
            FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No products found"));
                } else {
                  _allProducts = snapshot.data!;
                  return Row(
                    children: [
                      Container(
                        height: 120,
                        width: 90,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(right: 20.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(205, 17, 59, 164),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Все",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 125,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                key: UniqueKey(),
                                image: categories[index]['image'],
                                onTap: () => _openCategory(
                                  categories[index]['type'],
                                  _allProducts,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Все продукты", style: AppWidget.semiBoldTextFeildStyle()),
                GestureDetector(
                  onTap: () async {
                    final products = await _productsFuture;
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AllProductsScreen(products: products),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "посмотреть все",
                    style: TextStyle(
                      color: Color.fromARGB(205, 17, 59, 164),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 250,
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No products found"));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Product1(product: product),
                              ),
                            );
                          },
                          child: Container(
                            width: 182,
                            height: 230,
                            margin: const EdgeInsets.only(right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8.0),
                                    ),
                                    child: Image.network(
                                      snapshot.data![index].imageUrl ?? '',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].title,
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
                                        '${snapshot.data![index].price} руб.',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color:
                                              Color.fromARGB(205, 17, 59, 164),
                                          fontFamily: 'Poppins Medium',
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                "Популярное",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Bestseller(
                toggleFavorite: widget.toggleFavorite,
                favoriteItems: widget.favoriteItems,
                isItemFavorite: widget.isItemFavorite),
          ],
        ),
      ),
    );
  }
}
