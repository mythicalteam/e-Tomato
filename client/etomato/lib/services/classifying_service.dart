import 'dart:convert';

import 'package:etomato/models/classification_result.dart';
import 'package:etomato/services/settings_service.dart';
import 'package:http/http.dart' as http;

class ClassifyingService {
  final _settingsService = SettingsService();

  Future<ClassificationResult> process(
      String imagePath, http.Client client) async {
    final url = await _settingsService.get();

    final header = {
      'accept': 'application/json',
      'content-type': 'multipart/form-data',
    };

    final uri = Uri.parse('${url.server}/api/classify');
    final request = http.MultipartRequest("POST", uri);
    request.headers.addAll(header);

    final image = await http.MultipartFile.fromPath('image', imagePath);
    request.files.add(image);

    final streamResponse = await client.send(request);

    if (streamResponse.statusCode == 200) {
      final response = await http.Response.fromStream(streamResponse);

      final json = jsonDecode(response.body);

      return ClassificationResult.fromJson(json);
    } else {
      return ClassificationResult.empty();
    }
  }
}
