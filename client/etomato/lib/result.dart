import 'dart:io';

import 'package:etomato/base.dart';
import 'package:etomato/models/classification_result.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result(
      {super.key, required this.imagePath, required this.classification});

  final ClassificationResult classification;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Base(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.chevron_left, color: Colors.white),
        ),
        title: const Text("Result"),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.file(File(imagePath), fit: BoxFit.cover),
                  ),
                ),
              ),
              _buildDiagnosisItems(classification, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiagnosisItems(ClassificationResult result, ThemeData theme) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '${(result.score * 100).toStringAsFixed(2)}%',
                          style: theme.textTheme.displaySmall,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            result.name,
                            style: theme.textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    result.description,
                    style: theme.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Prevention",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    result.prevention,
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
