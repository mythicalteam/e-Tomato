import 'package:etomato/classifying.dart';
import 'package:etomato/failed.dart';
import 'package:etomato/models/classification_result.dart';
import 'package:etomato/result.dart';
import 'package:etomato/services/classifying_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassifyPage extends StatefulWidget {
  const ClassifyPage({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<ClassifyPage> createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage> {
  var _result = ClassificationResult.empty();

  final client = http.Client();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _analyze(client),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_result.score == 0) {
            return Failed(
              message: "Unable to classify image.",
              onRetry: () => setState(() {}),
            );
          }
          return Result(
            imagePath: widget.imagePath,
            classification: _result,
          );
        } else {
          return PopScope(
            child: Classifying(
              imagePath: widget.imagePath,
              client: client,
            ),
          );
        }
      },
    );
  }

  Future<void> _analyze(http.Client client) async {
    _result = await ClassifyingService().process(widget.imagePath, client);
  }
}
