import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_repository.dart';

void main() {
  // Option 1: Load from JSON file
  QuizRepository repository = QuizRepository('quiz.json');
  Quiz quiz = repository.readQuiz();

  // Option 2: Hardcoded questions (comment out Option 1 above to use this)
  /*
  List<Question> questions = [
    Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris",
        points: 10),
    Question(
        title: "2 + 2 = ? ",
        choices: ["2", "4", "5"],
        goodChoice: "4",
        points: 50),
  ];
  Quiz quiz = Quiz(questions: questions);
  */

  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();
}
