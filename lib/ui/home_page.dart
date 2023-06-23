import 'dart:io';
import 'package:agenda_produtos/helpers/product_helper.dart';
import 'package:agenda_produtos/ui/product_page.dart';
import 'package:flutter/material.dart';

enum OrderOptions { orderaz, orderza }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductHelper helper = ProductHelper();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de A-Z"),
                value: OrderOptions.orderaz,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de Z-A"),
                value: OrderOptions.orderza,
              ),
            ],
            onSelected: _orderList,
          )
        ],
      ),
      backgroundColor: Colors.green,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Product product = Product();
          _showProductPage(product: product);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _productCard(context, index);
        },
      ),
    );
  }

  Widget _productCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: products[index].img != null &&
                              products[index].img.isNotEmpty
                          ? Image.file(File(products[index].img)).image
                          : AssetImage("images/person.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      products[index].name ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      products[index].category ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      products[index].preco ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            builder: (context) {
              return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          child: Text(
                            "Editar",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _showProductPage(product: products[index]);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                          onPressed: () {
                            var deleteProduct = helper.deleteProduct(
                              products.length,
                            );
                            setState(() {
                              products.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ],
                  ));
            },
            onClosing: () {},
          );
        });
  }

  void _showProductPage({required Product product}) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductPage(product: product)),
    );

    if (updatedProduct != null) {
      if (product.id != null) {
        await helper.updateProduct(updatedProduct);
      } else {
        await helper.saveProduct(updatedProduct);
      }
      _getAllProducts();
    }
  }

  void _getAllProducts() {
    helper.getAllProducts().then((list) {
      setState(() {
        products = List<Product>.from(list);
      });
    });
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        products.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        products.sort((a, b) {
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }

    setState(() {});
  }
}
