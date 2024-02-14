import 'dart:async';
import 'package:bip_hip/models/home/quiz/all_quiz_model.dart';
import 'package:bip_hip/models/home/quiz/submit_quiz_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/quiz/quiz_page.dart';
import 'package:flutter_svg/svg.dart';

class PostReactionController extends GetxController with GetSingleTickerProviderStateMixin {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final RxInt selectedBidIndex = RxInt(-1);
  final RxInt selectedGiftIndex = RxInt(-1);
  final RxInt balance = RxInt(200);
  final TextEditingController bidingTextEditingController = TextEditingController();
  final TextEditingController giftTextEditingController = TextEditingController();
  final TextEditingController commentTextEditingController = TextEditingController();
  final RxBool isPackageSelected = RxBool(false);
  final Rx<Map?> selectedPackage = Rx<Map?>(null);
  final RxBool giftCheckBox = RxBool(false);
  final RxList gift1 = RxList([]);
  final RxInt badgeCount1 = RxInt(0);
  final RxInt badgeCount2 = RxInt(0);
  final RxInt badgeCount3 = RxInt(0);
  final RxInt badgeCount4 = RxInt(0);
  final RxInt tabIndex = RxInt(-1);
  late TabController tabController;
  final Rx<int?> yourBid = Rx<int?>(null);
  final RxBool showMoreBiddingInsights = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 6,
      animationDuration: Duration.zero,
      vsync: this,
    );
    tabController.addListener(() {
      giftFilter(tabController.index);
    });
  }

  void clearBadgeCount() {
    badgeCount1.value = 0;
    badgeCount2.value = 0;
    badgeCount3.value = 0;
    badgeCount4.value = 0;
  }

  void giftFilter(index) {
    gift1.clear();
    clearBadgeCount();
    for (int i = 0; i < giftContributors.length; i++) {
      if (giftContributors[i]['giftType'] == 'badge1') {
        badgeCount1.value++;
      } else if (giftContributors[i]['giftType'] == 'badge2') {
        badgeCount2.value++;
      } else if (giftContributors[i]['giftType'] == 'badge3') {
        badgeCount3.value++;
      } else if (giftContributors[i]['giftType'] == 'badge4') {
        badgeCount4.value++;
      }
    }
    for (int i = 0; i < giftContributors.length; i++) {
      if (index == 0) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge1' && index == 1) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge2' && index == 2) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge3' && index == 3) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge4' && index == 4) {
        gift1.add(giftContributors[i]);
      }
    }
  }

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController mmyyStarController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final RxBool giftAgreeCheckBox = RxBool(false);
  final RxList reactEmojiList = RxList([]);

  List reactionView(map) {
    map.remove('All');
    reactEmojiList.clear();
    List<MapEntry<String, dynamic>> entries = map.entries.toList();
    ll(entries);
    if (entries.length > 1) {
      entries.sort((a, b) => b.value.compareTo(a.value));
    }

    List<MapEntry<String, dynamic>> topThree = entries.take(3).toList();

    for (int index = 0; index < topThree.length; index++) {
      if (topThree[index].value == 0) {
        continue;
      }
      if (topThree[index].key == 'like') {
        reactEmojiList.add(kiLikeSvgImageUrl);
      } else if (topThree[index].key == 'love') {
        reactEmojiList.add(kiLoveSvgImageUrl);
      } else if (topThree[index].key == 'sad') {
        reactEmojiList.add(kiSadSvgImageUrl);
      } else if (topThree[index].key == 'wow') {
        reactEmojiList.add(kiWowSvgImageUrl);
      } else if (topThree[index].key == 'haha') {
        reactEmojiList.add(kiHahaSvgImageUrl);
      } else {
        reactEmojiList.add(kiAngrySvgImageUrl);
      }
    }
    // ll(reactEmojiList);
    return reactEmojiList;
  }

  double reactStackWidthGetter() {
    if (reactEmojiList.length == 1) {
      return 15;
    } else if (reactEmojiList.length == 2) {
      return 25;
    } else {
      return 35;
    }
  }

  List<Map<String, dynamic>> reactions = [];
  final Rx<String?> selectedReactionText = Rx<String?>(null);
  final ScrollController scrollController = ScrollController();
  final RxInt postIndex = RxInt(-1);

  selectedReaction(postIndex) {
    if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Love') {
      return SvgPicture.asset(
        kiLoveSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Like') {
      return SvgPicture.asset(
        kiLikeSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Haha') {
      return SvgPicture.asset(
        kiHahaSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Wow') {
      return SvgPicture.asset(
        kiWowSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Sad') {
      return SvgPicture.asset(
        kiSadSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Angry') {
      return SvgPicture.asset(
        kiAngrySvgImageUrl,
        width: 20,
      );
    }
  }

  //* Quiz
  // final RxList<Map<String, dynamic>> quizQuestions = RxList([
  //   {
  //     "image":
  //         'https://images.unsplash.com/photo-1500076656116-558758c991c1?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     'question':
  //         "Question1:What is the term for the number of strokes a skilled golfer should take to complete a hole or round of golf, considering the course's difficulty?"
  //   },
  //   {
  //     "image": null,
  //     'question':
  //         "Question1:What is the term for the number of strokes a skilled golfer should take to complete a hole or round of golf, considering the course's difficulty?"
  //   },
  //   {
  //     "image": null,
  //     'question':
  //         "Question1:What is the term for the number of strokes a skilled golfer should take to complete a hole or round of golf, considering the course's difficulty?"
  //   },
  //   {
  //     "image":
  //         'https://images.unsplash.com/photo-1500076656116-558758c991c1?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     'question':
  //         "Question1:What is the term for the number of strokes a skilled golfer should take to complete a hole or round of golf, considering the course's difficulty?"
  //   },
  // ]);
  
  final RxInt currentIndex = RxInt(0);

  void nextQuestion() {
    if (questionList.isNotEmpty && currentIndex.value < questionList.length - 1) {
      currentIndex.value++;
    } else {}
  }

  final RxList selectedAnswerList = RxList([]);
  final RxString selectedAnswer = RxString('');
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
   int getTotalTime(){
    if(questionList.isNotEmpty){
      return totalTime.value = int.parse(questionListData.value!.quiz!.playingDuration.toString());
    }
    else{
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
    timer = Timer.periodic(duration, (timer) {
      if (remainingSeconds.value == 0) {
        int minutes = remainingSeconds.value ~/ 60;
        int seconds = (remainingSeconds.value % 60);
        time.value = "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        timer.cancel();
        if (isLastQuestion.value == false) {
          submitQuiz();
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
  }

  late BuildContext contextValue;
  final RxInt quizId = RxInt(-1);
  // final RxString playingDuration = RxString('');
  // final RxString noOfQuestions = RxString('');
  // final RxString startDate = RxString('');
  // final RxString endDate = RxString('');
  //* All quiz data
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

  //*Submit quiz
  // final RxInt userId = RxInt(-1);
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
        'quiz_id': '8',
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
        isSubmitQuizLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
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
      ll('acceptFamilyRequest error: $e');
    }
  }
}
