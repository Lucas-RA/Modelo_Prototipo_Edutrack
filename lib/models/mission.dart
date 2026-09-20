enum MissionStatus { done, pending }

class Mission {
  final String id;
  final String title;
  final String subtitle;
  final int xpReward;
  final MissionStatus status;
  final double progress;

  const Mission({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.xpReward,
    required this.status,
    this.progress = 1.0,
  });
}
