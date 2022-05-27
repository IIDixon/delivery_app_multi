import 'package:delivery_app_multi/pages/profile_page.dart';
import 'package:delivery_app_multi/pages/root_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery App',
      home: RootPage(),
    );
  }
}
