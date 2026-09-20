import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/content_trail.dart';
import '../../models/quiz_question.dart';
import '../../models/quiz_set.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/progress_bar_widget.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  String _filter = 'Todas';
  int _selectedOption = 0;
  int _quizSetIndex = 0;
  int _questionIndex = 0;
  bool _showCompletion = false;
  final Set<String> _completedSetIds = {};

  static const _filters = ['Todas', 'Qualidade', 'Carreira', 'Soft skills'];

  List<ContentTrail> get _filtered {
    if (_filter == 'Todas') return MockData.trails;
    return MockData.trails.where((t) => t.category == _filter).toList();
  }

  QuizSet get _currentSet => MockData.quizSets[_quizSetIndex];

  int? get _nextAvailableSetIndex {
    for (var i = 0; i < MockData.quizSets.length; i++) {
      if (!_completedSetIds.contains(MockData.quizSets[i].id)) return i;
    }
    return null;
  }

  void _confirmAnswer(QuizQuestion quiz) {
    final correct = quiz.options[_selectedOption].letter == quiz.correctLetter;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(correct
            ? 'Resposta correta! +${quiz.xpReward} XP'
            : 'Quase — a resposta certa é a ${quiz.correctLetter}.'),
      ),
    );
    final isLastQuestion = _questionIndex >= _currentSet.questions.length - 1;
    setState(() {
      if (isLastQuestion) {
        _completedSetIds.add(_currentSet.id);
        _showCompletion = true;
      } else {
        _questionIndex++;
      }
      _selectedOption = 0;
    });
  }

  void _startAnotherQuiz() {
    final next = _nextAvailableSetIndex;
    if (next == null) return;
    setState(() {
      _quizSetIndex = next;
      _questionIndex = 0;
      _selectedOption = 0;
      _showCompletion = false;
    });
  }

  void _restartAllQuizzes() {
    setState(() {
      _completedSetIds.clear();
      _quizSetIndex = 0;
      _questionIndex = 0;
      _selectedOption = 0;
      _showCompletion = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CONTEÚDO', style: AppTextStyles.mono()),
                Text('Hub de aprendizagem', style: AppTextStyles.display(size: 20, weight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final f = _filters[i];
                final active = f == _filter;
                return GestureDetector(
                  onTap: () => setState(() => _filter = f),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? AppColors.green800 : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: active ? AppColors.green800 : AppColors.line, width: 1.4),
                    ),
                    child: Text(f,
                        style: AppTextStyles.body(
                            size: 12.5, weight: FontWeight.w600, color: active ? Colors.white : AppColors.ink600)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ..._filtered.map((t) => Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: _TrailCard(trail: t),
              )),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: _showCompletion ? _buildCompletionCard() : _buildQuestionCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    final quiz = _currentSet.questions[_questionIndex];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.green900, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('QUIZ · ${_currentSet.title.toUpperCase()}', style: AppTextStyles.mono(color: const Color(0xFFBFE3CE))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.16), borderRadius: BorderRadius.circular(20)),
                child: Text('+${quiz.xpReward} XP',
                    style: AppTextStyles.body(size: 11, weight: FontWeight.w700, color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text('PERGUNTA ${quiz.questionNumber} DE ${quiz.totalQuestions} · ${quiz.trailTag.toUpperCase()}',
              style: AppTextStyles.mono(color: const Color(0xFFBFE3CE))),
          const SizedBox(height: 6),
          Text(quiz.question,
              style: AppTextStyles.display(size: 16, weight: FontWeight.w600, color: Colors.white)),
          const SizedBox(height: 12),
          ...quiz.options.map((o) {
            final i = quiz.options.indexOf(o);
            final selected = i == _selectedOption;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => setState(() => _selectedOption = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.lime.withOpacity(0.22) : Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: selected ? AppColors.lime : Colors.white.withOpacity(0.18)),
                  ),
                  child: Row(
                    children: [
                      Text(o.letter, style: AppTextStyles.mono(size: 11, color: AppColors.lime)),
                      const SizedBox(width: 9),
                      Expanded(
                          child: Text(o.text, style: AppTextStyles.body(size: 12.5, color: Colors.white))),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.lime, foregroundColor: AppColors.green900),
              onPressed: () => _confirmAnswer(quiz),
              child: const Text('Confirmar resposta'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionCard() {
    final hasMore = _nextAvailableSetIndex != null;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.green900, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: AppColors.lime.withOpacity(0.18), borderRadius: BorderRadius.circular(16)),
            alignment: Alignment.center,
            child: const Icon(Icons.emoji_events_outlined, color: AppColors.lime, size: 26),
          ),
          const SizedBox(height: 14),
          Text('Quiz de ${_currentSet.title} concluído!',
              textAlign: TextAlign.center,
              style: AppTextStyles.display(size: 17, weight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 6),
          Text(
            hasMore
                ? 'Boa! Tem mais um quiz disponível pra você continuar hoje.'
                : 'Você concluiu todos os quizzes disponíveis por hoje.\nVolte amanhã para realizar outro quiz.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body(size: 12.5, color: const Color(0xFFBFE3CE), height: 1.5),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: hasMore
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.lime, foregroundColor: AppColors.green900),
                    onPressed: _startAnotherQuiz,
                    child: const Text('Fazer outro quiz'),
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white38),
                    ),
                    onPressed: _restartAllQuizzes,
                    child: const Text('Refazer os quizzes de hoje'),
                  ),
          ),
        ],
      ),
    );
  }
}

class _TrailCard extends StatelessWidget {
  final ContentTrail trail;
  const _TrailCard({required this.trail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.trailDetail, arguments: trail),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, AppColors.green100],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TRILHA · ${trail.category.toUpperCase()}', style: AppTextStyles.mono(color: AppColors.green700)),
            const SizedBox(height: 4),
            Text(trail.title, style: AppTextStyles.display(size: 17, weight: FontWeight.w700)),
            const SizedBox(height: 3),
            Text('${trail.moduleInfo} · ${trail.remainingLessons} aulas restantes',
                style: AppTextStyles.body(size: 12, color: AppColors.ink600)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Progresso', style: AppTextStyles.body(size: 11.5, weight: FontWeight.w700)),
                Text('${(trail.progress * 100).round()}%', style: AppTextStyles.body(size: 11.5, weight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 6),
            ProgressBarWidget(value: trail.progress, color: AppColors.green700),
          ],
        ),
      ),
    );
  }
}
