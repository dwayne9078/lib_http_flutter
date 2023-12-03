import 'package:flutter/material.dart';
import 'package:expo_http/views/views.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exposicion Libreria HTTP',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Exposicion Libreria HTTP'),
          ),
          body: const MainPage()),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}
