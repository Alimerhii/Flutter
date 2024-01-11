import 'package:flutter/material.dart';
import 'cart.dart';
import 'menProducts.dart';
class Men extends StatefulWidget {
  const Men({super.key});
  @override
  State<Men> createState() => _MenState();
}
class _MenState extends State<Men> {
  bool _load = false;
  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }
  @override
  void initState() {
    updateMenProducts(update);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(onPressed: !_load ? null : () {
            setState(() {
              _load = false;
              updateMenProducts(update);
            });
          }, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {
            setState(() {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartList())
              );
            });
          }, icon: const Icon(Icons.shopping_cart), color: Colors.black,)
        ],
        title: const Text('MEN', style: TextStyle(fontSize: 30,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body:  _load ? const ShowMenProducts() : const Center(
          child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
      ),
      backgroundColor: Colors.amber,
    );
  }
}
