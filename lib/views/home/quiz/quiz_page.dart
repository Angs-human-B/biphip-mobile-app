import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/onboarding/picture_upload_screen.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizPage extends StatelessWidget {
  QuizPage({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  @override
  Widget build(BuildContext context) {
    postReactionController.contextValue = context;
    return WillPopScope(
      onWillPop: () async {
        leaveQuizAlertDialog(
            context: context,
            content: LeaveQuizPopupContent(
                text: ksLeaveQuizConfirmation.tr,
                leaveOnPressed: () {
                  Get.find<HomeController>().homeTabIndex.value = 0;
                  Get.offAllNamed(krHome);
                }),
            title: ksConfirmation.tr);
        return true;
      },
      child: Container(
        color: cWhiteColor,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: cWhiteColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kAppBarSize),
              //* info:: appBar
              child: CustomAppBar(
                appBarColor: cWhiteColor,
                title: postReactionController.questionList.isNotEmpty
                    ? "${postReactionController.questionListData.value?.quiz?.title.toString()}"
                    : "${postReactionController.questionListData.value?.result?.quiz?.title.toString()}",
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  // if (postReactionController.currentIndex.value > 0) {
                  //   postReactionController.currentIndex.value--;
                  // } else {
                  //   Get.back();
                  // }
                  // Get.back();
                  leaveQuizAlertDialog(
                      context: context,
                      content: LeaveQuizPopupContent(
                          text: ksLeaveQuizConfirmation.tr,
                          leaveOnPressed: () {
                            Get.find<HomeController>().homeTabIndex.value = 0;
                            Get.offAllNamed(krHome);
                          }),
                      title: ksConfirmation.tr);
                },
                action: [
                  Padding(
                    padding: const EdgeInsets.only(right: k20Padding),
                    child: Obx(() => TextButton(
                          style: kTextButtonStyle,
                          onPressed: postReactionController.selectedAnswer.value != '' && postReactionController.isQuizTimedOut.value == false
                              ? () async {
                                  if (postReactionController.currentIndex.value < postReactionController.questionList.length - 1) {
                                    postReactionController.nextQuestion();
                                    postReactionController.selectedAnswerList.add(postReactionController.selectedAnswer.value);
                                    postReactionController.selectedAnswer.value = '';
                                    if (postReactionController.isQuizTimedOut.value) {
                                      quizTimeOutAlertDialog(context: context, content: const QuizTimeOutContent());
                                    }
                                  } else {
                                    await postReactionController.submitQuiz();
                                    postReactionController.isLastQuestion.value = true;
                                    postReactionController.selectedAnswerList.add(postReactionController.selectedAnswer.value);
                                    postReactionController.selectedAnswer.value = '';
                                    if (int.parse(postReactionController.rightAnswer.value) == 0) {
                                      quizZeroScoreAlertDialog(context: context, content: QuizZeroScoreContent());
                                    } else {
                                      quizCongratulationsAlertDialog(
                                        context: context,
                                        content: QuizCongratulationContent(),
                                      );
                                    }
                                  }
                                }
                              : null,
                          child: Text(
                            postReactionController.currentIndex.value < postReactionController.questionList.length - 1 ? ksNext.tr : ksFinish.tr,
                            style: semiBold16TextStyle(postReactionController.selectedAnswer.value != '' && postReactionController.isQuizTimedOut.value == false
                                ? cPrimaryColor
                                : cPlaceHolderColor),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Obx(() => postReactionController.questionList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          kH24sizedBox,
                          Container(
                            width: width - 40,
                            height: h40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: cLineColor),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(k8Padding),
                              child: Row(
                                children: [
                                  Icon(
                                    BipHip.twitchFill,
                                    color: (postReactionController.calculatePercentage() / 100) > 0.8 ? cRedColor : cPrimaryColor,
                                    size: kIconSize20,
                                  ),
                                  LinearPercentIndicator(
                                    progressColor: (postReactionController.calculatePercentage() / 100) > 0.8 ? cRedColor : cPrimaryColor,
                                    percent: postReactionController.calculatePercentage() / 100,
                                    barRadius: const Radius.circular(k8BorderRadius),
                                    lineHeight: 6,
                                    width: width - 150,
                                    backgroundColor: cNeutralColor,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: postReactionController.time.value,
                                        style: semiBold12TextStyle((postReactionController.calculatePercentage() / 100) > 0.8 ? cRedColor : cPrimaryColor),
                                      ),
                                      TextSpan(
                                        text: postReactionController.questionList.isNotEmpty
                                            ? "/00:${postReactionController.questionListData.value?.quiz?.playingDuration.toString()}"
                                            : "/00:${postReactionController.questionListData.value?.result?.quiz?.playingDuration.toString()}",
                                        style: semiBold12TextStyle(cPlaceHolderColor),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                          kH16sizedBox,
                          Row(
                            mainAxisAlignment: postReactionController.questionList[postReactionController.currentIndex.value].content != null
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              if (postReactionController.questionList[postReactionController.currentIndex.value].content != null)
                                Expanded(
                                  child: Text(
                                    postReactionController.questionList[postReactionController.currentIndex.value].content.toString(),
                                    overflow: TextOverflow.clip,
                                    style: semiBold14TextStyle(cBlackColor),
                                  ),
                                ),
                              CustomCircularProgressBar(
                                percent: (postReactionController.currentIndex.value + 1) / (postReactionController.questionList.length),
                                radius: h32,
                                lineWidth: 5,
                                centerWidget: Text(
                                  '${postReactionController.currentIndex.value + 1}/${postReactionController.questionList.length}',
                                  style: regular16TextStyle(cBlackColor),
                                ),
                              ),
                            ],
                          ),
                          kH24sizedBox,
                          if (postReactionController.questionList[postReactionController.currentIndex.value].mediaUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                              child: SizedBox(
                                width: width,
                                height: 140,
                                child: Image.network(
                                  postReactionController.questionList[postReactionController.currentIndex.value].mediaUrl.toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    BipHip.imageFile,
                                    size: kIconSize100,
                                    color: cIconColor,
                                  ),
                                  loadingBuilder: imageLoadingBuilder,
                                ),
                              ),
                            ),
                          kH24sizedBox,
                          for (int i = 0; i < postReactionController.questionList[postReactionController.currentIndex.value].options.length; i++)
                            // for (int j = 0; j < postReactionController.questionList[i].options.length; j++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k8Padding),
                              child: Obx(() => CustomListTile(
                                    itemColor: postReactionController.selectedAnswer.value ==
                                            postReactionController.questionList[postReactionController.currentIndex.value].options[i]
                                        ? cPrimaryTint3Color
                                        : cWhiteColor,
                                    onPressed: () {
                                      postReactionController.selectedAnswer.value =
                                          postReactionController.questionList[postReactionController.currentIndex.value].options[i];
                                    },
                                    title: postReactionController.questionList[postReactionController.currentIndex.value].options[i],
                                    borderColor: postReactionController.selectedAnswer.value ==
                                            postReactionController.questionList[postReactionController.currentIndex.value].options[i]
                                        ? cPrimaryColor
                                        : cLineColor,
                                    trailing: CustomRadioButton(
                                      onChanged: () {
                                        postReactionController.selectedAnswer.value =
                                            postReactionController.questionList[postReactionController.currentIndex.value].options[i];
                                      },
                                      isSelected: postReactionController.selectedAnswer.value ==
                                          postReactionController.questionList[postReactionController.currentIndex.value].options[i],
                                    ),
                                  )),
                            ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: width - 40,
                      height: height - (kAppBarSize + MediaQuery.of(context).padding.top),
                      child: EmptyView(title: ksNoQuizAvailableForToday.tr))),
            ),
          ),
        ),
      ),
    );
  }
}

void leaveQuizAlertDialog({required BuildContext context, required Widget content, required String title}) {
  showAlertDialog(
    context: context,
    child: CommonAlertDialog(
      hasCloseBtn: false,
      addContent: content,
      title: title,
    ),
  );
}

class LeaveQuizPopupContent extends StatelessWidget {
  const LeaveQuizPopupContent({super.key, required this.text, this.leaveOnPressed});
  final String text;
  final VoidCallback? leaveOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k12Padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: regular14TextStyle(cBlackColor),
            textAlign: TextAlign.center,
          ),
          kH20sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                label: ksCancel.tr,
                onPressed: () {
                  Get.back();
                },
                buttonColor: cWhiteColor,
                borderColor: cRedColor,
                textStyle: semiBold18TextStyle(cRedColor),
                buttonHeight: h44,
                buttonWidth: 100,
              ),
              CustomElevatedButton(
                label: ksLeave.tr,
                onPressed: leaveOnPressed,
                buttonColor: cRedColor,
                borderColor: cRedColor,
                textStyle: semiBold18TextStyle(cWhiteColor),
                buttonHeight: h44,
                buttonWidth: 100,
              ),
            ],
          ),
          kH20sizedBox,
        ],
      ),
    );
  }
}

void quizCongratulationsAlertDialog({required BuildContext context, required Widget content}) {
  showAlertDialog(
    context: context,
    child: CommonAlertDialog(
      hasCloseBtn: false,
      addContent: content,
    ),
  );
}

class QuizCongratulationContent extends StatelessWidget {
  QuizCongratulationContent({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: k20Padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: width - 40,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  gradient: const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: <Color>[cBlueLinearColor1, cBlueLinearColor2]),
                ),
              ),
              Positioned(
                left: h12,
                bottom: h12,
                child: SvgPicture.asset(kiCongratulation1),
              ),
              Positioned(
                right: h12,
                bottom: h12,
                child: SvgPicture.asset(kiCongratulation2),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: k16Padding),
                child: Center(
                  child: CircularPercentIndicator(
                    percent: int.parse(postReactionController.rightAnswer.value) / (postReactionController.currentIndex.value + 1),
                    radius: h44,
                    backgroundColor: cGreyBoxColor,
                    lineWidth: 6,
                    circularStrokeCap: CircularStrokeCap.round,
                    linearGradient: const LinearGradient(
                      colors: [cYellowLinearColor1, cYellowLinearColor2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    center: Text(
                      '${postReactionController.rightAnswer.value}/${postReactionController.currentIndex.value + 1}',
                      style: semiBold24TextStyle(cWhiteColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          kH20sizedBox,
          Text(
            "${ksCongratulations.tr}!",
            style: semiBold18TextStyle(cPrimaryColor),
          ),
          kH8sizedBox,
          PopupQuizCommonElement(
            subTitleText: ksLetWhoWillWinThisQuiz.tr,
            playMoreOnPresse: () {
              Get.find<HomeController>().homeTabIndex.value = 0;
              Get.offAllNamed(krHome);
            },
            backHomeOnPressed: () {
              Get.find<HomeController>().homeTabIndex.value = 0;
              Get.offAllNamed(krHome);
            },
          ),
        ],
      ),
    );
  }
}

void quizTimeOutAlertDialog({required BuildContext context, required Widget content}) {
  showAlertDialog(
    context: context,
    child: CommonAlertDialog(
      hasCloseBtn: false,
      addContent: content,
    ),
  );
}

class QuizTimeOutContent extends StatelessWidget {
  const QuizTimeOutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        kH40sizedBox,
        const Icon(
          BipHip.twitchFill, //!Icon Must be changed
          color: cRedColor,
          size: kIconSize40,
        ),
        kH12sizedBox,
        Text(
          ksTimeOut,
          style: semiBold24TextStyle(cRedColor),
        ),
        kH12sizedBox,
        PopupQuizCommonElement(
          subTitleText: ksLetWhoWillWinThisQuiz.tr,
          playMoreOnPresse: () {
            Get.find<HomeController>().homeTabIndex.value = 0;
            Get.offAllNamed(krHome);
          },
          backHomeOnPressed: () {
            Get.find<HomeController>().homeTabIndex.value = 0;
            Get.offAllNamed(krHome);
          },
        ),
      ],
    );
  }
}

void quizZeroScoreAlertDialog({required BuildContext context, required Widget content}) {
  showAlertDialog(
    context: context,
    child: CommonAlertDialog(
      hasCloseBtn: false,
      addContent: content,
    ),
  );
}

class QuizZeroScoreContent extends StatelessWidget {
  QuizZeroScoreContent({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            kH40sizedBox,
            Text(
              '${ksOpps.tr}!!!',
              style: regular14TextStyle(cRedColor),
            ),
            kH12sizedBox,
            Text(
              postReactionController.questionList.isNotEmpty
                  ? "${ksYourScore.tr}: ${postReactionController.rightAnswer.value}"
                  : "${ksYourScore.tr}: ${postReactionController.questionListData.value!.result!.countRightAnswer.toString()}",
              style: semiBold24TextStyle(cRedColor),
            ),
            kH12sizedBox,
            PopupQuizCommonElement(
              subTitleText: ksLetWhoWillWinThisQuiz.tr,
              playMoreOnPresse: () {
                Get.find<HomeController>().homeTabIndex.value = 0;
                Get.offAllNamed(krHome);
              },
              backHomeOnPressed: () {
                Get.find<HomeController>().homeTabIndex.value = 0;
                Get.offAllNamed(krHome);
              },
            ),
          ],
        ));
  }
}

class PopupQuizCommonElement extends StatelessWidget {
  PopupQuizCommonElement({super.key, required this.subTitleText, this.playMoreOnPresse, this.backHomeOnPressed});
  final String subTitleText;
  final VoidCallback? playMoreOnPresse;
  final VoidCallback? backHomeOnPressed;
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          subTitleText,
          style: regular14TextStyle(cSmallBodyTextColor),
          textAlign: TextAlign.center,
        ),
        kH20sizedBox,
        Row(
          children: [
            QuizResultCommonContainer(
                title: ksCorrectAnswer.tr,
                subTitle: postReactionController.questionList.isNotEmpty
                    ? "${postReactionController.rightAnswer.value} answers"
                    : "${postReactionController.questionListData.value!.result!.countRightAnswer.toString()} answers"),
            const SizedBox(
              width: 5,
            ),
            QuizResultCommonContainer(
                title: ksScore.tr,
                subTitle: postReactionController.questionList.isNotEmpty
                    ? postReactionController.totalMarks.value
                    : postReactionController.questionListData.value!.result!.totalMarks.toString()),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            QuizResultCommonContainer(
                title: ksTime.tr,
                subTitle: postReactionController.questionList.isNotEmpty
                    ? "${postReactionController.totalElapsedTime.value.toString()} sec"
                    : "${double.parse(postReactionController.questionListData.value!.result!.elapsedTime.toString()).toStringAsFixed(0)} sec"),
            const SizedBox(
              width: 5,
            ),
            QuizResultCommonContainer(
                title: ksWrongAnswer.tr,
                subTitle: postReactionController.questionList.isNotEmpty
                    ? "${postReactionController.wrongAnswer.value} answers"
                    : "${postReactionController.questionListData.value!.result!.countWrongAnswer.toString()} answers"),
          ],
        ),
        kH24sizedBox,
        CustomElevatedButton(buttonWidth: width - 80, label: ksPlayMore.tr, onPressed: playMoreOnPresse),
        kH20sizedBox,
        InkWell(
          onTap: backHomeOnPressed,
          child: Text(
            ksBackToHome.tr,
            style: regular12TextStyle(cSmallBodyTextColor),
          ),
        ),
        kH20sizedBox,
      ],
    );
  }
}

class QuizResultCommonContainer extends StatelessWidget {
  const QuizResultCommonContainer({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width - 80) / 2,
      height: 70,
      decoration: BoxDecoration(
        color: cGreyBoxColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: k12Padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: regular14TextStyle(cSmallBodyTextColor),
            ),
            kH4sizedBox,
            Text(
              subTitle,
              style: semiBold16TextStyle(cBlackColor),
            ),
          ],
        ),
      ),
    );
  }
}
