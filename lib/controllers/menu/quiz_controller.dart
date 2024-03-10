import 'dart:async';
import 'package:bip_hip/models/home/quiz/all_quiz_model.dart';
import 'package:bip_hip/models/home/quiz/my_all_quizes_model.dart';
import 'package:bip_hip/models/home/quiz/my_quiz_winner_model.dart';
import 'package:bip_hip/models/home/quiz/submit_quiz_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/quiz/quiz_page.dart';

class QuizController extends GetxController{
    final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
    final RxInt currentIndex = RxInt(0);
    final String perPageTake = "take=15";

  void nextQuestion() {
    if (questionList.isNotEmpty && currentIndex.value < questionList.length - 1) {
      currentIndex.value++;
    } else {}
  }

  final RxList selectedAnswerList = RxList([]);
  final RxString selectedAnswer = RxString('');
  final RxInt selectedAnswerIndex = RxInt(-1);
//* Quiz Timer All function
  Timer? timer;
  final RxInt remainingSeconds = RxInt(1);
  final time = "00.00".obs;
  final totalTimes = "00.00".obs;
  final RxInt totalTime = RxInt(30);
  final RxBool isLastQuestion = RxBool(false);
  void timerStartFunction() {
    // startTimer(int.parse(questionListData.value?.result!.elapsedTime.toString()));
    startTimer(getTotalTime());
  }

  int getTotalTime() {
    if (questionList.isNotEmpty) {
      return totalTime.value = int.parse(questionListData.value!.quiz!.playingDuration.toString());
    } else {
      return totalTime.value = int.parse(questionListData.value!.result!.elapsedTime.toString());
    }
  }

  totalTimeCalculation() {
    int totalTimeMinute = totalTime.value ~/ 60;
    int remainingSeconds = totalTime.value % 60;
    totalTimes.value = "${totalTimeMinute.toString().padLeft(2, "0")}:${remainingSeconds.toString().padLeft(2, "0")}";
  }

  double calculatePercentage() {
    return ((totalTime.value - remainingSeconds.value) / totalTime.value) * 100;
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }

  startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds.value = seconds;
    timer = Timer.periodic(duration, (timer) async {
      if (remainingSeconds.value == 0) {
        int minutes = remainingSeconds.value ~/ 60;
        int seconds = (remainingSeconds.value % 60);
        time.value = "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        timer.cancel();
        if (isLastQuestion.value == false) {
          isQuizTimedOut.value = true;
          await submitQuiz();
          quizTimeOutAlertDialog(context: contextValue, content: QuizTimeOutContent());
        }
      } else {
        int minutes = remainingSeconds.value ~/ 60;
        int seconds = (remainingSeconds.value % 60);
        time.value = "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds.value--;
      }
    });
  }

  void resetQuizData() {
    timer?.cancel();
    currentIndex.value = 0;
    selectedAnswerList.clear();
    selectedAnswer.value = '';
    remainingSeconds.value = 1;
    isLastQuestion.value = false;
    isQuizTimedOut.value = false;
  }

  late BuildContext contextValue;
  final RxBool isQuizTimedOut = RxBool(false);
  //* All quiz data
  final RxInt quizId = RxInt(-1);
  final Rx<AllQuizModel?> questionListData = Rx<AllQuizModel?>(null);
  final RxList<Question> questionList = RxList<Question>([]);
  final RxBool isQuestionLoading = RxBool(false);
  Future<void> getQuestionList() async {
    try {
      isQuestionLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllQuiz,
      ) as CommonDM;
      if (response.success == true) {
        questionList.clear();
        questionListData.value = AllQuizModel.fromJson(response.data);
        questionList.addAll(questionListData.value!.questions);
        if (questionList.isNotEmpty) {
          quizId.value = questionListData.value!.quiz!.id!;
        } else {
          quizId.value = questionListData.value!.result!.quiz!.id!;
        }
        isQuestionLoading.value = false;
      } else {
        isQuestionLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isQuestionLoading.value = true;
      ll('getQuestionList error: $e');
    }
  }

  //*Scroll controller for pagination
  final ScrollController myAllPlayedQuizScrollController = ScrollController();
  //* My All quizes Api call
  final Rx<MyAllQuizesModel?> myAllPlayedQuizListData = Rx<MyAllQuizesModel?>(null);
  final RxList<QuizData> myAllPlayedQuizList = RxList<QuizData>([]);
  final RxBool isMyAllPlayedQuizLoading = RxBool(false);
  final Rx<String?> myAllPlayedQuizListSubLink = Rx<String?>(null);
  final RxBool myAllPlayedQuizListScrolled = RxBool(false);
  Future<void> getPlayedQuizesList() async {
    try {
      isMyAllPlayedQuizLoading.value = true;
      String suffixUrl = '?$perPageTake';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuMyAllQuizes + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        myAllPlayedQuizList.clear();
        myAllPlayedQuizListScrolled.value = false;
        myAllPlayedQuizListData.value = MyAllQuizesModel.fromJson(response.data);
        myAllPlayedQuizList.addAll(myAllPlayedQuizListData.value!.myQuizzes!.data);
        myAllPlayedQuizListSubLink.value = myAllPlayedQuizListData.value!.myQuizzes!.nextPageUrl;
        if (myAllPlayedQuizListSubLink.value != null) {
          myAllPlayedQuizListScrolled.value = false;
        } else {
          myAllPlayedQuizListScrolled.value = true;
        }
        isMyAllPlayedQuizLoading.value = false;
      } else {
        isMyAllPlayedQuizLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isMyAllPlayedQuizLoading.value = true;
      ll('geQuizesList error: $e');
    }
  }

  //*Get More Played Quiz for pagination
  Future<void> getMorePlayedQuizList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic playedQuizSub;

      if (myAllPlayedQuizListSubLink.value == null) {
        return;
      } else {
        playedQuizSub = myAllPlayedQuizListSubLink.value!.split('?');
      }

      String playedQuizListSuffixUrl = '';

      playedQuizListSuffixUrl = '?${playedQuizSub[1]}&$perPageTake';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuMyAllQuizes + playedQuizListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        myAllPlayedQuizListData.value = MyAllQuizesModel.fromJson(response.data);
        myAllPlayedQuizList.addAll(myAllPlayedQuizListData.value!.myQuizzes!.data);
        myAllPlayedQuizListSubLink.value = myAllPlayedQuizListData.value!.myQuizzes!.nextPageUrl;
        if (myAllPlayedQuizListSubLink.value != null) {
          myAllPlayedQuizListScrolled.value = false;
        } else {
          myAllPlayedQuizListScrolled.value = true;
        }
        isMyAllPlayedQuizLoading.value = false;
      } else {
        isMyAllPlayedQuizLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isMyAllPlayedQuizLoading.value = true;
      ll('getMorePlayedQuizList error: $e');
    }
  }

  //*Scroll controller for pagination
  final ScrollController myQuizWinnerScrollController = ScrollController();
  //* My All winner quizes Api call
  final Rx<MyQuizWinnerModel?> myQuizWinnerListData = Rx<MyQuizWinnerModel?>(null);
  final RxList<QuizWinnerData> myQuizWinnerList = RxList<QuizWinnerData>([]);
  final RxBool myQuizWinnerLoading = RxBool(false);
  final Rx<String?> myQuizWinnertListSubLink = Rx<String?>(null);
  final RxBool myQuizWinnerListScrolled = RxBool(false);
  Future<void> getmyQuizWinnerList() async {
    try {
      myQuizWinnerLoading.value = true;
      String suffixUrl = '?$perPageTake';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuMyQuizWinner + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        myQuizWinnerList.clear();
        myQuizWinnerListScrolled.value = false;
        myQuizWinnerListData.value = MyQuizWinnerModel.fromJson(response.data);
        myQuizWinnerList.addAll(myQuizWinnerListData.value!.myWinningQuizzes!.data);
        myQuizWinnertListSubLink.value = myQuizWinnerListData.value!.myWinningQuizzes!.nextPageUrl;
        if (myQuizWinnertListSubLink.value != null) {
          myQuizWinnerListScrolled.value = false;
        } else {
          myQuizWinnerListScrolled.value = true;
        }
        myQuizWinnerLoading.value = false;
      } else {
        myQuizWinnerLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      myQuizWinnerLoading.value = true;
      ll('getmyQuizWinnerList error: $e');
    }
  }

  //*Get More Quiz Winner List for pagination
  Future<void> getMoreMyQuizWinnerList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic myQuizWinnerSub;

      if (myQuizWinnertListSubLink.value == null) {
        return;
      } else {
        myQuizWinnerSub = myQuizWinnertListSubLink.value!.split('?');
      }

      String myQuizWinnerListSuffixUrl = '';

      myQuizWinnerListSuffixUrl = '?${myQuizWinnerSub[1]}&$perPageTake';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuMyQuizWinner + myQuizWinnerListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        myQuizWinnerListData.value = MyQuizWinnerModel.fromJson(response.data);
        myQuizWinnerList.addAll(myQuizWinnerListData.value!.myWinningQuizzes!.data);
        myQuizWinnertListSubLink.value = myQuizWinnerListData.value!.myWinningQuizzes!.nextPageUrl;
        if (myQuizWinnertListSubLink.value != null) {
          myQuizWinnerListScrolled.value = false;
        } else {
          myQuizWinnerListScrolled.value = true;
        }
        myQuizWinnerLoading.value = false;
      } else {
        myQuizWinnerLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      myQuizWinnerLoading.value = true;
      ll('getMoreMyQuizWinnerList error: $e');
    }
  }

  //*Submit quiz
  final RxString rightAnswer = RxString('');
  final RxString wrongAnswer = RxString('');
  final RxString totalMarks = RxString('');
  final RxString totalElapsedTime = RxString('');
  final Rx<SubmitQuizModel?> submitQuizData = Rx<SubmitQuizModel?>(null);
  final List questionAnswerIndex = [];
  final RxBool isSubmitQuizLoading = RxBool(false);
  Future<void> submitQuiz() async {
    try {
      isSubmitQuizLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'quiz_id': quizId.value.toString(),
        for (int i = 0; i < selectedAnswerList.length; i++) 'question_answer_index[$i]': selectedAnswerList[i],
        'elapsed_time': totalTime.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSubmitAnswer,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        submitQuizData.value = SubmitQuizModel.fromJson(response.data);
        rightAnswer.value = (submitQuizData.value?.result!.countRightAnswer).toString();
        wrongAnswer.value = (submitQuizData.value?.result!.countWrongAnswer).toString();
        totalMarks.value = (submitQuizData.value?.result!.totalMarks).toString();
        totalElapsedTime.value = (submitQuizData.value?.result!.elapsedTime).toString();
        timer?.cancel();
        isSubmitQuizLoading.value = false;
      } else {
        isSubmitQuizLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSubmitQuizLoading.value = false;
      ll('submitQuiz error: $e');
    }
  }

  final RxList quizTapButtonState = RxList([true, false, false]);
  final RxList quizTapButtonText = RxList(["Daily Quiz", "Played", "Winner"]);
  void dailyQuizTapableButtonOnPressed() async {
    quizToggleType(0);
    await getQuestionList();
  }

  void playedQuizTapableButtonOnPressed() async {
    quizToggleType(1);
    await getPlayedQuizesList();
  }

  void winnerQuizTapableButtonOnPressed() async {
    quizToggleType(2);
    await getmyQuizWinnerList();
  }

  void quizToggleType(int index) {
    switch (index) {
      case 0:
        quizTapButtonState[0] = true;
        quizTapButtonState[1] = false;
        quizTapButtonState[2] = false;
        break;
      case 1:
        quizTapButtonState[0] = false;
        quizTapButtonState[1] = true;
        quizTapButtonState[2] = false;
        break;
      case 2:
        quizTapButtonState[0] = false;
        quizTapButtonState[1] = false;
        quizTapButtonState[2] = true;
        break;
    }
  }

  void resetQuizTapButtonData() {
    quizTapButtonState.clear();
    quizTapButtonState.addAll([true, false, false]);
  }

  final TextEditingController quizWinnerTextEditingController = TextEditingController();
  final RxBool isWinnerSuffixVisible = RxBool(false);
}
