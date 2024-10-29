import 'package:bip_hip/models/home/quiz/submit_quiz_model.dart';

class AllQuizModel {
  Quiz? quiz;
  List<Question> questions;
   Result ? result;


  AllQuizModel({
    required this.quiz,
    required this.questions,
     required this.result,
  });

  factory AllQuizModel.fromJson(Map<String, dynamic> json) => AllQuizModel(
        quiz: json["quiz"] == null ? null : Quiz.fromJson(json["quiz"]),
        questions: json["questions"] == null ? [] :List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
        result: json["result"]==null ? null : Result.fromJson(json["result"]),
      );
}

class Question {
  int? id;
  int? quizId;
  String? content;
  String? media;
  String? mediaType;
  List<String> options;
  int? rightOptionIndex;
  dynamic rightOption;
  int? mark;
  String? mediaUrl;

  Question({
    required this.id,
    required this.quizId,
    required this.content,
    required this.media,
    required this.mediaType,
    required this.options,
    required this.rightOptionIndex,
    required this.rightOption,
    required this.mark,
    required this.mediaUrl,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        quizId: json["quiz_id"],
        content: json["content"],
        media: json["media"],
        mediaType: json["media_type"],
        options: List<String>.from(json["options"].map((x) => x)),
        rightOptionIndex: json["right_option_index"],
        rightOption: json["right_option"],
        mark: json["mark"],
        mediaUrl: json["media_url"],
      );
}

class Quiz {
  int? id;
  String? title;
  String? content;
  dynamic media;
  dynamic mediaType;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  int? playingDuration;
  int? noOfQuestions;
  List<Participant> participants;
  dynamic mediaUrl;

  Quiz({
    required this.id,
    required this.title,
    required this.content,
    required this.media,
    required this.mediaType,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.playingDuration,
    required this.noOfQuestions,
    required this.participants,
    required this.mediaUrl,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        media: json["media"],
        mediaType: json["media_type"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        playingDuration: json["playing_duration"],
        noOfQuestions: json["no_of_questions"],
        participants: json["participants"] != null ? List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x))) : [],
        mediaUrl: json["media_url"],
      );
}

class Participant {
  String? profilePicture;

  Participant({
    required this.profilePicture,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        profilePicture: json["profile_picture"],
      );
}
