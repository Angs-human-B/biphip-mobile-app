import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/home/quiz/all_quiz_model.dart';

class MyAllQuizesModel {
  MyQuizzes? myQuizzes;

  MyAllQuizesModel({
    required this.myQuizzes,
  });

  factory MyAllQuizesModel.fromJson(Map<String, dynamic> json) => MyAllQuizesModel(
        myQuizzes: json["myQuizzes"] == null ? null : MyQuizzes.fromJson(json["myQuizzes"]),
      );
}

class MyQuizzes {
  int? currentPage;
  List<QuizData> data;
  String ?firstPageUrl;
  int ?from;
  int ?lastPage;
  String ?lastPageUrl;
  List<CommonLink> links;
  String ?nextPageUrl;
  String ?path;
  int ?perPage;
  dynamic prevPageUrl;
  int ?to;
  int ?total;

  MyQuizzes({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory MyQuizzes.fromJson(Map<String, dynamic> json) => MyQuizzes(
        currentPage: json["current_page"],
        data: List<QuizData>.from(json["data"].map((x) => QuizData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<CommonLink>.from(json["links"].map((x) => CommonLink.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class QuizData {
  int ?id;
  int ?userId;
  int ?quizId;
  dynamic answer;
  int ?countRightAnswer;
  int ?countWrongAnswer;
  int ?totalMarks;
  int ?obtainedMarks;
  String ?elapsedTime;
  int ?isWinner;
  User ?user;
  Quiz ?quiz;

  QuizData({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.answer,
    required this.countRightAnswer,
    required this.countWrongAnswer,
    required this.totalMarks,
    required this.obtainedMarks,
    required this.elapsedTime,
    required this.isWinner,

    required this.user,
    required this.quiz,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) => QuizData(
        id: json["id"],
        userId: json["user_id"],
        quizId: json["quiz_id"],
        answer: json["answer"],
        countRightAnswer: json["count_right_answer"],
        countWrongAnswer: json["count_wrong_answer"],
        totalMarks: json["total_marks"],
        obtainedMarks: json["obtained_marks"],
        elapsedTime: json["elapsed_time"],
        isWinner: json["is_winner"],
        user: User.fromJson(json["user"]),
        quiz: Quiz.fromJson(json["quiz"]),
      );
}
