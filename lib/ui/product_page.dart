import 'dart:io';
import 'dart:async';
import 'package:agenda_produtos/helpers/product_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  ProductPage({required this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ImagePicker _imagePicker = ImagePicker();

  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _precoController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;

  late Product _editedProduct;

  @override
  void initState() {
    super.initState();

    if (widget.product == null) {
      _editedProduct = Product();
    } else {
      _editedProduct = Product.fromMap(widget.product.toMap());

      _nameController.text = _editedProduct.name;
      _categoryController.text = _editedProduct.category;
      _precoController.text = _editedProduct.preco;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 136, 0),
          title: Text(_editedProduct.name.isNotEmpty
              ? _editedProduct.name
              : "Novo Produto"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editedProduct.name != null && _editedProduct.name.isNotEmpty) {
              Navigator.pop(context, _editedProduct);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Color.fromARGB(255, 11, 136, 0),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editedProduct.img != null &&
                                _editedProduct.img.isNotEmpty
                            ? Image.file(File(_editedProduct.img)).image
                            : const AssetImage("images/person.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                onTap: () {
                  _imagePicker
                      .pickImage(source: ImageSource.camera)
                      .then((file) {
                    if (file == null) return;

                    setState(() {
                      _editedProduct.img = file.path;
                    });
                  });
                },
              ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text) {
                  _userEdited = true;

                  setState(() {
                    _editedProduct.name = text;
                  });
                },
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: "Categoria"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedProduct.category = text;
                },
              ),
              TextField(
                controller: _precoController,
                decoration: InputDecoration(labelText: "Preço"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedProduct.preco = text;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações "),
              content: Text("Se sair as alterações serão perdidas"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
