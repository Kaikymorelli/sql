import 'package:flutter/material.dart';
import 'principal.dart';

void main () {
  runApp(const MyApp ());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      // remove the debug bunner
      debugShowCheckedModeBanner: false,
      title:  "APLICAÇAO COM SQLITE",

      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
     home: const Principal ());
  }
}
