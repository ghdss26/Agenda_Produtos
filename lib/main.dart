import 'package:agenda_produtos/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'helpers/product_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ProductHelper helper = ProductHelper();
  await helper.initDb();

  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
