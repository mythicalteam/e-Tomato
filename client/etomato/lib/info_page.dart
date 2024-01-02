import 'package:etomato/base.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Base(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.chevron_left, color: Colors.white),
        ),
        title: const Text("App info"),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('This is where the app info will go'),
          ],
        ),
      ),
    );
  }
}
