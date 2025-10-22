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

class Quiz {
  List<Question> questions;
  List<Answer> answers = [];

  Quiz({required this.questions});

  void addAnswer(Answer answer) {
    this.answers.add(answer);
  }

  int getTotalPoint() {
    int totalPoint = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalPoint += answer.question.points;
      }
    }
    return totalPoint;
  }

  // int get totalPoint => getTotalPoint();

  int getScoreInPercentage() {
    int totalScore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalScore++;
      }
    }
    return ((totalScore / questions.length) * 100).toInt();
  }

  // int get totalScore => getScoreInPercentage();

  void clearAnswers() {
    answers.clear();
  }
}
