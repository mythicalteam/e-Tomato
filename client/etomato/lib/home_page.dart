import 'dart:ui';

import 'package:etomato/classify_page.dart';
import 'package:etomato/custom_icons.dart';
import 'package:etomato/manage_page.dart';
import 'package:etomato/settings_page.dart';
import 'package:etomato/toast.dart';
import 'package:etomato/user_page.dart';
import 'package:etomato/info_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                    ),
                    Text(
                      "e-tomato",
                      style: TextStyle(
                          fontFamily: 'Mont Royal',
                          fontSize: 40,
                          color: Colors.red.shade900),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              decoration: BoxDecoration(color: primary.withOpacity(0.5)),
              padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    tooltip: 'App info',
                    icon: Icon(Icons.info, color: Colors.red.shade50),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InfoPage()))
                    },
                  ),
                  IconButton(
                    tooltip: 'Manage Tomatoes',
                    icon: Icon(
                      CustomIcons.tomato,
                      size: 20,
                      color: Colors.red.shade50,
                    ),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ManagePage()))
                    },
                  ),
                  IconButton(
                    tooltip: 'Scan Tomato',
                    icon: const Icon(
                      CustomIcons.scan,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () => pickImage(ImageSource.camera),
                  ),
                  IconButton(
                    tooltip: 'User Info',
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.red.shade50,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserPage(),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Settings',
                    icon: Icon(
                      Icons.settings,
                      color: Colors.red.shade50,
                    ),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage()))
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> pickImage(ImageSource source) async {
    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS) {
      Toast.showError("Unsupported platform.", position: ToastPosition.center);
      return;
    }
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image == null) return;

    if (context.mounted) showClassifyPage(image.path);
  }

  void showClassifyPage(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClassifyPage(imagePath: imagePath),
      ),
    );
  }
}
