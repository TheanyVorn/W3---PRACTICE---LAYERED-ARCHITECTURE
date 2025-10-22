import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---');
    // print('Your name: $playerName');

    for (var question in quiz.questions) {
      print('Question: ${question.title}');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(question: question, answerChoice: userInput);
        quiz.addAnswer(answer);
      } else {
        print('No answer entered. Skipping question.');
      }

      print('');
    }

    int score = quiz.getScoreInPercentage();
    int total = quiz.getTotalPoint();
    print('Your score in percentage: $score%');
    print('Your score in point: $total');
    print('--- Quiz Finished ---');
  }
}
