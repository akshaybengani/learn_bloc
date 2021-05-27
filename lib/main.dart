import 'package:flutter/material.dart';
import 'package:learn_bloc/shopping_cart_screen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingCartScreen(),
    );
  }
}
