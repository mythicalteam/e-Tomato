import 'dart:convert';
import 'dart:io';

import 'package:etomato/models/settings.dart';
import 'package:path_provider/path_provider.dart';

class SettingsService {
  Future<void> save(Settings settings) async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/etomato-settings.json');
    await file.writeAsString(jsonEncode(settings.toJson()));
  }

  Future<Settings> get() async {
    await Future.delayed(const Duration(seconds: 2));

    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/etomato-settings.json');
    final contents = await file.readAsString();

    return Settings.fromJson(jsonDecode(contents));
  }
}
