class ClassificationResult {
  final double score;
  final String name;
  final String description;
  final String prevention;

  ClassificationResult.empty()
      : score = 0,
        name = '',
        description = '',
        prevention = '';

  ClassificationResult({
    required this.score,
    required this.name,
    required this.description,
    required this.prevention,
  });

  factory ClassificationResult.fromJson(Map<String, dynamic> json) {
    return ClassificationResult(
      score: json['score'],
      name: json['name'],
      description: json['description'],
      prevention: json['prevention'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'name': name,
      'description': description,
      'prevention': prevention,
    };
  }
}
