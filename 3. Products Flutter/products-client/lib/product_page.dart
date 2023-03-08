import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';
import 'strings.dart' as strings;

class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(product.name)
    ),
    body: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: <Widget> [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.id,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                )
              ),
              Text(
                product.price + strings.currencySymbol,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade800
                )
              )
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              product.brand,
              style: TextStyle(
                fontSize: 16,
              )
            )
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              product.description,
              style: TextStyle(
                fontSize: 18,
              )
            )
          )
        ]
      )
    )
  );
}