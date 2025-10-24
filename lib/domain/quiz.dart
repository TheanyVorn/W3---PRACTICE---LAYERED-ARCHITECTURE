class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question({
    required this.title,
    required this.choices,
    required this.goodChoice,
    this.points = 1,
  });
}

class Answer {
  final Question question;
  final String answerChoice;

  Answer({required this.question, required this.answerChoice});

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Submission {
  final String playerName;
  final List<Answer> answers;

  Submission({required this.playerName, required this.answers});
}

class Quiz {
  List<Question> questions;
  List<Submission> submissions = [];

  Quiz({required this.questions});

  Submission? getPlayerName(String name) {
    try {
      return submissions.firstWhere((s) => s.playerName == name);
    } catch (e) {
      return null;
    }
  }

  void addSubmission(Submission submission) {
    var existing = getPlayerName(submission.playerName);
    if (existing != null) {
      submissions.remove(existing);
    }
    submissions.add(submission);
  }

  int getTotalPercentage(Submission submission) {
    int totalScore = 0;
    for (Answer answer in submission.answers) {
      if (answer.isGood()) {
        totalScore++;
      }
    }
    return ((totalScore / questions.length) * 100).toInt();
  }

  int getTotalPoints(Submission submission) {
    int totalPoint = 0;
    for (Answer answer in submission.answers) {
      if (answer.isGood()) {
        totalPoint += answer.question.points;
      }
    }
    return totalPoint;
  }

  void clearAnswers() {
    submissions.clear();
  }
}
