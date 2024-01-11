import 'package:flutter/material.dart';
import 'cart.dart';

class WishlistProduct {
  String name;
  int quantity;
  double price;
  String image;

  WishlistProduct(this.name, this.quantity,this.price, this.image);
}

List<WishlistProduct> wlProducts = [];

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key} ): super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartList())
            );
          }, icon: const Icon(Icons.shopping_cart), color: Colors.black,)
        ],
        title: const Text('WISHLIST', style: TextStyle(fontSize: 30,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
          itemCount: wlProducts.length,
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
                        ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset(wlProducts[index].image, height: 100,))
                      ]),
                      Column(children: [
                        Text(wlProducts[index].name, style: const TextStyle(fontSize: 15, color: Colors.white)),
                        const SizedBox(height: 15,),
                        Text('\$${wlProducts[index].price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 15, color: Colors.white)),
                      ]),
                      Column(
                        children: [
                          ElevatedButton(onPressed: (){
                            Cart c = Cart(wlProducts[index].name, wlProducts[index].price, wlProducts[index].image);
                            myCart.add(c);
                            totalPrice += wlProducts[index].price;
                          }, child: const Icon(Icons.add))
                        ],
                      ),
                    ])
            )
          ])
      ),
      backgroundColor: Colors.amber,
    );
  }
}
