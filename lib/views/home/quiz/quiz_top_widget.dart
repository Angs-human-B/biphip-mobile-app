import 'package:bip_hip/controllers/menu/quiz_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/quiz/quiz_page.dart';
import 'package:intl/intl.dart';

class QuizTopWidget extends StatelessWidget {
  QuizTopWidget({super.key});
  final QuizController quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k10Padding),
      child: InkWell(
        onTap: () async {
          Get.find<GlobalController>().commonBottomSheet(
              context: context,
              bottomSheetHeight: height * 0.7,
              isScrollControlled: false,
              content: QuizFirstBottomSheetContent(),
              onPressCloseButton: () {
                Get.back();
              },
              onPressRightButton: () {
                Get.back();
                Get.toNamed(krQuizPage);
              },
              rightText: '',
              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
              title: ksQuiz.tr,
              isRightButtonShow: false);
        },
        child: SizedBox(
          width: width,
          height: 130,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(k8BorderRadius),
                child: Image.network(
                  quizController.questionList.isNotEmpty
                      ? "${quizController.questionListData.value?.quiz?.media}"
                      : "${quizController.questionListData.value!.result?.quiz?.media}",
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      kiDummyImage1ImageUrl,
                      width: width - 40,
                      fit: BoxFit.cover,
                    );
                  },
                  loadingBuilder: imageLoadingBuilder,
                  width: width - 40,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: h8,
                left: h8,
                child: Text(
                  quizController.questionList.isNotEmpty
                      ? "${quizController.questionListData.value?.quiz?.title}"
                      : "${quizController.questionListData.value?.result!.quiz?.title.toString()}",
                  style: semiBold12TextStyle(cWhiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageTopTapableQuizShimmer extends StatelessWidget {
  const HomePageTopTapableQuizShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k10Padding),
      child: SizedBox(
        width: width,
        height: 130,
        child: Stack(
          children: [
            ShimmerCommon(
                widget: Container(
                    height: 130,
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: cWhiteColor,
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                    ))),
          ],
        ),
      ),
    );
  }
}

class QuizFirstBottomSheetContent extends StatelessWidget {
  QuizFirstBottomSheetContent({super.key});
  final QuizController quizController = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => quizController.isQuestionLoading.value
        ? const QuizBottomSheetContentShimmer()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(k8BorderRadius),
                child: Image.network(
                  quizController.questionList.isNotEmpty
                      ? (quizController.questionListData.value?.quiz?.media ?? "")
                      : (quizController.questionListData.value!.result?.quiz?.media ?? ""),
                  width: width - 40,
                  height: 150,
                  fit: BoxFit.cover,
                  loadingBuilder: imageLoadingBuilder,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      BipHip.imageFile,
                      size: kIconSize100,
                      color: cIconColor,
                    ),
                  ),
                ),
              ),
              kH16sizedBox,
              Text(
                quizController.questionList.isNotEmpty
                    ? "${quizController.questionListData.value?.quiz?.title}"
                    : "${quizController.questionListData.value!.result!.quiz?.title.toString()}",
                style: semiBold14TextStyle(cBlackColor),
              ),
              kH16sizedBox,
              IconAndTextRow(
                icon: BipHip.activity, //!Icon must change
                title: quizController.questionList.isNotEmpty
                    ? "${ksDuration.tr}:  ${DateFormat('dd MMM, yyyy').format(quizController.questionListData.value?.quiz!.startDate ?? DateTime.now())} - ${DateFormat('dd MMM, yyyy').format(quizController.questionListData.value?.quiz!.endDate ?? DateTime.now())}"
                    : "${ksDuration.tr}: ${DateFormat('dd MMM, yyyy').format(quizController.questionListData.value!.result!.quiz?.startDate ?? DateTime.now())} - ${DateFormat('dd MMM, yyyy').format(quizController.questionListData.value!.result!.quiz?.endDate ?? DateTime.now())}",
              ),
              kH16sizedBox,
              IconAndTextRow(
                icon: BipHip.twitchFill, //!Icon must change
                title: quizController.questionList.isNotEmpty
                    ? "${ksPlayingDuration.tr}: ${quizController.questionListData.value?.quiz?.playingDuration}"
                    : "${ksPlayingDuration.tr}: ${quizController.questionListData.value!.result!.quiz?.playingDuration.toString()}",
              ),
              kH16sizedBox,
              IconAndTextRow(
                icon: BipHip.termsCondition, //!Icon must change
                title: quizController.questionList.isNotEmpty
                    ? "${ksQuestions.tr}: ${quizController.questionListData.value?.quiz?.noOfQuestions}"
                    : "${ksQuestions.tr}: ${quizController.questionListData.value!.result!.quiz?.noOfQuestions.toString()}",
              ),
              kH30sizedBox,
              CustomElevatedButton(
                  label: ksPlayNow.tr,
                  onPressed: () async {
                    Get.back();
                    quizController.resetQuizData();
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
                  }),
            ],
          ));
  }
}

class QuizBottomSheetContentShimmer extends StatelessWidget {
  const QuizBottomSheetContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: k8CircularBorderRadius,
          child: ShimmerCommon(
            widget: Container(
              color: cWhiteColor,
              height: 150,
              width: width - 40,
            ),
          ),
        ),
        kH16sizedBox,
        ShimmerCommon(
          widget: Container(
            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
            height: h16,
            width: 200,
          ),
        ),
        kH16sizedBox,
        Row(
          children: [
            ShimmerCommon(
              widget: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: cWhiteColor,
                ),
                height: h16,
                width: h16,
              ),
            ),
            kW8sizedBox,
            ShimmerCommon(
              widget: Container(
                decoration: BoxDecoration(
                  borderRadius: k8CircularBorderRadius,
                  color: cWhiteColor,
                ),
                height: h16,
                width: 120,
              ),
            ),
          ],
        ),
        kH16sizedBox,
        Row(
          children: [
            ShimmerCommon(
              widget: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: cWhiteColor,
                ),
                height: h16,
                width: h16,
              ),
            ),
            kW8sizedBox,
            ShimmerCommon(
              widget: Container(
                decoration: BoxDecoration(
                  borderRadius: k8CircularBorderRadius,
                  color: cWhiteColor,
                ),
                height: h16,
                width: 120,
              ),
            ),
          ],
        ),
        kH16sizedBox,
        Row(
          children: [
            ShimmerCommon(
              widget: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: cWhiteColor,
                ),
                height: h16,
                width: h16,
              ),
            ),
            kW8sizedBox,
            ShimmerCommon(
              widget: Container(
                decoration: BoxDecoration(
                  borderRadius: k8CircularBorderRadius,
                  color: cWhiteColor,
                ),
                height: h16,
                width: 120,
              ),
            ),
          ],
        ),
        kH30sizedBox,
        Center(
          child: ShimmerCommon(
            widget: Container(
              decoration: BoxDecoration(
                borderRadius: k8CircularBorderRadius,
                color: cWhiteColor,
              ),
              height: h44,
              width: (width - 40) / 2,
            ),
          ),
        ),
      ],
    );
  }
}

class IconAndTextRow extends StatelessWidget {
  const IconAndTextRow({super.key, this.icon, this.title});
  final IconData? icon;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: kIconSize16,
              color: cIconColor,
            ),
            kW8sizedBox,
            Expanded(
              child: Text(
                title!,
                overflow: TextOverflow.clip,
                style: regular12TextStyle(cBlackColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
