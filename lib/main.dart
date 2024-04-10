import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'view/LoginPage.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login e Cadastro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class GlobalData {
  static List<ShoppingList> shoppingLists = [];
}

class ShoppingList {
  late String name;
  List<ShoppingListItem> items;

  ShoppingList({required this.name, required this.items});
}

class ShoppingListItem {
  late String name;
  late String quantity;
  bool bought;

  ShoppingListItem({required this.name, required this.quantity, this.bought = false});
}
