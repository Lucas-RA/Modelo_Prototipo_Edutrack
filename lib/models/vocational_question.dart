class VocationalOption {
  final String letter;
  final String text;
  final String profile;

  const VocationalOption({
    required this.letter,
    required this.text,
    required this.profile,
  });
}

class VocationalQuestion {
  final String eyebrow;
  final String question;
  final List<VocationalOption> options;

  const VocationalQuestion({
    required this.eyebrow,
    required this.question,
    required this.options,
  });
}
