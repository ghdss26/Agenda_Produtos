import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String productTable = "productTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String categoryColumn = "categoryColumn";
final String precoColumn = "precoColumn";
final String imgColumn = "imgColumn";

class ProductHelper {
  static final ProductHelper _instance = ProductHelper.internal();

  factory ProductHelper() => _instance;

  ProductHelper.internal();

  Database? _db;

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();

    final path = join(databasesPath, "productsnew.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $productTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $categoryColumn TEXT, $precoColumn TEXT, $imgColumn TEXT)");
    });
  }

  Future<Product> saveProduct(Product product) async {
    Database? dbProduct = await db;
    product.id = await dbProduct!
        .insert(productTable, Map<String, dynamic>.from(product.toMap()));
    return product;
  }

  Future<Product?> getProduct(int id) async {
    Database? dbProduct = await db;
    List<Map> maps = await dbProduct!.query(productTable,
        columns: [idColumn, nameColumn, categoryColumn, precoColumn, imgColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Product.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteProduct(int id) async {
    Database? dbProduct = await db;
    return await dbProduct!
        .delete(productTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateProduct(Product product) async {
    Database? dbProduct = await db;
    return await dbProduct!.update(
        productTable, Map<String, dynamic>.from(product.toMap()),
        where: "$idColumn = ?", whereArgs: [product.id]);
  }

  Future<List> getAllProducts() async {
    Database? dbProduct = await db;

    List listMap = await dbProduct!.rawQuery("SELECT * FROM $productTable");
    List<Product> listProduct = List<Product>.empty(growable: true);

    for (Map m in listMap) {
      listProduct.add(Product.fromMap(m));
    }

    return listProduct;
  }

  Future<int> getNumber() async {
    Database? dbProduct = await db;
    int? count = Sqflite.firstIntValue(
        await dbProduct!.rawQuery("SELECT COUNT(*) FROM $productTable"));
    return count ?? 0;
  }

  Future close() async {
    Database? dbProduct = await db;
    dbProduct!.close();
  }

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }
}

class Product {
  int? id;
  late String name;
  late String category;
  late String preco;
  late String img;

  Product({this.name = '', this.category = '', this.preco = '', this.img = ''});

  Product.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    category = map[categoryColumn];
    preco = map[precoColumn];
    img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      categoryColumn: category,
      precoColumn: preco,
      imgColumn: img
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Product(id: $id, name: $name, category: $category, preco: $preco, img: $img)";
  }
}
