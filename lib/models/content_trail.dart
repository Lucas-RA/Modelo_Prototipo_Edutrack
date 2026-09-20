class ContentTrail {
  final String id;
  final String category;
  final String title;
  final String moduleInfo;
  final double progress;
  final int remainingLessons;
  final String description;

  const ContentTrail({
    required this.id,
    required this.category,
    required this.title,
    required this.moduleInfo,
    required this.progress,
    required this.remainingLessons,
    required this.description,
  });
}
