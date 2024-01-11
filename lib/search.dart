import 'package:flutter/material.dart';
import 'product.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final TextEditingController _controllerName = TextEditingController();
  String _text = '';

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  void update(String text) {
    setState(() {
      _text = text;
    });
  }
  void getProduct() {
    try {
      String name = _controllerName.text;
      searchProduct(update, name);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('wrong arguments')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search for watches'),
          centerTitle: true,
          backgroundColor: Colors.yellow,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextField(
                      controller: _controllerName,
                      decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter watch name')
                  )
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: getProduct,
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
                child: const Text('Search', style: TextStyle(fontSize: 18,color: Colors.white)),
              ),
              const SizedBox(height: 10),
              Center(
                  child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.yellow),
                      padding: const EdgeInsets.all(5),
                      width: width * 0.9,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 15,),
                            Column(
                              children: [
                                Text(_text, style: const TextStyle(color: Colors.white, fontSize: 25),),
                              ],
                            ),
                          ])
                      )
              )
            ],
          ),
        ),
      backgroundColor: Colors.amber,
    );
  }
}
