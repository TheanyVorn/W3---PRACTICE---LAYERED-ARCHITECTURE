import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {
  List<Question> questions = [
    Question(
        title: "Capital of France? - (10 point)",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris",
        points: 10),
    Question(
        title: "2 + 2 = ? - (50 points)",
        choices: ["2", "4", "5"],
        goodChoice: "4",
        points: 50),
  ];

  Quiz quiz = Quiz(questions: questions);
  QuizConsole console = QuizConsole(quiz: quiz);

  console.startQuiz();
}
