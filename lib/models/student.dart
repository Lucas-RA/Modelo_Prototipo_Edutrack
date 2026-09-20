class Student {
  final String name;
  final String firstName;
  final String partner;
  final int level;
  final String levelTitle;
  final int currentXp;
  final int nextLevelXp;

  const Student({
    required this.name,
    required this.firstName,
    required this.partner,
    required this.level,
    required this.levelTitle,
    required this.currentXp,
    required this.nextLevelXp,
  });

  double get progress => currentXp / nextLevelXp;
  int get xpToNextLevel => nextLevelXp - currentXp;
}
