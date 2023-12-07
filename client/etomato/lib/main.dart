import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-tomato',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF65E5D)),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'e-tomato'),
    );
  }
}
