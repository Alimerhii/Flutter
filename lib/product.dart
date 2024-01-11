import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'csci410mj.000webhostapp.com';

class Product {
  int _pid;
  String _name;
  int _quantity;
  double _price;
  String _image;
  String _category;

  Product(this._pid, this._name, this._quantity, this._price, this._image, this._category);

  @override
  String toString() {
    return 'Product{_name: $_name}';
  }
}
List<Product> _products = [];
void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 60));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Product p = Product(
            int.parse(row['pid']),
            row['name'],
            int.parse(row['quantity']),
            double.parse(row['price']),
            row['image'],
            row['category']);
        _products.add(p);
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}

void searchProduct(Function(String text) update, String name) async {
  try {
    final url = Uri.https(_baseURL, 'searchProduct.php', {'name':name});
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Product p = Product(
          int.parse(row['pid']),
          row['name'],
          int.parse(row['quantity']),
          double.parse(row['price']),
          row['image'],
          row['category']);
      _products.add(p);
      update(p.toString());
    }
  }
  catch(e) {
    update("can't load data");
  }
}

class ShowProducts extends StatelessWidget {
  const ShowProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Container(
              color: index % 2 == 0 ? Colors.amber: Colors.cyan,
              padding: const EdgeInsets.all(5),
              width: width * 0.9, child: Row(children: [
            SizedBox(width: width * 0.15),
            Flexible(child: Text(_products[index].toString(), style: TextStyle(fontSize: width * 0.045)))
          ]))
        ])
    );
  }
}
