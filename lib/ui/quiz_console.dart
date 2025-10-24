import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---');
    bool isFirstPlayer = true;
    while (true) {
      String prompt = isFirstPlayer ? 'Your name: ' : 'Player: ';
      isFirstPlayer = false;
      stdout.write(prompt);
      String? name = stdin.readLineSync();
      if (name == null || name.isEmpty) {
        print('--- Quiz Finished ---');
        break;
      }
      List<Answer> playerAnswers = [];
      for (var question in quiz.questions) {
        print('Question: ${question.title} - ${question.points} points');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          playerAnswers.add(answer);
        } else {
          print('No answer entered. Skipping question.');
        }
        print('');
      }
      Submission submission =
          Submission(playerName: name, answers: playerAnswers);
      int percentage = quiz.getTotalPercentage(submission);
      int total = quiz.getTotalPoints(submission);
      print('$name, your score in percentage: $percentage%');
      print('$name, your score in point: $total');
      print('Player:$name, score: $total%');
      print('--- Quiz Finished ---');
      quiz.addSubmission(submission);
    }
  }
}
