import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz() {
    final data =
        jsonDecode(File(filePath).readAsStringSync()) as Map<String, dynamic>;

    final questions = (data['questions'] as List)
        .map((q) => Question(
              id: q['id'],
              title: q['title'],
              choices: List<String>.from(q['choices']),
              goodChoice: q['goodChoice'],
              points: q['points'] ?? 1,
            ))
        .toList();

    final quiz = Quiz(id: data['id'], questions: questions);

    for (var subJson in (data['submissions'] as List? ?? [])) {
      final answers = (subJson['answers'] as List)
          .map((a) => Answer(
                id: a['id'],
                questionId: a['questionId'],
                answerChoice: a['answerChoice'],
              ))
          .toList();

      quiz.addSubmission(Submission(
        id: subJson['id'],
        playerName: subJson['playerName'],
        answers: answers,
      ));
    }

    return quiz;
  }
}
