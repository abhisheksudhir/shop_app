import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold will expand or occupy in the whole device screen.
    // It will occupy the available space.
    // Scaffold will provide a framework to implement the basic material design layout of the application.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
        ),
      ),
      body: ProductsGrid(),
    );
  }
}


