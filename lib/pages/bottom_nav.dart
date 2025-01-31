import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/favorite.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late Home home;
  late FavoriteScreen favorite;
  late ProfileScreen profile;
  final List<Map<String, dynamic>> _favoriteItems = [];
  int currentTabIndex = 0;

  void toggleFavorite(Map<String, dynamic> item) {
    setState(() {
      if (_favoriteItems.any((favItem) => favItem['title'] == item['title'])) {
        _favoriteItems
            .removeWhere((favItem) => favItem['title'] == item['title']);
      } else {
        _favoriteItems.add(item);
      }
    });
  }

  bool isItemFavorite(Map<String, dynamic> item) {
    return _favoriteItems.any((favItem) => favItem['title'] == item['title']);
  }

  @override
  void initState() {
    super.initState();
    home = Home(
        toggleFavorite: toggleFavorite,
        favoriteItems: _favoriteItems,
        isItemFavorite: isItemFavorite);
    favorite = FavoriteScreen(favoriteItems: _favoriteItems);
    profile = const ProfileScreen();
    pages = [home, favorite, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: const Color(0xfff2f2f2),
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home_max_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          )
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
