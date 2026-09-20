import 'quiz_question.dart';

class QuizSet {
  final String id;
  final String title;
  final String category;
  final List<QuizQuestion> questions;

  const QuizSet({
    required this.id,
    required this.title,
    required this.category,
    required this.questions,
  });
}
