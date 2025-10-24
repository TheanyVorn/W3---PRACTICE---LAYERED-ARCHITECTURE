import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');
    while (true) {
      stdout.write('Your name: ');
      final name = stdin.readLineSync();
      if (name == null || name.isEmpty) break;

      final answers = quiz.questions
          .map((q) => _askQuestion(q))
          .whereType<Answer>()
          .toList();

      final sub = Submission(playerName: name, answers: answers);
      quiz.addSubmission(sub);
      _displayScores(sub);
      print('');
    }
    print('--- Quiz Finished ---');
  }

  Answer? _askQuestion(Question q) {
    print('Question: ${q.title} - (${q.points} points)');
    print('Choices: ${q.choices}');
    stdout.write('Your answer: ');
    final input = stdin.readLineSync();
    if (input != null && input.isNotEmpty) {
      return Answer(questionId: q.id, answerChoice: input);
    }
    print('No answer entered. Skipping question.');
    return null;
  }

  void _displayScores(Submission current) {
    print(
        '${current.playerName}, your score in percentage: ${quiz.getTotalPercentage(current)} %');
    print(
        '${current.playerName}, your score in points: ${quiz.getTotalPoints(current)} %');
    for (var sub in quiz.submissions) {
      print(
          'Player: ${sub.playerName}        Score:${quiz.getTotalPoints(sub)}');
    }
  }
}
