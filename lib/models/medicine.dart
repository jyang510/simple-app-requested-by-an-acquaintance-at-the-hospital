class Medicine {
  final String name;
  final List<int> price;
  final String imagePath;
  final List<String> type;
  final List<String> explanation;

  Medicine({
    required this.name,
    required this.type,
    required this.price,
    required this.imagePath,
    this.explanation = const [],
  });
}
