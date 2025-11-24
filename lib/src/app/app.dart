import 'package:app/src/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pedometer App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
