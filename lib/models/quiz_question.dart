class QuizOption {
  final String letter;
  final String text;

  const QuizOption({required this.letter, required this.text});
}

class QuizQuestion {
  final String trailTag;
  final int questionNumber;
  final int totalQuestions;
  final int xpReward;
  final String question;
  final List<QuizOption> options;
  final String correctLetter;

  const QuizQuestion({
    required this.trailTag,
    required this.questionNumber,
    required this.totalQuestions,
    required this.xpReward,
    required this.question,
    required this.options,
    required this.correctLetter,
  });
}
