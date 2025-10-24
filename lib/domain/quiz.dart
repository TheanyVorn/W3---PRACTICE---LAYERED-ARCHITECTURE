import 'package:uuid/uuid.dart';

class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question({
    String? id,
    required this.title,
    required this.choices,
    required this.goodChoice,
    this.points = 1,
  }) : id = id ?? const Uuid().v4();
}

class Answer {
  final String id;
  final String questionId;
  final String answerChoice;

  Answer({
    String? id,
    required this.questionId,
    required this.answerChoice,
  }) : id = id ?? const Uuid().v4();

  bool isGood(String correctChoice) => answerChoice == correctChoice;
}

class Submission {
  final String id;
  final String playerName;
  final List<Answer> answers;

  Submission({
    String? id,
    required this.playerName,
    required this.answers,
  }) : id = id ?? const Uuid().v4();
}

class Quiz {
  final String id;
  final List<Question> questions;
  final List<Submission> submissions = [];

  Quiz({
    String? id,
    required this.questions,
  }) : id = id ?? const Uuid().v4();

  Question? getQuestionById(String qId) {
    for (var q in questions) {
      if (q.id == qId) return q;
    }
    return null;
  }

  int getTotalPercentage(Submission sub) {
    int correct = sub.answers.where((ans) {
      final q = getQuestionById(ans.questionId);
      return q != null && ans.isGood(q.goodChoice);
    }).length;
    return ((correct / questions.length) * 100).toInt();
  }

  int getTotalPoints(Submission sub) {
    return sub.answers.fold(0, (sum, ans) {
      final q = getQuestionById(ans.questionId);
      return sum + (q != null && ans.isGood(q.goodChoice) ? q.points : 0);
    });
  }

  void addSubmission(Submission sub) {
    submissions.removeWhere((s) => s.playerName == sub.playerName);
    submissions.add(sub);
  }
}
