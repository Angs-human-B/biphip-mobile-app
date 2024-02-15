import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/quiz/quiz_page.dart';

class QuizTopWidget extends StatelessWidget {
  QuizTopWidget({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

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
          // await postReactionController.getQuestionList();
        },
        child: SizedBox(
          width: width,
          height: 130,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(k8BorderRadius),
                child: Image.network(
                  '',//!replace here media data
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
                  postReactionController.questionList.isNotEmpty
                      ? "${postReactionController.questionListData.value?.quiz?.title}"
                      : "${postReactionController.questionListData.value!.result!.quiz?.title.toString()}",
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
            // Positioned(
            //   bottom: h8,
            //   left: h8,
            //   child: ShimmerCommon(
            //       widget: Container(
            //           height: h16,
            //           width: width - 40,
            //           decoration: BoxDecoration(
            //             color: cWhiteColor,
            //             borderRadius: BorderRadius.circular(k8BorderRadius),
            //           ))),
            // ),
          ],
        ),
      ),
    );
  }
}

class QuizFirstBottomSheetContent extends StatelessWidget {
  QuizFirstBottomSheetContent({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => postReactionController.isQuestionLoading.value
        ? const QuizBottomSheetContentShimmer()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (postReactionController.questionListData.value?.quiz?.mediaUrl != null ||
                  postReactionController.questionListData.value!.result?.quiz?.mediaUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  child: Image.network(
                    postReactionController.questionList.isNotEmpty
                        ? postReactionController.questionListData.value?.quiz?.mediaUrl
                        : postReactionController.questionListData.value!.result?.quiz!.mediaUrl,
                    width: width - 40,
                    height: 150,
                    fit: BoxFit.cover,
                    // errorBuilder: (context, error, stackTrace) => const Icon(
                    //   BipHip.imageFile,
                    //   size: kIconSize100,
                    //   color: cIconColor,
                    // ),
                    loadingBuilder: imageLoadingBuilder,
                  ),
                ),
              kH16sizedBox,
              Text(
                postReactionController.questionList.isNotEmpty
                    ? "${postReactionController.questionListData.value?.quiz?.title}"
                    : "${postReactionController.questionListData.value!.result!.quiz?.title.toString()}",
                style: semiBold14TextStyle(cBlackColor),
              ),
              kH16sizedBox,
              IconAndTextRow(
                icon: BipHip.activity,
                title: postReactionController.questionList.isNotEmpty
                    ? "${postReactionController.questionListData.value?.quiz?.startDate}-${postReactionController.questionListData.value?.quiz?.endDate}"
                    : "${postReactionController.questionListData.value!.result!.quiz?.startDate.toString()}-${postReactionController.questionListData.value!.result!.quiz?.startDate.toString()}",
              ),
              kH16sizedBox,
              IconAndTextRow(
                icon: BipHip.twitchFill,
                title: postReactionController.questionList.isNotEmpty
                    ? "${postReactionController.questionListData.value?.quiz?.playingDuration}"
                    : "${postReactionController.questionListData.value!.result!.quiz?.playingDuration.toString()}",
              ),
              kH16sizedBox,
              IconAndTextRow(
                icon: BipHip.termsCondition,
                title: postReactionController.questionList.isNotEmpty
                    ? "${postReactionController.questionListData.value?.quiz?.noOfQuestions}"
                    : "${postReactionController.questionListData.value!.result!.quiz?.noOfQuestions.toString()}",
              ),
              kH30sizedBox,
              CustomElevatedButton(
                  label: ksPlayNow.tr,
                  onPressed: () async {
                    Get.back();
                    postReactionController.resetQuizData();
                    if (postReactionController.questionList.isNotEmpty) {
                      postReactionController.totalTimeCalculation();
                      postReactionController.timerStartFunction();
                      Get.toNamed(krQuizPage);
                    } else {
                      postReactionController.timer?.cancel();
                      Get.toNamed(krQuizPage);
                      if (postReactionController.questionListData.value!.result!.countRightAnswer == 0) {
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
