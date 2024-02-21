// import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/home/quiz/all_quiz_model.dart';

class SubmitQuizModel {
  Result ? result;

  SubmitQuizModel({
    required this.result,
  });

  factory SubmitQuizModel.fromJson(Map<String, dynamic> json) => SubmitQuizModel(
        result: Result.fromJson(json["result"]),
      );
}

class Result {
  String? elapsedTime;
  int? countRightAnswer;
  int? countWrongAnswer;
  int? obtainedMarks;
  int? totalMarks;
  int? quizId;
  int? userId;
  int? id;
  Quiz? quiz;
  // User? user;

  Result({
    required this.elapsedTime,
    required this.countRightAnswer,
    required this.countWrongAnswer,
    required this.obtainedMarks,
    required this.totalMarks,
    required this.quizId,
    required this.userId,
    required this.id,
    required this.quiz,
    // required this.user,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        elapsedTime: json["elapsed_time"],
        countRightAnswer: json["count_right_answer"],
        countWrongAnswer: json["count_wrong_answer"],
        obtainedMarks: json["obtained_marks"],
        totalMarks: json["total_marks"],
        quizId: json["quiz_id"],
        userId: json["user_id"],
        id: json["id"],
        quiz: Quiz.fromJson(json["quiz"]),
        // user: User.fromJson(json["user"]),
      );
}
