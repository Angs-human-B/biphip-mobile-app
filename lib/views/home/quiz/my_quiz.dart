import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class MyQuiz extends StatelessWidget {
  MyQuiz({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

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
                      TapAbleButtonContainer(
                        buttonText: postReactionController.quizTapButtonText,
                        buttonState: postReactionController.quizTapButtonState,
                        buttonPress: RxList([
                          () {
                            unFocus(context);
                            postReactionController.dailyQuizTapableButtonOnPressed();
                          },
                          () async {
                            unFocus(context);
                            postReactionController.playedQuizTapableButtonOnPressed();
                          },
                          () {
                            unFocus(context);
                            postReactionController.winnerQuizTapableButtonOnPressed();
                          },
                        ]),
                      ),
                      if (postReactionController.quizTapButtonState[0]) const MyDailyQuiz(),
                      if (postReactionController.quizTapButtonState[1])
                        Padding(
                          padding: const EdgeInsets.only(top: k20Padding, bottom: k16Padding),
                          child: Text(
                            ksAlreadyPlayed.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                        ),
                      if (postReactionController.quizTapButtonState[1]) MyPlayedQuiz(),
                      // postReactionController.isMyQuizesLoading.value ? const PlayedQuizShimmer() : MyPlayedQuiz(),
                      if (postReactionController.quizTapButtonState[2])
                        Padding(
                          padding: const EdgeInsets.only(top: k16Padding),
                          child: CustomModifiedTextField(
                              borderRadius: h8,
                              controller: postReactionController.quizWinnerTextEditingController,
                              prefixIcon: BipHip.search,
                              suffixIcon: postReactionController.isWinnerSuffixVisible.value ? BipHip.circleCrossNew : null,
                              hint: ksSearch.tr,
                              contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                              textInputStyle: regular16TextStyle(cBlackColor),
                              onSuffixPress: () {
                                postReactionController.isWinnerSuffixVisible.value = false;
                                postReactionController.quizWinnerTextEditingController.clear();
                              },
                              onSubmit: (v) {
                                unfocus(context);
                                postReactionController.isWinnerSuffixVisible.value = true;
                              },
                              onChanged: (v) {
                                if (postReactionController.quizWinnerTextEditingController.text.toString().trim() != '') {
                                  postReactionController.isWinnerSuffixVisible.value = true;
                                } else {
                                  postReactionController.isWinnerSuffixVisible.value = false;
                                }
                              }),
                        ),
                      if (postReactionController.quizTapButtonState[2])
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
                                buttonWidth: 96,
                                buttonHeight: 28,
                                label: ksSelectDate.tr,
                                textStyle: regular14TextStyle(cSmallBodyTextColor),
                                onPressed: () {},
                                buttonColor: cWhiteColor,
                                borderColor: cLineColor,
                              ),
                            ],
                          ),
                        ),
                      if (postReactionController.quizTapButtonState[2]) kH16sizedBox,
                      if (postReactionController.quizTapButtonState[2])
                        postReactionController.myQuizWinnerLoading.value
                            ? const QuizWinnerShimmer()
                            : postReactionController.myQuizWinnerList.isNotEmpty
                                ? NotificationListener<ScrollNotification>(
                                    onNotification: (scrollNotification) {
                                      if (postReactionController.myQuizWinnerScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                                          scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                                          !postReactionController.myQuizWinnerListScrolled.value) {
                                        postReactionController.myQuizWinnerListScrolled.value = true;
                                        if (postReactionController.myQuizWinnerList.isNotEmpty) {
                                          postReactionController.getMoreMyQuizWinnerList(null);
                                        }
                                        return true;
                                      }
                                      return false;
                                    },
                                    child: Expanded(
                                      child: SingleChildScrollView(
                                        controller: postReactionController.myQuizWinnerScrollController,
                                        child: Column(
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              separatorBuilder: (context, index) => kH16sizedBox,
                                              itemCount: postReactionController.myQuizWinnerList.length,
                                              itemBuilder: (context, index) {
                                                return QuizWinner(
                                                  image: postReactionController.myQuizWinnerList[index].user?.profilePicture,
                                                  name: postReactionController.myQuizWinnerList[index].user?.fullName,
                                                  quizTitle: postReactionController.myQuizWinnerList[index].quiz?.title,
                                                  ranking: postReactionController.myQuizWinnerList[index].obtainedMarks.toString(),
                                                  correctAnswer: postReactionController.myQuizWinnerList[index].countRightAnswer.toString(),
                                                  totalQuestions: postReactionController.myQuizWinnerList[index].totalMarks.toString(),
                                                  totalTime:
                                                      double.parse(postReactionController.myQuizWinnerList[index].elapsedTime.toString()).toStringAsFixed(0),
                                                );
                                              },
                                            ),
                                            if (postReactionController.myQuizWinnerList.isNotEmpty)
                                              if (postReactionController.myQuizWinnerList.isNotEmpty &&
                                                  postReactionController.myQuizWinnerListScrolled.value &&
                                                  postReactionController.myQuizWinnertListSubLink.value != null)
                                                const Center(child: CircularProgressIndicator()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(child: EmptyView(title: ksYouHaveNotWonAnyQuiz.tr)),
                      // if (postReactionController.quizTapButtonState[2])
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: k20Padding, bottom: k16Padding),
                      //     child: Text(
                      //       ksOthersWinner.tr,
                      //       style: semiBold18TextStyle(cBlackColor),
                      //     ),
                      //   ),
                      // if (postReactionController.quizTapButtonState[2])
                      //   Expanded(
                      //     child: SingleChildScrollView(
                      //       child: Column(
                      //         children: [
                      //           ListView.separated(
                      //             shrinkWrap: true,
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             separatorBuilder: (context, index) => kH16sizedBox,
                      //             itemCount: 5,
                      //             itemBuilder: (context, index) {
                      //               return QuizWinner();
                      //             },
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
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
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => postReactionController.isMyAllPlayedQuizLoading.value
          ? const PlayedQuizShimmer()
          : postReactionController.myAllPlayedQuizList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (postReactionController.myAllPlayedQuizScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !postReactionController.myAllPlayedQuizListScrolled.value) {
                      postReactionController.myAllPlayedQuizListScrolled.value = true;
                      if (postReactionController.myAllPlayedQuizList.isNotEmpty) {
                        postReactionController.getMorePlayedQuizList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: postReactionController.myAllPlayedQuizScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: postReactionController.myAllPlayedQuizList.length,
                            separatorBuilder: (context, index) => kH16sizedBox,
                            itemBuilder: (BuildContext context, int index) {
                              return CommonDailyAndPlayedQuiz(
                                image: postReactionController.myAllPlayedQuizList[index].quiz!.mediaUrl,
                                title: postReactionController.myAllPlayedQuizList[index].quiz!.title == null
                                    ? ksNA
                                    : (postReactionController.myAllPlayedQuizList[index].quiz!.title).toString(),
                                correctAnswer: "${postReactionController.myAllPlayedQuizList[index].countRightAnswer}/",
                                totalQuestions: "${postReactionController.myAllPlayedQuizList[index].totalMarks}",
                                totalTime:
                                    "Taken Time: ${double.parse(postReactionController.myAllPlayedQuizList[index].elapsedTime.toString()).toStringAsFixed(0)}",
                                actionText: "Score: ${postReactionController.myAllPlayedQuizList[index].obtainedMarks}",
                                actionTextStyle:
                                    semiBold14TextStyle(postReactionController.myAllPlayedQuizList[index].obtainedMarks == 0 ? cRedColor : cPrimaryColor),
                              );
                            },
                          ),
                          if (postReactionController.myAllPlayedQuizList.isNotEmpty)
                            if (postReactionController.myAllPlayedQuizList.isNotEmpty &&
                                postReactionController.myAllPlayedQuizListScrolled.value &&
                                postReactionController.myAllPlayedQuizListSubLink.value != null)
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
  const MyDailyQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH20sizedBox,
        Text(
          ksTodaysQuiz.tr,
          style: semiBold18TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        CommonDailyAndPlayedQuiz(
          image:
              'https://images.unsplash.com/photo-1500076656116-558758c991c1?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          title: 'How to play golf',
          noOfQuestions: '12 questions',
          totalTime: 'Duration: 30 Sec',
          actionText: 'Tap to play',
          icon: BipHip.rightArrow,
          actionTextStyle: semiBold14TextStyle(cPrimaryColor),
          imageList: Get.find<PostReactionController>().quizParticipentList,
        ),
      ],
    );
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
  final List? imageList;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    image!,
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
                          TextSpan(text: "${ksCorrectAnswer.tr}: ${correctAnswer}/", style: regular12TextStyle(cBlackColor)),
                          TextSpan(text: "${totalQuestions}", style: regular12TextStyle(cSmallBodyTextColor)),
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
                                      imageList![i],
                                      fit: BoxFit.fill,
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
                    Container(
                      height: 72,
                      width: 56,
                    ),
                    if (image != null)
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
                                  image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    BipHip.imageFile,
                                    size: kIconSize40,
                                    color: cIconColor,
                                  ),
                                  loadingBuilder: imageLoadingBuilder,
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
                  // fit: FlexFit.loose,
                  Text(
                    quizTitle!,
                    style: semiBold14TextStyle(cBlackColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  kH4sizedBox,
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: [
                        TextSpan(text: "${ksCorrectAnswer.tr}: $correctAnswer!/", style: regular12TextStyle(cBlackColor)),
                        TextSpan(text: totalQuestions!, style: regular12TextStyle(cSmallBodyTextColor)),
                      ])),
                  kH4sizedBox,
                  Text(
                    "Completion Time: $totalTime",
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
                                                )),
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
                                    widget: Container(
                                        height: h24,
                                        width: h24,
                                        decoration: BoxDecoration(
                                          color: cWhiteColor,
                                          borderRadius: BorderRadius.circular(k8BorderRadius),
                                        )),
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
