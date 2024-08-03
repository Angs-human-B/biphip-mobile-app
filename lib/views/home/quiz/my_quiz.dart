import 'package:bip_hip/controllers/menu/quiz_controller.dart';
import 'package:bip_hip/models/home/quiz/all_quiz_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/quiz/quiz_page.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class MyQuiz extends StatelessWidget {
  MyQuiz({super.key});
  final QuizController quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksQuiz.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Obx(() => SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH16sizedBox,
                      TapAbleButtonContainer(
                        buttonText: quizController.quizTapButtonText,
                        buttonState: quizController.quizTapButtonState,
                        buttonPress: RxList([
                          () {
                            unFocus(context);
                            quizController.dailyQuizTapableButtonOnPressed();
                          },
                          () async {
                            unFocus(context);
                            quizController.playedQuizTapableButtonOnPressed();
                          },
                          () {
                            unFocus(context);
                            quizController.winnerQuizTapableButtonOnPressed();
                          },
                        ]),
                      ),

                      if (quizController.quizTapButtonState[0])
                        Padding(
                          padding: const EdgeInsets.only(top: k20Padding, bottom: k16Padding),
                          child: Text(
                            ksTodaysQuiz.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                        ),
                      if (quizController.quizTapButtonState[0]) MyDailyQuiz(),

                      if (quizController.quizTapButtonState[1])
                        Padding(
                          padding: const EdgeInsets.only(top: k20Padding, bottom: k16Padding),
                          child: Text(
                            ksAlreadyPlayed.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                        ),
                      if (quizController.quizTapButtonState[1]) MyPlayedQuiz(),
                      if (quizController.quizTapButtonState[2])
                        Padding(
                          padding: const EdgeInsets.only(top: k16Padding),
                          child: CustomModifiedTextField(
                              borderRadius: h8,
                              controller: quizController.quizWinnerTextEditingController,
                              prefixIcon: BipHip.search,
                              suffixIcon: quizController.isWinnerSuffixVisible.value ? BipHip.circleCrossNew : null,
                              hint: ksSearch.tr,
                              contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                              textInputStyle: regular16TextStyle(cBlackColor),
                              onSuffixPress: () {
                                quizController.isWinnerSuffixVisible.value = false;
                                quizController.quizWinnerTextEditingController.clear();
                              },
                              onSubmit: (v) {
                                unfocus(context);
                                quizController.isWinnerSuffixVisible.value = true;
                              },
                              onChanged: (v) {
                                if (quizController.quizWinnerTextEditingController.text.toString().trim() != '') {
                                  quizController.isWinnerSuffixVisible.value = true;
                                } else {
                                  quizController.isWinnerSuffixVisible.value = false;
                                }
                              }),
                        ),
                      if (quizController.quizTapButtonState[2])
                        Padding(
                          padding: const EdgeInsets.only(top: k8Padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ksYouWon.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              CustomElevatedButton(
                                prefixIcon: BipHip.calendarFill,
                                prefixIconColor: cIconColor,
                                buttonWidth: 100,
                                buttonHeight: h28,
                                label: ksSelectDate.tr,
                                textStyle: regular14TextStyle(cSmallBodyTextColor),
                                onPressed: () {},
                                buttonColor: cWhiteColor,
                                borderColor: cLineColor,
                              ),
                            ],
                          ),
                        ),
                      if (quizController.quizTapButtonState[2]) kH16sizedBox,
                      if (quizController.quizTapButtonState[2])
                        quizController.myQuizWinnerLoading.value
                            ? const QuizWinnerShimmer()
                            : quizController.myQuizWinnerList.isNotEmpty
                                ? NotificationListener<ScrollNotification>(
                                    onNotification: (scrollNotification) {
                                      if (quizController.myQuizWinnerScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                                          scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                                          !quizController.myQuizWinnerListScrolled.value) {
                                        quizController.myQuizWinnerListScrolled.value = true;
                                        if (quizController.myQuizWinnerList.isNotEmpty) {
                                          quizController.getMoreMyQuizWinnerList(null);
                                        }
                                        return true;
                                      }
                                      return false;
                                    },
                                    child: Expanded(
                                      child: SingleChildScrollView(
                                        controller: quizController.myQuizWinnerScrollController,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              separatorBuilder: (context, index) => kH16sizedBox,
                                              itemCount: quizController.myQuizWinnerList.length,
                                              itemBuilder: (context, index) {
                                                return QuizWinner(
                                                  image: quizController.myQuizWinnerList[index].user?.profilePicture,
                                                  name: quizController.myQuizWinnerList[index].user?.fullName,
                                                  quizTitle: quizController.myQuizWinnerList[index].quiz?.title,
                                                  ranking: quizController.myQuizWinnerList[index].obtainedMarks.toString(),
                                                  correctAnswer: quizController.myQuizWinnerList[index].countRightAnswer.toString(),
                                                  totalQuestions: quizController.myQuizWinnerList[index].totalMarks.toString(),
                                                  totalTime: double.parse(quizController.myQuizWinnerList[index].elapsedTime.toString()).toStringAsFixed(0),
                                                );
                                              },
                                            ),
                                            if (quizController.myQuizWinnerList.isNotEmpty)
                                              if (quizController.myQuizWinnerList.isNotEmpty &&
                                                  quizController.myQuizWinnerListScrolled.value &&
                                                  quizController.myQuizWinnertListSubLink.value != null)
                                                const Center(child: CircularProgressIndicator()),
                                            Padding(
                                              padding: const EdgeInsets.only(top: k24Padding, bottom: k20Padding),
                                              child: Text(
                                                ksOthersWinner.tr,
                                                style: semiBold18TextStyle(cBlackColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: cLineColor, width: 1),
                                          borderRadius: BorderRadius.circular(k8BorderRadius),
                                        ),
                                        child: EmptyView(height: 130, title: ksYouHaveNotWonAnyQuiz.tr),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: k24Padding, bottom: k20Padding),
                                        child: Text(
                                          ksOthersWinner.tr,
                                          style: semiBold18TextStyle(cBlackColor),
                                        ),
                                      ),
                                    ],
                                  ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class MyPlayedQuiz extends StatelessWidget {
  MyPlayedQuiz({super.key});
  final QuizController quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => quizController.isMyAllPlayedQuizLoading.value
          ? const PlayedQuizShimmer()
          : quizController.myAllPlayedQuizList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (quizController.myAllPlayedQuizScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !quizController.myAllPlayedQuizListScrolled.value) {
                      quizController.myAllPlayedQuizListScrolled.value = true;
                      if (quizController.myAllPlayedQuizList.isNotEmpty) {
                        quizController.getMorePlayedQuizList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: quizController.myAllPlayedQuizScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: quizController.myAllPlayedQuizList.length,
                            separatorBuilder: (context, index) => kH16sizedBox,
                            itemBuilder: (BuildContext context, int index) {
                              return CommonDailyAndPlayedQuiz(
                                image: quizController.myAllPlayedQuizList[index].quiz!.mediaUrl,
                                title: quizController.myAllPlayedQuizList[index].quiz!.title == null
                                    ? ksNA
                                    : (quizController.myAllPlayedQuizList[index].quiz!.title).toString(),
                                correctAnswer: "${quizController.myAllPlayedQuizList[index].countRightAnswer}/",
                                totalQuestions: "${quizController.myAllPlayedQuizList[index].totalMarks}",
                                totalTime:
                                    "Taken Time: ${double.parse(quizController.myAllPlayedQuizList[index].elapsedTime.toString()).toStringAsFixed(0)} sec",
                                actionText: "Score: ${quizController.myAllPlayedQuizList[index].obtainedMarks}",
                                actionTextStyle: semiBold14TextStyle(quizController.myAllPlayedQuizList[index].obtainedMarks == 0 ? cRedColor : cPrimaryColor),
                              );
                            },
                          ),
                          if (quizController.myAllPlayedQuizList.isNotEmpty)
                            if (quizController.myAllPlayedQuizList.isNotEmpty &&
                                quizController.myAllPlayedQuizListScrolled.value &&
                                quizController.myAllPlayedQuizListSubLink.value != null)
                              const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: EmptyView(title: ksNoPlayedQuizYet.tr)),
    );
  }
}

class MyDailyQuiz extends StatelessWidget {
  MyDailyQuiz({super.key});
  final QuizController quizController = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => quizController.isQuestionLoading.value
        ? const PlayedQuizShimmer()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonDailyAndPlayedQuiz(
                image: quizController.questionList.isNotEmpty
                    ? quizController.questionListData.value?.quiz?.media.toString()
                    : quizController.questionListData.value?.result?.quiz?.media.toString(),
                title: quizController.questionList.isNotEmpty
                    ? "${quizController.questionListData.value?.quiz?.title}"
                    : "${quizController.questionListData.value?.result?.quiz?.title.toString()}",
                noOfQuestions: quizController.questionList.isNotEmpty
                    ? "${quizController.questionListData.value?.quiz?.noOfQuestions.toString()} questions"
                    : "${quizController.questionListData.value?.result?.quiz?.noOfQuestions.toString()} questions",
                totalTime: quizController.questionList.isNotEmpty
                    ? "Duration: ${quizController.questionListData.value?.quiz?.playingDuration} sec"
                    : "Duration: ${quizController.questionListData.value?.result?.quiz?.playingDuration.toString()} sec",
                actionText: quizController.questionList.isNotEmpty ? ksTapToPlay.tr : ksAlreadyPlayed.tr,
                icon: quizController.questionList.isNotEmpty ? BipHip.rightArrow : null,
                actionTextStyle: semiBold14TextStyle(quizController.questionList.isNotEmpty ? cPrimaryColor : cRedColor),
                imageList: quizController.questionList.isNotEmpty
                    ? quizController.questionListData.value?.quiz?.participants
                    : quizController.questionListData.value?.result?.quiz?.participants,
                onPressed: () {
                  if (quizController.questionList.isNotEmpty) {
                    quizController.totalTimeCalculation();
                    quizController.timerStartFunction();
                    Get.toNamed(krQuizPage);
                  } else {
                    quizController.timer?.cancel();
                    Get.toNamed(krQuizPage);
                    if (quizController.questionListData.value!.result!.countRightAnswer == 0) {
                      quizZeroScoreAlertDialog(context: context, content: QuizZeroScoreContent());
                    } else {
                      quizCongratulationsAlertDialog(
                        context: context,
                        content: QuizCongratulationContent(),
                      );
                    }
                  }
                },
              ),
            ],
          ));
  }
}

class CommonDailyAndPlayedQuiz extends StatelessWidget {
  const CommonDailyAndPlayedQuiz({
    super.key,
    this.image,
    required this.title,
    this.noOfQuestions,
    required this.totalTime,
    required this.actionText,
    required this.actionTextStyle,
    this.icon,
    this.imageList = const [],
    this.correctAnswer,
    this.totalQuestions,
    this.onPressed,
  });
  final String? image;
  final String title;
  final String? noOfQuestions;
  final String? correctAnswer;
  final String? totalQuestions;
  final String totalTime;
  final String actionText;
  final TextStyle actionTextStyle;
  final IconData? icon;
  final List<Participant>? imageList;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width - 40,
        height: 108,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(k8BorderRadius),
          border: Border.all(width: 1, color: cLineColor),
        ),
        child: Row(
          children: [
            if (image != null)
              Padding(
                padding: const EdgeInsets.all(k8Padding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.network(
                      image ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(kiDummyImage1ImageUrl);
                      },
                      loadingBuilder: imageLoadingBuilder,
                    ),
                  ),
                ),
              ),
            if (image == null) kW8sizedBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH12sizedBox,
                  Text(
                    title,
                    style: semiBold16TextStyle(cBlackColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (noOfQuestions != null)
                    Padding(
                      padding: const EdgeInsets.only(top: k4Padding),
                      child: Text(
                        noOfQuestions!,
                        style: regular12TextStyle(csmallBodyTextColor2),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  if (correctAnswer != null && totalQuestions != null)
                    Padding(
                      padding: const EdgeInsets.only(top: k4Padding),
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(children: [
                            TextSpan(text: "${ksCorrectAnswer.tr}: $correctAnswer/", style: regular12TextStyle(cBlackColor)),
                            TextSpan(text: "$totalQuestions", style: regular12TextStyle(cSmallBodyTextColor)),
                          ])),
                    ),
                  kH4sizedBox,
                  Text(
                    totalTime,
                    style: regular12TextStyle(csmallBodyTextColor2),
                    textAlign: TextAlign.left,
                  ),
                  kH8sizedBox,
                  SizedBox(
                    width: width - (40 + 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          actionText,
                          style: actionTextStyle,
                        ),
                        if (icon != null)
                          Icon(
                            icon,
                            size: kIconSize16,
                            color: cPrimaryColor,
                          ),
                        const Spacer(),
                        Stack(
                          children: [
                            const SizedBox(
                              width: 60,
                              height: 20,
                            ),
                            if (imageList!.isNotEmpty)
                              for (int i = 0; i < 3; i++)
                                Positioned(
                                  left: i * 12,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: cWhiteColor, width: 1),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        imageList![i].profilePicture ?? "",
                                        fit: BoxFit.cover,
                                        loadingBuilder: smallImageLoadingBuilder,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            kiProfileDefaultImageUrl,
                                            height: h20,
                                            width: h20,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                            if (imageList!.isNotEmpty && imageList != null && imageList!.length > 3)
                              Positioned(
                                left: 36,
                                child: Container(
                                  width: h20,
                                  height: h20,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: cBlackColor,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "+" "${imageList!.length - 3}",
                                      style: regular10TextStyle(cWhiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayedQuizShimmer extends StatelessWidget {
  const PlayedQuizShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) => kH16sizedBox,
              itemBuilder: (context, index) {
                return Container(
                  width: width - 40,
                  height: 108,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                    border: Border.all(width: 1, color: cLineColor),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(k8Padding),
                        child: ShimmerCommon(
                          widget: Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: cWhiteColor,
                                borderRadius: BorderRadius.circular(k8BorderRadius),
                              )),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kH12sizedBox,
                          ShimmerCommon(
                            widget: Container(
                                height: h14,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                )),
                          ),
                          kH4sizedBox,
                          ShimmerCommon(
                            widget: Container(
                                height: h14,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                )),
                          ),
                          kH4sizedBox,
                          ShimmerCommon(
                            widget: Container(
                                height: h14,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                )),
                          ),
                          kH8sizedBox,
                          SizedBox(
                            width: width - (40 + 120),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                      height: h14,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: cWhiteColor,
                                        borderRadius: BorderRadius.circular(k8BorderRadius),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuizWinner extends StatelessWidget {
  const QuizWinner({super.key, this.image, this.ranking, this.name, this.quizTitle, this.correctAnswer, this.totalQuestions, this.totalTime});
  final String? image;
  final String? ranking;
  final String? name;
  final String? quizTitle;
  final String? correctAnswer;
  final String? totalQuestions;
  final String? totalTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        border: Border.all(width: 1, color: cLineColor2),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(k12Padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    const SizedBox(
                      height: 72,
                      width: 56,
                    ),
                    Positioned(
                      top: h16,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              cYellowLinearColor1,
                              cYellowLinearColor2,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(k4Padding),
                          child: ClipOval(
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: cWhiteColor,
                              ),
                              child: Image.network(
                                image ?? '',
                                fit: BoxFit.cover,
                                loadingBuilder: imageLoadingBuilder,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    kiProfileDefaultImageUrl,
                                    height: h40,
                                    width: h40,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: h16,
                      child: SvgPicture.asset(
                        kiWinner,
                        width: h24,
                        height: h24,
                      ),
                    ),
                  ],
                ),
                kH4sizedBox,
                Stack(
                  children: [
                    Container(),
                    SvgPicture.asset(
                      kiPositionBadge,
                      width: h24,
                      height: h24,
                    ),
                    Positioned(
                        top: 6,
                        left: h8,
                        child: Text(
                          ranking ?? '0',
                          style: semiBold10TextStyle(cWhiteColor),
                        )),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: k24Padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(children: [
                            TextSpan(text: name ?? ksNA, style: semiBold14TextStyle(cBlackColor)),
                            TextSpan(text: " ${ksWonOn.tr}", style: regular12TextStyle(cSmallBodyTextColor)),
                          ])),
                      kW4sizedBox,
                      SvgPicture.asset(
                        kiQuizWinner,
                        height: h16,
                        width: h16,
                        color: cPrimaryColor,
                      ),
                      kW4sizedBox,
                      Text(
                        ksQuiz,
                        style: semiBold12TextStyle(cPrimaryColor),
                      ),
                    ],
                  ),
                  kH12sizedBox,
                  Text(
                    quizTitle!,
                    style: semiBold14TextStyle(cBlackColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  kH4sizedBox,
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: [
                        TextSpan(text: "${ksCorrectAnswer.tr}: $correctAnswer/", style: regular12TextStyle(cBlackColor)),
                        TextSpan(text: totalQuestions!, style: regular12TextStyle(cSmallBodyTextColor)),
                      ])),
                  kH4sizedBox,
                  Text(
                    "Completion Time: $totalTime sec",
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizWinnerShimmer extends StatelessWidget {
  const QuizWinnerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) => kH16sizedBox,
              itemBuilder: (context, index) {
                return Container(
                  width: width - 40,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                    border: Border.all(width: 1, color: cLineColor),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                const SizedBox(
                                  height: 72,
                                  width: 56,
                                ),
                                Positioned(
                                  top: h16,
                                  child: Container(
                                    width: 56,
                                    height: 56,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(k4Padding),
                                      child: ClipOval(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: cWhiteColor,
                                          ),
                                          child: ShimmerCommon(
                                            widget: Container(
                                              height: 56,
                                              width: 56,
                                              decoration: BoxDecoration(
                                                color: cWhiteColor,
                                                borderRadius: BorderRadius.circular(k8BorderRadius),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: h16,
                                  child: ShimmerCommon(
                                    widget: SvgPicture.asset(
                                      kiWinner,
                                      width: h24,
                                      height: h24,
                                      color: cWhiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            kH4sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h24,
                                  width: h24,
                                  decoration: const BoxDecoration(
                                    color: cWhiteColor,
                                    shape: BoxShape.circle,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kH20sizedBox,
                          ShimmerCommon(
                            widget: Container(
                                height: h14,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                )),
                          ),
                          kH4sizedBox,
                          ShimmerCommon(
                            widget: Container(
                                height: h14,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                )),
                          ),
                          kH4sizedBox,
                          ShimmerCommon(
                            widget: Container(
                                height: h14,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                )),
                          ),
                          kH8sizedBox,
                          SizedBox(
                            width: width - (40 + 120),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                      height: h14,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: cWhiteColor,
                                        borderRadius: BorderRadius.circular(k8BorderRadius),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
