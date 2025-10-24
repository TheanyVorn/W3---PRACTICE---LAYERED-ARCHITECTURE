import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

void main() {
  group('Quiz Submission Tests', () {
    test('Single player 100% score', () {
      Question q1 =
          Question(title: "4-2", choices: ["1", "2", "3"], goodChoice: "2");
      Question q2 =
          Question(title: "4+2", choices: ["4", "5", "6"], goodChoice: "6");
      Quiz quiz = Quiz(questions: [q1, q2]);
      Answer a1 = Answer(question: q1, answerChoice: "2");
      Answer a2 = Answer(question: q2, answerChoice: "6");
      Submission sub = Submission(playerName: "test", answers: [a1, a2]);
      quiz.addSubmission(sub);
      expect(quiz.getTotalPercentage(sub), equals(100));
      expect(quiz.getTotalPoints(sub), equals(2));
    });

    test('Multiple players with valid scores', () {
      Question q1 =
          Question(title: "Q1", choices: ["A"], goodChoice: "A", points: 10);
      Question q2 =
          Question(title: "Q2", choices: ["B"], goodChoice: "B", points: 20);
      Quiz quiz = Quiz(questions: [q1, q2]);
      Submission sub1 = Submission(
        playerName: "Player1",
        answers: [
          Answer(question: q1, answerChoice: "A"),
          Answer(question: q2, answerChoice: "B"),
        ],
      );
      quiz.addSubmission(sub1);
      Submission sub2 = Submission(
        playerName: "Player2",
        answers: [
          Answer(question: q1, answerChoice: "A"),
          Answer(question: q2, answerChoice: "Wrong"),
        ],
      );
      quiz.addSubmission(sub2);
      expect(quiz.submissions.length, equals(2));
      expect(quiz.getTotalPercentage(sub1), equals(100));
      expect(quiz.getTotalPoints(sub1), equals(30));
      expect(quiz.getTotalPercentage(sub2), equals(50));
      expect(quiz.getTotalPoints(sub2), equals(10));
    });

    test('Overwrite same player score', () {
      Question q1 = Question(title: "Q1", choices: ["A"], goodChoice: "A");
      Question q2 = Question(title: "Q2", choices: ["B"], goodChoice: "B");
      Quiz quiz = Quiz(questions: [q1, q2]);
      Submission sub1 = Submission(
        playerName: "RepeatPlayer",
        answers: [
          Answer(question: q1, answerChoice: "A"),
          Answer(question: q2, answerChoice: "B"),
        ],
      );
      quiz.addSubmission(sub1);
      Submission sub2 = Submission(
        playerName: "RepeatPlayer",
        answers: [
          Answer(question: q1, answerChoice: "Wrong"),
          Answer(question: q2, answerChoice: "Wrong"),
        ],
      );
      quiz.addSubmission(sub2);
      expect(quiz.submissions.length, equals(1));
      expect(quiz.getTotalPercentage(quiz.submissions[0]), equals(0));
    });
  });
}
