import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(242, 242, 241, 1.00)),
          useMaterial3: true,
        ),
        home: const BottomNav());
  }
}
