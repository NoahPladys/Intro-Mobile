// Copyright (c) 2021 Razeware LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// Notwithstanding the foregoing, you may not use, copy, modify, merge,
// publish, distribute, sublicense, create a derivative work, and/or sell
// copies of the Software in any work that is designed, intended, or marketed
// for pedagogical or instructional purposes related to programming, coding,
// application development, or information technology.  Permission for such
// use, copying, modification, merger, publication, distribution, sublicensing,
// creation of derivative works, or sale is expressly withheld.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ghflutter/product_page.dart';
import 'package:http/http.dart' as http;
import 'product.dart';
import 'strings.dart' as strings;

class GHFlutter extends StatefulWidget {
  const GHFlutter({Key? key}) : super(key: key);

  @override
  _GHFlutterState createState() => _GHFlutterState();
}

class _GHFlutterState extends State<GHFlutter> {
  final _products = <Product>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    const dataUrl = 'http://localhost:3000/products';
    final response = await http.get(Uri.parse(dataUrl));
    setState(() {
      final dataList = json.decode(response.body) as List;
      for (final item in dataList) {
        final id = item['id'] as String? ?? '';
        final price = item['price'] as String? ?? '';
        final name = item['name'] as String? ?? '';
        final brand = item['brand'] as String? ?? '';
        final description = item['description'] as String? ?? '';
        final link = item['link'] as String? ?? '';
        final product = Product(id, price, name, brand, description, link);
        _products.add(product);
      }
    });
  }

  Widget _buildRow(int i) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          title: Text(
            '${_products[i].name} ',
            style: _biggerFont
            ),
          subtitle: Text(
            '${_products[i].id}',
            style: _biggerFont
          ),
          trailing: Text(
            '${_products[i].price}${strings.currencySymbol} ',
            style: _biggerFont
          ),
        ),
      ),
      onTap: () => {
        Navigator.of(context).push<MaterialPageRoute>(MaterialPageRoute(
          builder: (context) => ProductPage(product: _products[i])
        ))
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appTitle),
      ),
      body: ListView.separated(
          itemCount: _products.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRow(position);
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 1);
          }),
    );
  }
}
