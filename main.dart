import 'package:flutter/material.dart';

import 'package:travel_inspiration/form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Travel Inspiration',
      themeMode: ThemeMode.system,
      home: MyForm(),
    );
  }
}
