// @dart=2.9

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:agenda_produtos/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'helpers/product_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;

  ProductHelper helper = ProductHelper();
  await helper.initDb();

  runApp(MaterialApp(
    home: HomePage(

    ),
    debugShowCheckedModeBanner: false,
  ));
}