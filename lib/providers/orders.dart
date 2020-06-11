import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

//mix in are added using with keyword.You merge some properties into you existing class
//you don't return your class into an instance of inherited class
class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(
    List<CartItem> cartProducts,
    double total,
  ) async {
    const url = 'https://flutter---shopapp-6a814.firebaseio.com/orders.json';
    // to avoid difference in timestamp of http request and _orders list
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cartProduct) => {
                    'id': cartProduct.id,
                    'title': cartProduct.title,
                    'quantity': cartProduct.quantity,
                    'price': cartProduct.price,
                  })
              .toList(),
        }),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timeStamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
