import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'wishlist.dart';

import 'cart.dart';

const String _baseURL = 'csci410mj.000webhostapp.com';
class WomenProduct {
  String _name;
  int _quantity;
  double _price;
  String _image;

  WomenProduct(this._name, this._quantity, this._price, this._image);
}
List<WomenProduct> _products = [];
void updateWomenProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'womenProducts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 60));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        WomenProduct p = WomenProduct(
            row['name'],
            int.parse(row['quantity']),
            double.parse(row['price']),
            row['image']
        );
        _products.add(p);
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}
class ShowWomenProducts extends StatelessWidget {
  const ShowWomenProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.yellow),
              padding: const EdgeInsets.all(5),
              width: width * 0.9,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset(_products[index]._image, height: 100,))
                    ]),
                    Column(children: [
                      Text(_products[index]._name, style: const TextStyle(fontSize: 15, color: Colors.white)),
                      const SizedBox(height: 15,),
                      Text('\$${_products[index]._price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 15, color: Colors.white)),
                    ]),
                    Column(
                      children: [
                        ElevatedButton(onPressed: (){
                          WishlistProduct wlp = WishlistProduct(_products[index]._name, _products[index]._quantity, _products[index]._price, _products[index]._image);
                          wlProducts.add(wlp);
                        }, child: const Icon(Icons.star)),
                        const SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          Cart c = Cart(_products[index]._name, _products[index]._price, _products[index]._image);
                          myCart.add(c);
                          totalPrice += _products[index]._price;
                        }, child: const Icon(Icons.add))
                      ],
                    ),
                  ])
          )
        ])
    );
  }
}
