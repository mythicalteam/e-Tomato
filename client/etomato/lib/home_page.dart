import 'package:etomato/custom_icons.dart';
import 'package:etomato/tomato_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:etomato/manage_page.dart';
import 'package:etomato/info_page.dart';
import 'package:etomato/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Add box decoration
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            Text(widget.title,
                style: const TextStyle(fontFamily: 'Mont Royal', fontSize: 40)),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: FAProgressBar(
                currentValue: 30,
                displayText: '%',
                borderRadius: BorderRadius.circular(15),
                progressColor: const Color(0xFFF65E5D),
                backgroundColor: const Color(0xFFFCC9C9),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
              // This Row widget is here to align the two icons
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  tooltip: 'App info',
                  icon: const Icon(Icons.info),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const InfoPage(title: 'App Info')))
                  },
                ),
                IconButton(
                  tooltip: 'Manage Tomatoes',
                  icon: const Icon(CustomIcons.tomato),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ManagePage(title: 'Manage Tomatoes')))
                  },
                ),
                const SizedBox(width: 48),
                IconButton(
                  tooltip: 'New Tomato',
                  icon: const Icon(CustomIcons.tomato_add),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TomatoPage(title: 'Add New Tomato')))
                  },
                ),
                IconButton(
                  tooltip: 'Settings',
                  icon: const Icon(Icons.settings),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SettingsPage(title: 'Settings')))
                  },
                ),
              ])),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => setState(() {}),
        tooltip: 'Check Heath',
        backgroundColor: const Color(0xffF65E5D),
        foregroundColor: Colors.white,
        child: const Icon(CustomIcons.scan, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
