import 'package:flutter/material.dart';

class Base extends StatelessWidget {
  const Base({super.key, this.appBar, required this.child});

  final Widget? appBar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final header = appBar ?? const SizedBox();
    return DefaultTextStyle(
      style: const TextStyle(
        decoration: TextDecoration.none,
        fontSize: 16,
        color: Colors.black,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.40],
            colors: [Colors.red, Colors.red.shade100],
          ),
        ),
        child: Column(
          children: [header, Expanded(child: child)],
        ),
      ),
    );
  }
}
